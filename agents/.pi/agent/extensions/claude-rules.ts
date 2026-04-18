/**
 * Claude Rules Extension
 *
 * Scans the project's .claude/rules/ folder for rule files and lists them
 * in the system prompt. The agent can then use the read tool to load
 * specific rules when needed.
 *
 * Best practices for .claude/rules/:
 * - Keep rules focused: Each file should cover one topic (e.g., testing.md, api-design.md)
 * - Use descriptive filenames: The filename should indicate what the rules cover
 * - Use conditional rules sparingly: Only add paths frontmatter when rules truly apply to specific file types
 * - Organize with subdirectories: Group related rules (e.g., frontend/, backend/)
 *
 * Usage:
 * 1. Copy this file to ~/.pi/agent/extensions/ or your project's .pi/extensions/
 * 2. Create .claude/rules/ folder in your project root
 * 3. Add .md files with your rules
 */

import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

/**
 * Recursively find all .md files in a directory
 */
type RuleFile = {
	relativePath: string;
	path: string;
};

function findMarkdownFiles(dir: string, basePath: string = ""): string[] {
	const results: string[] = [];

	if (!fs.existsSync(dir)) {
		return results;
	}

	const entries = fs.readdirSync(dir, { withFileTypes: true });

	for (const entry of entries) {
		const relativePath = basePath ? `${basePath}/${entry.name}` : entry.name;

		if (entry.isDirectory()) {
			results.push(...findMarkdownFiles(path.join(dir, entry.name), relativePath));
		} else if (entry.isFile() && entry.name.endsWith(".md") && entry.name !== "README.md") {
			results.push(relativePath);
		}
	}

	return results;
}

function collectRules(dir: string): RuleFile[] {
	return findMarkdownFiles(dir).map((relativePath) => ({
		relativePath,
		path: path.join(dir, relativePath),
	}));
}

function formatRuleList(ruleFiles: RuleFile[]): string {
	return ruleFiles.map((rule) => `- ${rule.relativePath}`).join("\n");
}

export default function claudeRulesExtension(pi: ExtensionAPI) {
	let globalRules: RuleFile[] = [];
	let projectRules: RuleFile[] = [];

	pi.on("session_start", async (_event, ctx) => {
		const globalRulesDir = path.join(os.homedir(), ".claude", "rules");
		const projectRulesDir = path.join(ctx.cwd, ".claude", "rules");
		globalRules = collectRules(globalRulesDir);
		projectRules = collectRules(projectRulesDir);
		const totalRules = globalRules.length + projectRules.length;

		if (totalRules > 0) {
			ctx.ui.notify(`Found ${totalRules} rule(s) (${globalRules.length} global, ${projectRules.length} project)`, "info");
		}
	});

	pi.on("before_agent_start", async (event, ctx) => {
		if (globalRules.length === 0 && projectRules.length === 0) {
			return;
		}

		const sections: string[] = [];
		const globalRulesDir = path.join(os.homedir(), ".claude", "rules");
		const projectRulesDir = path.join(ctx.cwd, ".claude", "rules");

		if (globalRules.length > 0) {
			sections.push(`Global rules (${globalRulesDir}):\n${formatRuleList(globalRules)}`);
		}
		if (projectRules.length > 0) {
			sections.push(`Project rules (${projectRulesDir}):\n${formatRuleList(projectRules)}`);
		}

		return {
			systemPrompt:
				event.systemPrompt +
				`

## Rules

The following rule files are available:

${sections.join("\n\n")}

When working on tasks related to these rules, use the read tool to load the relevant files by their exact path under the listed rule directories.
Prefer project rules when both project and global rules are relevant.
`,
		};
	});
}

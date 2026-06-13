#!/bin/sh
# Claude Code statusLine integration.
# Add to ~/.claude/settings.json:
#   "statusLine": {
#     "type": "command",
#     "command": "bash $HOME/.claude/statusline-command.sh"
#   }

input=$(cat)

# "Sonnet" or "Claude" — first word of display_name, with effort level in parens if set
model=$(echo "$input" | jq -r '
  ((.model.display_name // "Claude") | split(" ")[0]) +
  (if .effort.level then "(\(.effort.level))" else "" end)
')

# Basename of the current working directory
dir=$(echo "$input" | jq -r '
  .workspace.current_dir // .cwd // "" | split("/")[-1]
')

# Context window usage: ctx:USEDk/MAXk(PCT%)
ctx=$(echo "$input" | jq -r '
  .context_window |
  if .context_window_size then
    "ctx:\(.total_input_tokens // 0 | . / 1000 | round)k/\(.context_window_size / 1000 | round)k(\(.used_percentage // 0 | round)%)"
  else "ctx:--" end
')

# 5-hour rate limit with time-until-reset label: Xh:PCT%, Xm:PCT%, now:PCT%, or empty
rate=$(echo "$input" | jq -r '
  .rate_limits.five_hour |
  if .used_percentage == null then empty
  elif .resets_at then
    ((.resets_at - now) as $s |
      (if $s > 3600 then "\($s / 3600 | floor)h"
       elif $s > 0  then "\($s / 60 | floor)m"
       else "now" end) + ":\(.used_percentage | round)%")
  else "5h:\(.used_percentage | round)%" end
')

# Join non-empty fields with a space
echo "$model $dir $ctx${rate:+ $rate}"

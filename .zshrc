# Add zint
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add Neovim
NVIM_DIR="/opt/nvim-linux64"
if [ ! -d "$NVIM_DIR" ]; then
    echo "Installing neovim,,,,"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz
    git clone git@github.com:matsuren/nvim-config.git ~/.config/nvim
    # git clone https://github.com/matsuren/nvim-config.git ~/.config/nvim
fi
export PATH="$PATH:$NVIM_DIR/bin"
alias vim="nvim"
export EDITOR="nvim"
export VISUAL="nvim"

# --- basic config ---
# emacs binding for ctrl+a, ctrl+e, etc.
bindkey -e
# avoid closing terminal by ctrl+d
ctrl-d() { zle -M "zsh: use 'exit' or ':q' to exit."; return 1 }
zle -N ctrl-d
bindkey '^D' ctrl-d
setopt ignoreeof
# Tab completion Note: ctrl+C to cancel
bindkey '^[[Z' reverse-menu-complete
zstyle ':completion:*' menu select
# Turn off all beeps
unsetopt BEEP
# Enable cd - Tab
setopt auto_pushd
setopt PUSHD_IGNORE_DUPS
# Rust
source "$HOME/.cargo/env"
export PATH="$PATH:$HOME/.local/bin"

# --- zinit ----
# theme
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zstyle :prompt:pure:path color green
zstyle :prompt:pure:prompt:success color cyan
export PURE_CMD_MAX_EXEC_TIME=2

# dircolor
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS
alias ls="ls --color=auto"

# command usefull
zinit light zsh-users/zsh-autosuggestions
zinit light z-shell/F-Sy-H  # Better than zsh-syntax-highlighting for bracket
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# sharkdp/fd
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd
# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat
# BurntSushi/ripgrep
zinit ice as"command" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
zinit light BurntSushi/ripgrep
# dandavision/delta
zinit ice as"command" from"gh-r" mv"delta* -> delta" pick"delta/delta"
zinit light dandavison/delta
# wfxr/forgit
zinit load wfxr/forgit

# fzf settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --color=always'
export FZF_DEFAULT_OPTS="--ansi --layout=reverse --tmux 80% --preview '(bat --color=always --theme=Nord {})'"
export FZF_CTRL_R_OPTS="--preview 'echo {} | fold -s'"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS=" --walker-skip .git,node_modules,target --preview 'tree -C {}'"
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --type f --hidden --follow --color=always --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat --color=always --theme=Nord {}' "$@" ;;
  esac
}

# abbr
zinit light olets/zsh-abbr
abbr -q -S :q="exit"
abbr -q -S gst="git status"
abbr -q -S gl="git log"
abbr -q -S ga="git add -p"
abbr -q -S gp="git push origin HEAD"
abbr -q -S ggrep="git grep --line-number '' | fzf --height 80% --delimiter : --preview 'bat --style=full --color=always --theme=Nord --highlight-line {2} {1}' --preview-window '~3,+{2}+3/2'"
# load zsh-abbr, then
chroma_single_word() {
  (( next_word = 2 | 8192 ))
  local __first_call="$1" __wrd="$2" __start_pos="$3" __end_pos="$4"
  local __style
  (( __first_call )) && { __style=${FAST_THEME_NAME}alias }
  [[ -n "$__style" ]] && (( __start=__start_pos-${#PREBUFFER}, __end=__end_pos-${#PREBUFFER}, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[$__style]}")
  (( this_word = next_word ))
  _start_pos=$_end_pos
  return 0
}
register_single_word_chroma() {
  local word=$1
  if [[ -x $(command -v $word) ]] || [[ -n $FAST_HIGHLIGHT["chroma-$word"] ]]; then
    return 1
  fi

  FAST_HIGHLIGHT+=( "chroma-$word" chroma_single_word )
  return 0
}
if [[ -n $FAST_HIGHLIGHT ]]; then
  for abbr in ${(f)"$(abbr list-abbreviations)"}; do
    if [[ $abbr != *' '* ]]; then
      register_single_word_chroma ${(Q)abbr}
    fi
  done
fi

# Add tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tpm,,,,"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
fi

# history
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=50000
export SAVEHIST=100000
# https://dev.to/sso/cant-recall-everything-you-type-4kg3
# Remove older duplicate entries from history.
setopt hist_ignore_all_dups
# Expire A Duplicate Event First When Trimming History.
setopt hist_expire_dups_first
# Do Not Record An Event That Was Just Recorded Again.
setopt hist_ignore_dups
# Remove superfluous blanksfrom history items.
setopt hist_reduce_blanks
# Do Not Display A Previously Found Event.
setopt hist_find_no_dups
# Do Not Record An Event Starting With A Space.
setopt hist_ignore_space
# Do Not Write A Duplicate Event To The History File.
setopt hist_save_no_dups
# Do Not Execute Immediately Upon History Expansion.
setopt hist_verify
# Allow multiple sessions append to one zsh command history.
setopt append_history
# Show Timestamp In History.
setopt extended_history
# Write to history file immediately, not after shell exit.
setopt inc_append_history
# Share history between different instances of the shell.
setopt share_history
setopt hist_reduce_blanks
setopt hist_no_store

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

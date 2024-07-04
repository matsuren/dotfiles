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
    git clone https://github.com/matsuren/nvim-config.git ~/.config/nvim
fi
export PATH="$PATH:$NVIM_DIR/bin"
alias vim="nvim"

# Add tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tpm,,,,"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ln -s ~/dev/dotfiles/.tmux.conf ~/.tmux.conf
fi
# fzf usage apt-cache show fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Rust
source "$HOME/.cargo/env"

# theme
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zstyle :prompt:pure:path color green
zstyle :prompt:pure:prompt:success color cyan

# color
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS
alias ls="ls --color=auto"

# command usefull
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

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

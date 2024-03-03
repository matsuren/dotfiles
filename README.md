Setup vim, bash, and tmux.

```bash
# Capslock to control, /etc/default/keyboard  XKBOPTIONS="ctrl:nocaps"
sudo apt install vim tmux tree

# Better not to add at the moment. purity looks good.
# Bash prompt. This replaces ~/.bashrc. Check https://github.com/ohmybash/oh-my-bash before running
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
# or
# sh ~/.vim_runtime/install_basic_vimrc.sh  

git clone https://github.com/gpakosz/.tmux.git ~/dev/tmux_conf
ln -s -f ~/dev/tmux_conf/.tmux.conf ~/.tmux.conf
cp ~/dev/tmux_conf/.tmux.conf.local ~/.tmux.conf.local
# .tmux.conf.local -> Mouse mode on: set -g mouse on

# LS_COLORS
git clone https://github.com/trapd00r/LS_COLORS ~/dev/LS_COLORS

#fzf Tips: **, ctrl+r, alt+c, ctrl+t
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```


Add the following in `.bashrc`
```bash
# My Custom
export VISUAL=vim
export EDITOR=vim
bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'
source ~/dev/LS_COLORS/lscolors.sh
```


Tips for Mozc Japanese input
- DirectInput: Activate IME
- Precomposition: Deactivate IME
- Composition: Deactivate IME
- Conversion: Deactivate IME
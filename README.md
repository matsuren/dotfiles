Setup vim, bash, and tmux.

```bash
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
# Generated based on `vivid generate molokai` from https://github.com/sharkdp/vivid
export LS_COLORS='rs=0:ex=1;38;2;255;92;87:so=0;38;2;0;0;0;48;2;255;106;193:mh=0:*~=0;38;2;102;102;102:no=0:mi=0;38;2;0;0;0;48;2;255;92;87:ca=0:cd=0;38;2;255;106;193;48;2;51;51;51:tw=0:pi=0;38;2;0;0;0;48;2;87;199;255:st=0:bd=0;38;2;154;237;254;48;2;51;51;51:sg=0:ln=0;38;2;255;106;193:or=0;38;2;0;0;0;48;2;255;92;87:do=0;38;2;0;0;0;48;2;255;106;193:fi=0:su=0:di=0;38;2;87;199;255'
```

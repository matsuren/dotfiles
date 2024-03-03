Setup vim, bash, and tmux.

```bash
sudo apt install vim tmux tree
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


`.bashrc`
```bash
# My Custom
export VISUAL=vim
export EDITOR=vim
bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'
```

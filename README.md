Setup vim, bash, and tmux.

```bash
# In .bashrc
# export VISUAL=vim
# export EDITOR=vim

sudo apt install vim tmux
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

git clone https://github.com/gpakosz/.tmux.git ~/dev/tmux_conf
ln -s -f ~/dev/tmux_conf/.tmux.conf ~/.tmux.conf
cp ~/dev/tmux_conf/.tmux.conf.local ~/.tmux.conf.local
# .tmux.conf.local -> Mouse mode on: set -g mouse on
```


Install and setup vim.

```bash
sudo apt install vim zsh tmux openssh-server python3-pip
sudo pip3 install percol
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
```

`which zsh` to check the location, and change default using `chsh`.

Reopen the terminal.
```bash
mkdir ~/dev
cd ~/dev
git clone https://github.com/matsuren/dotfiles.git
cp -f dotfiles/.zshrc ~/
cp -f dotfiles/.zprofile ~/
cp -f dotfiles/.zpreztorc ~/

git clone https://github.com/gpakosz/.tmux.git ~/dev/tmux_conf
ln -s -f ~/dev/tmux_conf/.tmux.conf ~/.tmux.conf
cp ~/dev/tmux_conf/.tmux.conf.local ~/.tmux.conf.local

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```



```bash
# Capslock to control, /etc/default/keyboard  XKBOPTIONS="ctrl:nocaps"
# Setup startup to disable middle buttom click paste
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false

# Install packages
sudo apt install zsh git curl htop tmux ibus-mozc xsel
ibus restart
sudo snap install code --classic
# Better to install newer version of fzf. 0.53.0 (c4a9ccd) now
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install tmux-mem-cpu-load
git clone https://github.com/thewtex/tmux-mem-cpu-load.git $HOME/.local/share/tmux-mem-cpu-load
cd $HOME/.local/share/tmux-mem-cpu-load
cmake . -DCMAKE_INSTALL_PREFIX=$HOME/.local
make install

# Install nerd fonts for lualine.nvim
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf

# Lid switch: HandleLidSwitch=suspend
sudo vim /etc/systemd/logind.conf

mkdir ~/dev
cd ~/dev
git clone git@github.com:matsuren/dotfiles.git
ln -s ~/dev/dotfiles/.zshrc ~/.zshrc

chsh -s $(which zsh)
```


Tips for Mozc Japanese input
- DirectInput: Activate IME
- Precomposition: Deactivate IME
- Composition: Deactivate IME
- Conversion: Deactivate IME

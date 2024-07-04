
```bash
# Capslock to control, /etc/default/keyboard  XKBOPTIONS="ctrl:nocaps"
# Setup startup to disable middle buttom click paste
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false

# Install packages
sudo apt install zsh git fzf curl htop tmux ibus-mozc
ibus restart
sudo snap install code --classic

mkdir ~/dev
cd ~/dev
git clone git@github.com:matsuren/dotfiles.git
ln -s ~/dev/dotfiles/.zshrc ~/.zshrc

which zsh
chsh
```


Tips for Mozc Japanese input
- DirectInput: Activate IME
- Precomposition: Deactivate IME
- Composition: Deactivate IME
- Conversion: Deactivate IME
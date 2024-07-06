
```bash
# Capslock to control, /etc/default/keyboard  XKBOPTIONS="ctrl:nocaps"
# Setup startup to disable middle buttom click paste
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false

# Install packages
sudo apt install zsh git fzf curl htop tmux ibus-mozc xsel
ibus restart
sudo snap install code --classic

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

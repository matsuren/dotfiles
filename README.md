Install ansible
```
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install --include-deps ansible
```


Run
```
cd
git clone git@github.com:matsuren/dotfiles.git
cd dotfiles
ansible-playbook -i inventory.ini playbooks/main.yml -K
stow -v zsh tmux rg atuin
chsh -s $(which zsh)
```


Below is previous info

```bash
# Capslock to control, /etc/default/keyboard  XKBOPTIONS="ctrl:nocaps"
# Setup startup to disable middle button click paste
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false

# Install packages
sudo apt install zsh git git-gui curl htop tmux ibus-mozc xsel stow
ibus restart
sudo snap install code --classic
# Better to install newer version of fzf. 0.53.0 (c4a9ccd) now
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
# cargo binstall
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall ripgrep fd-find bat git-delta

# savedra1/clipse
go install github.com/savedra1/clipse@v1.1.0

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

cd
git clone git@github.com:matsuren/dotfiles.git
stow -v zsh tmux rg
chsh -s $(which zsh)
```



Tips for Mozc Japanese input
- DirectInput: Activate IME
- Precomposition: Deactivate IME
- Composition: Deactivate IME
- Conversion: Deactivate IME

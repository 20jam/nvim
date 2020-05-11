# This script need rework to support another OS

# Install Ruby
sudo pacman -S ruby ---noconfirm
sudo chown -R $(whoami) /usr/local/bin
# Install bundler
gem install bundler
# Install neovim support
gem install neovim


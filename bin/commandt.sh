# This script need rework to support another OS

# Install Ruby
sudo pacman -S ruby ---noconfirm
sudo chown -R $(whoami) /usr/local/bin
# Install bundler and neovim
gem install bundler
gem install neovim

# Other requirements

pip install commandt.score
pip install redis

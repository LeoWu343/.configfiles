#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

CYAN='\033[0;36m'
NC='\033[0m'

# copy configuration files
cp $DIR/tmux.conf ~/.tmux.conf
cp $DIR/vimrc ~/.vimrc

# create vim backup and swap folders
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/backup

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install Xcode (requires input) if it's not installed
brew install mas

# get user to sign in to App Store
printf "\n${CYAN}Log in to the App Store now if you have not done so yet.${NC}\n"
read -p "Press ENTER to continue"

if mas list | grep -q Xcode; then
  printf "Xcode is already installed, continuing\n"
else
  mas install 497799835
fi
# accept Xcode license
sleep 5
sudo xcodebuild -license accept

# if using this script on a fresh install, you may need to open Xcode to allow it to install additional components
printf "\n${CYAN}If you are on a fresh install, you may need to open Xcode to obtain additional components that are required for the rest of this script. Please do so now.${NC}\n"
read -p "Press ENTER to continue"

# install Apple Command Line Tools
xcode-select --install

# fix some weird problem with Xcode and CLT
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# install packages
# tools: macvim, zsh, git, tmux, fasd
# dependencies: reattach-to-user-namespace (vim copy and paste), cmake (vim plugin YouCompleteMe), ctags (vim plugin Tagbar)
brew install macvim --with-override-system-vim
brew install zsh git tmux fasd reattach-to-user-namespace cmake ctags
# get brew rmtree
brew tap beeftornado/rmtree
# install programs
brew cask install google-chrome slack java

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
  echo "Could not install Oh My Zsh" >/dev/stderr
  exit 1
}

# add custom configuration
cp $DIR/zshrc ~/.oh-my-zsh/custom/zshrc.zsh


#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

CYAN='\033[0;36m'
NC='\033[0m'

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
# dependencies: cmake (vim plugin YouCompleteMe), ctags (vim plugin Tagbar)
brew install macvim zsh git tmux fasd ack cmake ctags
# get brew rmtree
brew tap beeftornado/rmtree

$DIR/install.sh


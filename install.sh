#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

tmux_install() {
  # copy tmux configuration file
  cp $DIR/tmux.conf ~/.tmux.conf
}

vim_install() {
  # copy vim configuration file
  cp $DIR/vimrc ~/.vimrc

  # create vim backup and swap folders
  mkdir -p ~/.vim/swap
  mkdir -p ~/.vim/backup
}

zsh_install() {
  # install oh-my-zsh if it's not already
  if [ ! -d ~/.oh-my-zsh ] ; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
      echo "Could not install Oh My Zsh" > /dev/stderr
      exit 1
    }
  fi

  # add custom configuration
  cp -r $DIR/zshrc/* ~/.oh-my-zsh/custom/
}

main() {
  if [ $# -gt 0 ] ; then
    for arg in "$@" ; do
      case "${arg}" in
        tmux) tmux_install ;;
        vim) vim_install ;;
        zsh) zsh_install ;;
        *) error "Unexpected argument: ${arg}" ;;
      esac
    done
  else
    tmux_install ; vim_install ; zsh_install
  fi
}

main "$@"


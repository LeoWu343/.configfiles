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

bash_install() {
  cp $DIR/bashrc ~/.bashrc
  mkdir -p ~/.bash_config && cp -R $DIR/bash_config/. ~/.bash_config
}

main() {
  if [ $# -gt 0 ] ; then
    for arg in "$@" ; do
      case "${arg}" in
        tmux) tmux_install ;;
        vim) vim_install ;;
        bash) bash_install ;;
        *) error "Unexpected argument: ${arg}" ;;
      esac
    done
  else
    tmux_install ; vim_install ; bash_install
  fi
}

main "$@"


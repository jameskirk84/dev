#!/usr/bin/env bash

srcDir=/vagrant/home
destDir=/home/vagrant

main(){
  apt-get update
  apt-get -y install git
  apt-get -y install silversearcher-ag
  link_bash_files
  link_vim_files
  link_git_files
  clone_git_submodules
  vim_plugin_vimproc_make
}

link_bash_files(){
  symlink_file $srcDir/bash_profile $destDir/.bash_profile
}

link_vim_files(){
  symlink_file $srcDir/vimrc $destDir/.vimrc
  symlink_dir $srcDir/vim $destDir/.vim 
}

link_git_files(){
  symlink_file $srcDir/gitconfig $destDir/.gitconfig
}

clone_git_submodules(){
  pushd .
  cd $srcDir
  git submodule update --init
  popd
}

vim_plugin_vimproc_make(){
  pushd .
  cd $srcDir/vim/bundle/vimproc.vim
  make
  popd
}

symlink_file(){
  if [ ! -f $2 ]; then
    ln -s $1 $2
  fi
}

symlink_dir(){
  if [ ! -d $2 ]; then
    ln -s $1 $2
  fi
}

main

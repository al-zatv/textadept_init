#!/bin/bash
# shell safe code (https://sipb.mit.edu/doc/safe-shell/)
set -eu -o pipefail ; shopt -s failglob

set -e
set -x

if [ "$1" = "--install" ]; then
  mkdir -p $HOME/tools/textadeptx
  cd $HOME/tools
  wget https://foicica.com/textadept/download/textadept_LATEST.x86_64.tgz
  tar zxvf textadept_LATEST.x86_64.tgz
  rm textadept_LATEST.x86_64.tgz
  [ -f $PWD/textadept*/textadept-curses ] || { echo "check tools directory. need only one textadept*/textadept-turses"; exit 1; }
  ln -s $PWD/textadept* textadept
else
  echo "--install not specified,so not installing"
fi

echo "selecting"
TADIR=~/tools/textadept
[ -f $TADIR/textadept-curses ] || { echo "Not installed in proper way! check $TADIR!"; exit 1;}
sudo ln -s $TADIR/textadept /usr/bin/tag
sudo ln -s $TADIR/textadept-curses /usr/bin/ta
echo "check ta and tag:"
ls -l /usr/bin/ta* # check
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/ta 90 
sudo update-alternatives --config editor # check
echo "select ta:"
select-editor # select /usr/bin/ta

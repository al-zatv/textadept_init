#!/bin/bash
set -e
set -x

echo "Starting"
TADIR=~/tools/textadept
sudo ln -s $TADIR/textadept /usr/bin/tag
sudo ln -s $TADIR/textadept-curses /usr/bin/ta
echo "check ta and tag:"
ls -l /usr/bin/ta* # check
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/ta 90 
sudo update-alternatives --config editor # check
echo "select ta:"
select-editor # select /usr/bin/ta
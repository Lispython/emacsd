#!/bin/bash

CURRENT_PATH=$(pwd)
VENV="$CURRENT_PATH/venv"
PIP_PATH="$VENV/bin/pip"
EMACS=emacs
PYTHON="$VENV/bin/python"

echo $VENV
echo $CURRENT_PATH
echo $PIP_PATH
echo $PYTHON

virtualenv --python=python2.7 --no-site-packages --clear $VENV
source "$VENV/bin/activate"

$VENV/bin/easy_install pip
$PIP_PATH install -U ipython

#$PIP_PATH install -E venv  http://pymacs.progiciels-bpi.ca/archives/Pymacs-0.23.tar.gz
$PIP_PATH install -U -e hg+http://bitbucket.org/agr/rope#egg=rope
rm -rf /tmp/rope
mkdir /tmp/rope && cd /tmp/rope
hg clone http://bitbucket.org/agr/ropemacs
hg clone http://bitbucket.org/agr/ropemode
git clone https://github.com/Lispython/Pymacs.git
ln -s ../ropemode/ropemode ropemacs/
$PIP_PATH install -U /tmp/rope/ropemacs

cd /tmp/rope/Pymacs/

PYSETUP="$PYTHON $(pwd)/setup.py"
PPPP="$PYTHON $(pwd)/pppp -C $(pwd)/ppppconfig.py"

echo $PYSETUP
echo $PPPP

#$PPPP *.in Pymacs contrib tests
#$PYSETUP install
# Нихрена не работает из bash скрипта
# При ручном запуске из консоли все ОК
make all
make install
cp pymacs.el ~/.emacs.d/pymacs.el
rm -f ~/.emacs.d/pymacs.elc

#$PIP_PATH install -E $VENV -U /tmp/rope/Pymacs
#./venv/bin/pip install -E venv -e svn+http://myrepo/svn/MyApp#egg=MyApp

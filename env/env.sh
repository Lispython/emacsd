#!/bin/bash

# buildenv.sh
# ~~~~~~~~~~

# Bash helpers for virtualenv creation

# :copyright: (c) 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/buildenv.sh

PYTHON_VERSION="$1"

# shift 1

PARAMS="${@:3}"

empty_command(){
    echo "Empty command";
    #pyenv versions
}

flake8(){
    COMMAND="$(pyenv prefix $PYTHON_VERSION)/bin/flake8 $PARAMS"
    ${COMMAND}
    # $(pyenv prefix 2.7)/bin/flake8

}

case $2 in
	"flake8") flake8;;

	*) empty_command;;
esac

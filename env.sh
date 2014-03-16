#!/bin/sh

REQ_FILE=./req.txt

if [ ! -d "./buildenv.sh" ]; then

	curl https://raw.github.com/Lispython/buildenv.sh/master/buildenv.sh > ./buildenv.sh

fi

. ./buildenv.sh

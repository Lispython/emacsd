clean-elc:
	@echo "Remove elc/pyc/pyo files"
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*.elc' -exec rm -f {} +
	find . -name '*.el~' -exec rm -f {} +

env:
	@echo "Build environment"
	./env.sh dev_py
	./env.sh js

compile:
	@echo "Build elc"
	emacs --batch --eval '(byte-recompile-directory "~/.emacs.d")'

activate:
	. venv/bin/activate

init:
	echo "Editor configuration"
	@make update-submodules
	cd magit && $(MAKE) && cd ..
	@make env
	@build-pymacs

update-submodules:
	echo "Update submodules"

	git submodule update --init
	cd ext/auto-complete && git submodule update --init && cd ../../

CUR_DIR = $(shell pwd)
VENV_PATH = $(CUR_DIR)/venv
PIP_PATH = $(VENV_PATH)/bin/pip
PYTHON = $(VENV_PATH)/bin/python

build-pymacs:

	@make activate
	cd /tmp/ && rm -rf Pymacs && git clone https://github.com/Lispython/Pymacs.git && cd Pymacs

	@echo "Install Pymacs"

	cd /tmp/Pymacs/ && $(PYTHON) /tmp/Pymacs/setup.py install --quiet
	cd /tmp/Pymacs && $(PYTHON) /tmp/Pymacs/pppp -C /tmp/Pymacs/ppppconfig.py  Pymacs.py.in pppp.rst.in pymacs.el.in pymacs.rst.in contrib tests

	@echo "pymacs.el generated"
	cp /tmp/Pymacs/pymacs.el ~/.emacs.d/pymacs.el


docker-build:
	@echo "Build docker packages"
	# docker build  --rm -t emacsd ./
	docker build --rm -t emacsd --file=./env/Dockerfile ./env/

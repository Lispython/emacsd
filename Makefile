clean-elc:
	@echo "Remove elc/pyc/pyo files"
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*.elc' -exec rm -f {} +

env:
	@echo "Build environment"
	./env.sh dev_py
	./env.sh js

compile:
	@echo "Build elc"

activate:
	. venv/bin/activate

init:
	echo "Editor configuration"
	@make update-submodules
	cd magit && $(MAKE) $@

update-submodules:
	echo "Update submodules"

	git submodule update --init
	cd ext/auto-complete && git submodule update --init && cd ../../

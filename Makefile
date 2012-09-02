clean-elc:
	@echo "Remove elc/pyc/pyo files"
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*.elc' -exec rm -f {} +

env:
	@echo "Build environment"

compile:
	@echo "Build elc"

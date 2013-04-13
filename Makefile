all:
	@echo "No default step. Use setup.py"
	@echo ""
	@echo " Other targets:"
	@echo ""
	@echo "   - docs"
	@echo "   - full"
	@echo ""
	@echo "   - dev (test & flake)"
	@echo "   - flake"
	@echo "   - test"
	@echo "   - diff"
	@echo "   - tox"
	@echo "   - d"
	@echo "   - r"
	@echo ""

docs:
	make -C docs html

upload: r
	python setup.py sdist upload

full: d tox docs

venv:
ifeq (,$(findstring hy,$(VIRTUAL_ENV)))
	@echo "You're not in a Hy virtualenv. FOR SHAME"
	exit 1
else
	@echo "We're properly in a virtualenv. Going ahead."
endif

dev: test flake

test: venv
	nosetests -sv

tox: venv
	tox

flake:
	flake8 hy

clear:
	clear

d: clear dev

diff:
	git diff --color | less -r

r: d tox diff


.PHONY: docs

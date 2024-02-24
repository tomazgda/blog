# Makefile for my blog

all: publish

publish: publish.el elm/src/Cube.elm
	@echo "Compiling Elm to Javascript"
	cd elm && elm make src/Cube.elm --output=cube.js && cd ..
	@echo "Publishing... with --no-init."
	emacs -Q --script publish.el

clean:
	@echo "Cleaning up.."
	@rm -rvf *.elc
	@rm -rvf public
	@rm -rvf ~/.org-timestamps/*

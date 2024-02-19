# Makefile for my blog

all: publish

publish: publish.el
	@echo "Publishing... with --no-init."
	emacs -Q --script publish.el

clean:
	@echo "Cleaning up.."
	@rm -rvf *.elc
	@rm -rvf public
	@rm -rvf ~/.org-timestamps/*

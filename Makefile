SHELL     := bash
MAKEFLAGS += --warn-undefined-variables
.SILENT:

LOUD = \033[1;34m#
SOFT = \033[0m#

pull: ## update from main
	git pull

push: ## commit to main
	- echo -en "$(LOUD)Why this push? $(SOFT)" 
	- read x ; git commit -am "$$x" ;  git push
	- git status

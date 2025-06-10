SHELL     := bash
MAKEFLAGS += --warn-undefined-variables
.SILENT:

SHOUT = \033[1;34m#
QUIET = \033[0m#

Top=$(shell git rev-parse --show-toplevel)

help:  ## show help
	gawk 'BEGIN { FS   = ":.*## "; print "\nmake [WHAT]" }              \
	      /^[^ \t].*##/ {                                                \
	        printf("   $(SHOUT)%-15s$(QUIET) : %s\n", $$1, $$2) | "sort"} \
	' $(MAKEFILE_LIST)

pull: ## update from main
	git pull

push: ## commit to main
	- echo -en "$(SHOUT)Why this push? $(QUIET)" 
	- read x ; git commit -am "$$x" ;  git push
	- git status

sh: ## run my shell
	Top=$(Top) bash --init-file $(Top)/etc/init.sh -i
	
T=cd $(Top)/tests; python3 -B

all: o csv cols

o    :; $T lib.py o
csv  :; $T lib.py csv
cols :; $T data.py cols
	

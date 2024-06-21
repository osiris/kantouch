SHELL:=/bin/bash

PRJ_OWNR ?= osiux
PRJ_GRUP ?= osiux
PRJ_NAME ?= kantouch
PRJ_DESC ?= $$(cat .description 2>/dev/null || echo $(PRJ_NAME))
PRJ_TAGS ?= Console,KanBan,Python,Terminal,TUI,TouchScreen,Productivity
GIT_HOST ?= gitlab.com
GIT_REPO ?= https://$(GIT_HOST)/$(PRJ_OWNR)/$(PRJ_NAME).git
DIR_BASE ?= ~/git/$(PRJ_OWNR)
DIR_KNTC ?= $(DIR_BASE)/$(PRJ_NAME)
DIR_VENV ?= ~/.venv/$(PRJ_NAME)

run:
	source $(DIR_VENV)/bin/activate && ./$(PRJ_NAME)

git_clone:
	mkdir -p $(DIR_BASE)
	[[ -d $(DIR_KNTC) ]] || git clone $(GIT_REPO) $(DIR_KNTC)

git_repo:
	command -v glab >/dev/null && glab repo create --name "$(PRJ_NAME)" \
		--defaultBranch main \
		--description "$(PRJ_DESC)" \
		--tag "$(PRJ_TAGS)" \
		--group "$(PRJ_GRUP)" \
		--public

venv_build:
	sudo apt install python3-venv
	mkdir -p $(DIR_VENV)
	python3 -m venv $(DIR_VENV)

venv_install:
	source $(DIR_VENV)/bin/activate && pip3 install textual

venv_install_dev:
	source $(DIR_VENV)/bin/activate && pip3 install textual_dev

venv_install_all:
	source $(DIR_VENV)/bin/activate && pip3 install textual textual_dev

venv_setup: venv_build venv_install

textual_diagnose:
	source $(DIR_VENV)/bin/activate && textual diagnose

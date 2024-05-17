.PHONY: playbook run-all

INVENTORY := hosts.yml
PLAYBOOK := main.yml

# Default tag to run
DEFAULT_TAG := app
ifeq ($(TAG),)
    TAG_PARAM := --tags $(DEFAULT_TAG)
else
    TAG_PARAM := --tags $(TAG)
endif

# Conditionally set verbosity based on the DEBUG flag
DEBUG ?= 0
ifeq ($(DEBUG),1)
    VERBOSITY := -vvv
else
    VERBOSITY :=
endif


playbook:
	ansible-playbook -K -i $(INVENTORY) $(PLAYBOOK) $(TAG_PARAM) $(VERBOSITY)

run-all:
	ansible-playbook -K -i $(INVENTORY) $(PLAYBOOK) $(VERBOSITY)

requirements:
	./setup.sh
	ansible-galaxy collection install -r requirements.yml
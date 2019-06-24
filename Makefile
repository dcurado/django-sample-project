#
# Constants
#
VENV   = $(PWD)/.venv
PYTHON = $(VENV)/bin/python
PIP    = $(VENV)/bin/pip
DJANGO = $(VENV)/bin/django-admin

#
# Targets
#
all: $(VENV)
clean: py-clean
	find "$(PWD)" -iname '*.sqlite3' -delete
	-rm -rf python/*.egg-* build/ dist/

$(VENV):
	python3 -m venv "$(VENV)"
install develop: $(VENV)
	$(PYTHON) setup.py "$@"

#
# Django
#
DJANGO_SETTINGS_MODULE = ilfp.settings
PYTHONPATH := $(PYTHONPATH):$(PWD)/python
export DJANGO_SETTINGS_MODULE PYTHONPATH

runserver migrate clearsessions: $(VENV)
	@$(DJANGO) "$@"
makemigrations: $(VENV)
	find "$(PWD)/python" -iname 'models.py' | xargs -I'{}' dirname '{}' \
		| xargs -I'{}' basename '{}' | sort -u | xargs $(DJANGO) "$@"
developuser: $(VENV)
	@echo "Username: testing"
	$(DJANGO) createsuperuser --username=testing --email=testing@example.org
py-clean:
	find $(PWD) -iname '*.py[cod]' -delete
	find $(PWD) -iname '__pycache__' | xargs rm -rf

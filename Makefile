PREFIX ?= $(HOME)
BINDIR := $(PREFIX)/bin

.PHONY: help install uninstall lint test

help:
	@echo "make install    Install whoison to $(BINDIR)"
	@echo "make uninstall  Remove it"
	@echo "make lint       Run shellcheck"
	@echo "make test       Run smoke tests"

install:
	mkdir -p $(BINDIR)
	install -m 0755 bin/whoison $(BINDIR)/whoison
	@echo "Installed: $(BINDIR)/whoison"

uninstall:
	rm -f $(BINDIR)/whoison

lint:
	shellcheck -S warning bin/whoison tests/*.sh

test:
	bash tests/smoke_test.sh

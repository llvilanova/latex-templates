PDFLATEX ?= pdflatex


.PHONY: force
force:


ifeq ($(MAKEFILE_LIST),Makefile)
help:: TPLDIR = $(CURDIR)/src/templates.ins
else
help:: TPLDIR = $(strip $(foreach mf,$(MAKEFILE_LIST),$(wildcard $(dir $(mf))/src/templates.ins)))
endif
help:: TPLDIR := $(abspath $(TPLDIR)/../../)
help:: force
	@echo "latex-template targets:"
	@echo "   templates-dtx   : rebuild LaTeX sources and documentation"
	@echo ""
	@echo "Read '$(TPLDIR)/templates.pdf' for some brief documentation of"
	@echo "the available LaTeX helper classes."
	@echo ""


ifeq ($(MAKEFILE_LIST),Makefile)
templates-dtx: TPLDIR = $(CURDIR)/src/templates.ins
else
templates-dtx: TPLDIR = $(strip $(foreach mf,$(MAKEFILE_LIST),$(wildcard $(dir $(mf))/src/templates.ins)))
endif
templates-dtx: TPLDIR := $(abspath $(TPLDIR)/../../)
templates-dtx: force
	rm -f `find "$(TPLDIR)" -maxdepth 1 -mindepth 1 -type f -name templates.* -not -name templates.pdf`
	rm -Rf "$(TPLDIR)/tex"
	mkdir -p "$(TPLDIR)/tex"
	(cd "$(TPLDIR)" && "$(PDFLATEX)" src/templates.ins)
	(cd "$(TPLDIR)" && "$(PDFLATEX)" src/templates.dtx)
	rm -f `find "$(TPLDIR)" -maxdepth 1 -mindepth 1 -type f -name templates.* -not -name templates.pdf`

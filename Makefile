builddir = build
arxivFileName = paper

.PHONY: all arxiv

all: $(builddir)/paper.pdf $(builddir)/$(arxivFileName).pdf

arxiv: $(builddir)/$(arxivFileName).tar.gz

$(builddir)/%.pdf: %.tex
	latexmk $*

$(builddir)/%.tar.gz: TEXINPUTS = .:build:sty:fig: # this is only used for bundledoc and include all dirs listed in the tex file
$(builddir)/%.tar.gz: $(builddir)/%.pdf %.tex
	TEXINPUTS=$(TEXINPUTS) bundledoc --exclude=$(builddir)/$*.out --manifest='' --localonly --texfile=$*.tex $(builddir)/$*.dep

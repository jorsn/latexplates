main_name = paper
arxivFileName = ms
builddir = build

.PHONY: all arxiv clean

all: $(builddir)/$(main_name).pdf $(builddir)/$(arxivFileName).pdf

arxiv: $(builddir)/$(arxivFileName).tar.gz

$(builddir)/%.pdf: %.tex
	latexmk $*

$(builddir)/%.tar.gz: TEXINPUTS = .:$(builddir):sty:fig: # this is only used for bundledoc and include all dirs listed in the tex file
$(builddir)/%.tar.gz: $(builddir)/%.pdf %.tex
	TEXINPUTS=$(TEXINPUTS) bundledoc --exclude=$(builddir)/$*.out --manifest='' --localonly --texfile=$*.tex $(builddir)/$*.dep

clean:
	rm -fr $(builddir)

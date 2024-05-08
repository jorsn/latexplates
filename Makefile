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

ssh-cocalc: ssh-%:
	ssh "$$(git remote get-url $* | sed 's/\(@[^:]\+\)\(:.*\)\?$$/\1/g')"

start-cocalc:
	@regex='^([a-z0-9]{8})([a-z0-9]{4})([a-z0-9]{4})([a-z0-9]{4})([a-z0-9]+)@ssh.cocalc.com.*$$'; \
	 project_id=$$(git remote get-url cocalc | sed -E s/"$$regex"/'\1-\2-\3-\4-\5/'); \
	 if [ -r cocalc_api_key ]; then \
	   curl -u $$(< cocalc_api_key): -d bash=true -d command=true -d project_id=$$project_id https://cocalc.com/api/v1/project_exec; \
	 else \
	   echo "error: can't connect to cocalc: file cocalc_api_key does not exist." >&2; \
	   exit 1; \
	 fi

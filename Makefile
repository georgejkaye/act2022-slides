MAIN=main.tex
SECTIONS=$(wildcard sections/*.tex)
AUX=
SOURCE=$(MAIN) $(SECTIONS) $(AUX)
ROOTS=$(wildcard main-*.tex)

.PHONY: clean all presentation static init

all: presentation static

presentation: main-presentation.pdf
static: main-static.pdf

init:
	git submodule update --init

main-%.pdf: main-%.tex $(MAIN) $(SECTIONS) $(AUX)
	latexmk -pdf $(basename $@).tex

tidy:
	@for tex in $(ROOTS); do \
		latexmk -c $(tex); \
	done

clean: 
	@for tex in $(ROOTS); do \
		latexmk -C $(tex); \
	done
	rm -f *run.xml *vtc *bbl *synctex.gz
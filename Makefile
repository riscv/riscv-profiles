HEADER=profiles.adoc
DOC_PDF=$(HEADER:%.adoc=%.pdf)

all: $(DOC_PDF)

%.pdf : %.adoc
	asciidoctor-pdf \
	-r asciidoctor-diagram \
	-a toc \
	-a compress \
	-a pdf-style=docs-resources/themes/riscv-pdf.yml \
	-a pdf-fontsdir=docs-resources/fonts \
	--failure-level=ERROR \
	-o $@ $<

clean:
	rm -f $(DOC_PDF)

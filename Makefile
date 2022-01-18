HEADER=profiles.adoc
DOC_PDF=$(HEADER:%.adoc=%.pdf)
DOC_HTML=$(HEADER:%.adoc=%.html)

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

html: $(DOC_HTML)
	open $(DOC_HTML)

$(DOC_HTML): $(HEADER)
	asciidoctor -o $@ $<

clean:
	rm -f $(DOC_PDF)

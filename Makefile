HEADER=profiles.adoc
DOC_PDF=$(HEADER:%.adoc=%.pdf)

all: $(DOC_PDF)

%.pdf : %.adoc
	asciidoctor-pdf -v \
	-r asciidoctor-diagram \
	-a toc \
	-a compress \
	-a pdf-style=resources/riscv-themes/riscv-pdf.yml \
	-a pdf-fontsdir=resources/riscv-fonts \
	-o $@ $<

clean:
	rm -f $(DOC_PDF)

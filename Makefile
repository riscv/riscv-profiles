# Makefile for RISC-V Doc Template
#
# This work is licensed under the Creative Commons Attribution-ShareAlike 4.0
# International License. To view a copy of this license, visit
# http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to
# Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
#
# SPDX-License-Identifier: CC-BY-SA-4.0
#
# Description:
# 
# This Makefile is designed to automate the process of building and packaging 
# the Doc Template for RISC-V Extensions.

DOCKER_RUN := docker run --rm -v ${PWD}:/build -w /build \
riscvintl/riscv-docs-base-container-image:latest

HEADER_SOURCE := profiles.adoc
PDF_RESULT := $(HEADER_SOURCE:%.adoc=%.pdf)
HTML_RESULT := $(HEADER_SOURCE:%.adoc=%.html)

ASCIIDOCTOR_PDF := asciidoctor-pdf
ASCIIDOCTOR_HTML := asciidoctor

OPTIONS := --trace \
           -a compress \
           -a mathematical-format=svg \
           -a pdf-fontsdir=docs-resources/fonts \
           -a pdf-style=docs-resources/themes/riscv-pdf.yml \
           --failure-level=ERROR

REQUIRES := --require=asciidoctor-diagram \
            --require=asciidoctor-mathematical

.PHONY: all build clean build-container-pdf build-no-container-pdf build-container-html build-no-container-html

all: build

build: 
	@echo "Checking if Docker is available..."
	@if command -v docker >/dev/null 2>&1 ; then \
		echo "Docker is available, building inside Docker container..."; \
		$(MAKE) build-container-pdf; \
		$(MAKE) build-container-html; \
	else \
		echo "Docker is not available, building without Docker..."; \
		$(MAKE) build-no-container-pdf; \
		$(MAKE) build-no-container-html; \
	fi

build-container-pdf:
	@echo "Starting build inside Docker container..."
	$(DOCKER_RUN) /bin/sh -c "$(ASCIIDOCTOR_PDF) $(OPTIONS) $(REQUIRES) --out-file=$(PDF_RESULT) $(HEADER_SOURCE)"
	@echo "Build completed successfully inside Docker container."

build-no-container-pdf:
	@echo "Starting build..."
	$(ASCIIDOCTOR_PDF) $(OPTIONS) $(REQUIRES) --out-file=$(PDF_RESULT) $(HEADER_SOURCE)
	@echo "Build completed successfully."

build-container-html:
	@echo "Starting build inside Docker container..."
	$(DOCKER_RUN) /bin/sh -c "$(ASCIIDOCTOR_HTML) $(OPTIONS) $(REQUIRES) --out-file=$(HTML_RESULT) $(HEADER_SOURCE)"
	@echo "Build completed successfully inside Docker container."

build-no-container-html:
	@echo "Starting build..."
	$(ASCIIDOCTOR_HTML) $(OPTIONS) $(REQUIRES) --out-file=$(HTML_RESULT) $(HEADER_SOURCE)
	@echo "Build completed successfully."

clean:
	@echo "Cleaning up generated files..."
	rm -f $(PDF_RESULT) $(HTML_RESULT)
	@echo "Cleanup completed."

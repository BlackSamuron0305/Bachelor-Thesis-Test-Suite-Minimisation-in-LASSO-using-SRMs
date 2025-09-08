# LaTeX Makefile with automatic cleanup

MAIN = paper
TEX_FILES = $(wildcard *.tex sections/*.tex)

.PHONY: all clean build watch

# Default target - build and clean
all: build clean

# Build the PDF
build:
	latexmk -pdf $(MAIN).tex

# Clean auxiliary files but keep PDF
clean:
	@echo "Cleaning auxiliary files..."
	@rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.lof *.log *.lot *.nlo *.out *.run.xml *.synctex.gz *.toc
	@rm -f sections/*.aux
	@echo "Cleanup complete!"

# Watch for changes and rebuild automatically
watch:
	latexmk -pdf -pvc $(MAIN).tex

# Deep clean - removes PDF too
distclean: clean
	rm -f $(MAIN).pdf

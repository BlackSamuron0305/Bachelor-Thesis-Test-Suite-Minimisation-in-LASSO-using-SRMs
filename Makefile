# LaTeX Makefile with automatic cleanup

MAIN = paper
TEX_FILES = $(wildcard *.tex sections/*.tex)

.PHONY: all clean build watch

# Default target - build and clean
all: build clean

# Build the PDF
build:
	latexmk -pdf $(MAIN).tex
	# Generate nomenclature if .nlo file exists
	@if [ -f $(MAIN).nlo ]; then \
		makeindex $(MAIN).nlo -s nomencl.ist -o $(MAIN).nls; \
		latexmk -pdf $(MAIN).tex; \
	fi

# Clean auxiliary files but keep PDF
clean:
	@echo "Cleaning auxiliary files..."
	@rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.lof *.log *.lot *.out *.run.xml *.synctex.gz *.toc *.nls *.ilg *.nlo *.bbl-SAVE-ERROR *.bcf-SAVE-ERROR
	@rm -f sections/*.aux
	@echo "Cleanup complete!"

# Watch for changes and rebuild automatically
watch:
	latexmk -pdf -pvc $(MAIN).tex

# Deep clean - removes PDF too
distclean: clean
	rm -f $(MAIN).pdf $(MAIN).nlo $(MAIN).nlg
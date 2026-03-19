#!/bin/bash

# LaTeX Cleanup Script - Removes all auxiliary files but keeps PDF and source files

echo "Cleaning up LaTeX auxiliary files..."

# Remove common LaTeX auxiliary files
rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.lof *.log *.lot *.nlo *.out *.run.xml *.synctex.gz *.toc

# Remove auxiliary files in sections directory
rm -f sections/*.aux

echo "Cleanup complete! Kept .tex files and .pdf output."
echo "Removed files: aux, bbl, bcf, blg, fdb_latexmk, fls, lof, log, lot, nlo, out, run.xml, synctex.gz, toc"

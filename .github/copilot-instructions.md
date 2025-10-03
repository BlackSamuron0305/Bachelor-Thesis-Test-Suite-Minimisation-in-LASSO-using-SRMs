# GitHub Copilot Instructions

## Project Overview
Bachelor thesis on **Test Suite Minimization in LASSO Using Stimulus-Response Matrices**. This is a LaTeX academic paper about implementing the Harrold-Gupta-Soffa (HGS) algorithm for test suite reduction in the LASSO platform.

## Critical Rules
1. **NEVER provide summaries of changes** - Always make edits directly using tools, never describe what was changed
2. **Maintain highest academic standards** - All content must meet rigorous academic writing standards with proper citations, formal tone, and precise technical language
3. **No placeholder content** - Never use "TODO", "coming soon", or incomplete implementations

## Document Structure
- **Main file**: `paper.tex` - imports all sections via `\include{}`/`\input{}` from `sections/`
- **Section order**: title → abstract → introduction → fundamentals → literature_review → evaluation → approach → implementation → conclusion → appendix → authorship/usage rights
- **Graphics**: Store all images in `graphics/` directory
- **Bibliography**: `literature/lit.bib` using BibLaTeX with `\cite{}` command

## Build System

### Standard Workflow
```bash
make all        # Build PDF + clean auxiliary files (default)
make build      # Build PDF only (includes nomenclature generation)
make clean      # Remove auxiliary files, keep PDF
make watch      # Auto-rebuild on file changes (latexmk -pvc)
make distclean  # Remove everything including PDF
```

### Build Process Details
1. `latexmk -pdf paper.tex` compiles with automatic multi-pass handling
2. If `paper.nlo` exists: runs `makeindex paper.nlo -s nomencl.ist -o paper.nls` for abbreviations
3. Re-runs `latexmk` to incorporate nomenclature
4. Auto-cleans auxiliary files after successful build

### Auxiliary Files (Auto-Cleaned)
`.aux`, `.bbl`, `.bcf`, `.blg`, `.fdb_latexmk`, `.fls`, `.lof`, `.log`, `.lot`, `.out`, `.run.xml`, `.synctex.gz`, `.toc`, `.nls`, `.ilg`

## LaTeX Conventions

### Document Class & Settings
- **Class**: `scrbook` (KOMA-Script) with 12pt, one-sided, headsepline
- **Margins**: left=4cm, right=2.5cm, top=3.7cm, bottom=4cm
- **Language**: English (primary), German (secondary hyphenation)
- **Spacing**: 1.5 line spacing (`\onehalfspacing`), no paragraph indentation
- **Page numbering**: Roman (frontmatter/backmatter), Arabic (mainmatter)

### Section Files
Each major chapter is a separate `.tex` file in `sections/`:
- Use `\chapter{}` for top-level sections (auto-numbered)
- Use `\section{}` and `\subsection{}` for subdivisions
- NO document preamble/`\begin{document}` in section files—only content

### Citations
- **Command**: `\cite{key}` or `\cite{key1,key2}` for multiple sources
- **Format**: Author-year style with natbib compatibility
- **Adding sources**: Edit `literature/lit.bib` in BibTeX format
- **Rebuilding**: `make all` automatically handles bibliography compilation

### Abbreviations
Define in `sections/abbreviations.tex` using:
```latex
\abbrev{ACRONYM}{Full Expansion}
```
Examples: `\abbrev{LASSO}{Large-Scale Software Observatorium}`, `\abbrev{HGS}{Harrold--Gupta--Soffa algorithm}`

### Figures
```latex
\begin{figure}[H]  % H forces exact placement (requires float package)
  \centering
  \includegraphics[width=0.8\textwidth]{graphics/diagram.pdf}
  \caption{Description of figure}
  \label{fig:diagram}
\end{figure}
```
Reference with `\ref{fig:diagram}` or `Figure~\ref{fig:diagram}`

### Tables
```latex
\begin{table}[H]
  \centering
  \caption{Description of table}
  \label{tab:results}
  \begin{tabular}{|l|c|r|}
    \hline
    Left & Center & Right \\
    \hline
    Data & Data & Data \\
    \hline
  \end{tabular}
\end{table}
```

### Math Notation
- Inline: `$T = \{t_1, t_2, \ldots, t_n\}$`
- Display: `\[ C(S^*) = C(T) \]` or `equation` environment
- Complexity: `$O(nm \log m)$`

## Content Guidelines

### Thesis-Specific Terminology
- **LASSO**: Large-Scale Software Observatorium (platform for software analysis)
- **SRM**: Stimulus-Response Matrix (2D matrix: rows=stimuli, columns=systems, cells=responses)
- **TSM**: Test Suite Minimization
- **HGS algorithm**: Greedy set-cover approach with overlap-aware heuristics
- **Coverage preservation**: Maintaining code coverage/fault detection while reducing test suite size

### Writing Style
- **Tense**: Present tense for general statements, past for specific contributions
- **Voice**: Passive voice acceptable in academic context; use "we" for author contributions
- **Formality**: Academic formal English, avoid contractions, maintain rigorous scholarly tone
- **Citations**: Support ALL claims with `\cite{}`, especially for statistics/algorithms/techniques
- **Precision**: Use exact technical terminology, define all specialized terms on first use
- **Evidence-based**: Every assertion must be backed by literature or empirical data

### Research Questions (RQ1-RQ4)
When discussing methodology, reference the four research questions defined in `sections/introduction.tex`:
1. RQ1: Most effective minimization techniques
2. RQ2: Evaluation criteria for SRM environment
3. RQ3: Optimal algorithmic approach
4. RQ4: Integration into LASSO pipeline

## Common Tasks

### Adding a New Section
1. Create `sections/newsection.tex` (content only, no preamble)
2. Add `\include{sections/newsection}` to `paper.tex` in appropriate order
3. Run `make all`

### Adding Citations
1. Add BibTeX entry to `literature/lit.bib`
2. Use `\cite{citationkey}` in text
3. Rebuild: `make all` (automatically runs BibLaTeX)

### Fixing Compilation Errors
1. Check `paper.log` for detailed error messages
2. Common issues: missing `}`, undefined references, missing packages
3. For undefined references: Run `make all` twice (first pass collects, second resolves)
4. For nomenclature issues: Ensure `makeindex` step completes in Makefile

### Version Control
- **Current branch**: `Version_1.4`
- **Keep tracked**: `.tex`, `.bib`, `Makefile`, `cleanup.sh`, graphics sources
- **Ignore**: All auxiliary files (listed in build system section)

## Troubleshooting

### "Undefined control sequence"
Missing `\usepackage{}` in preamble or typo in command name. Check `paper.tex` package list.

### References showing as "??"
Run `make all` twice to resolve forward references.

### Nomenclature not appearing
Ensure `makeindex paper.nlo -s nomencl.ist -o paper.nls` runs successfully. Check for `paper.nlo` file existence.

### Compilation hangs
Likely missing `$` or unbalanced brackets. Check terminal output for line number before hang.

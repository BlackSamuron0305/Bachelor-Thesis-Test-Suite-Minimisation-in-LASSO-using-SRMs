# GitHub Copilot Instructions

## Project Overview
Bachelor thesis: **Test Suite Minimisation in LASSO Using Stimulus-Response Matrices**. LaTeX academic paper implementing the Harrold-Gupta-Soffa (HGS) algorithm with overlap-aware heuristics for test suite reduction in the LASSO platform. Language-independent approach operating on SRM representations.

## Critical Rules
1. **Always make direct edits using tools** - Never provide summaries or descriptions of changes
2. **Academic rigor required** - Formal tone, proper citations (`\cite{}`), precise technical language, evidence-based assertions
3. **No placeholders** - Never use "TODO", "coming soon", or incomplete content
4. **Section files are content-only** - No preamble/`\begin{document}` in `sections/*.tex` files
5. **NEVER create .md files** - Do not create summary.md, notes.md, or any other markdown files in this workspace. This is a LaTeX project only.

## Architecture

### Document Structure
```
paper.tex              # Main: \documentclass, packages, \begin{document}
├─ sections/title.tex          # Front page (custom geometry)
├─ sections/abstract.tex       # Abstract
├─ sections/introduction.tex   # RQ1-RQ4 definition, problem statement
├─ sections/fundamentals.tex   # Coverage, mutation testing, SRM formalization
├─ sections/literature_review.tex  # Survey of TSM techniques
├─ sections/evaluation.tex     # C1-C6 criteria, algorithm comparison
├─ sections/approach.tex       # HGS+overlap selection rationale
├─ sections/implementation.tex # Implementation details
├─ sections/conclusion.tex     # Summary, future work
├─ sections/append.tex         # Appendix content
└─ sections/Authorship.tex / UsageRights.tex  # Legal declarations

literature/lit.bib     # BibLaTeX database (author-year style)
sections/abbreviations.tex  # \abbrev{} definitions (LASSO, SRM, HGS, etc.)
graphics/              # Figures (diagram.pdf, unilogo.*)
```

### Page Numbering Flow
- `\frontmatter` → Roman numerals (title, abstract, TOC, lists, abbreviations)
- `\mainmatter` → Arabic numerals (introduction through conclusion)
- `\backmatter` → Roman numerals reset (bibliography, appendix, authorship)

### Build System
**Primary workflow**: `make all` (builds PDF + auto-cleans auxiliary files)

**Build internals** (latexmk + makeindex):
1. `latexmk -pdf paper.tex` (multi-pass: pdflatex → biber → pdflatex×2)
2. If `paper.nlo` exists: `makeindex paper.nlo -s nomencl.ist -o paper.nls` (generates abbreviation list)
3. Re-run `latexmk` to incorporate nomenclature
4. Auto-clean: `.aux .bbl .bcf .blg .fdb_latexmk .fls .lof .log .lot .out .run.xml .synctex.gz .toc .nls .ilg`

**Other targets**:
- `make build` - Compile only, keep auxiliary files
- `make watch` - Auto-rebuild on changes (`latexmk -pvc`)
- `make clean` - Remove auxiliary files, keep PDF
- `make distclean` - Remove everything including PDF
- `./cleanup.sh` - Alternative cleanup script

## LaTeX Conventions

### KOMA-Script (scrbook) Configuration
- **Geometry**: `left=4cm, right=2.5cm, top=3.7cm, bottom=4cm` (except title page uses `margin=3cm`)
- **Font**: 12pt, one-sided printing (`twoside=off`)
- **Spacing**: `\onehalfspacing` (1.5), no paragraph indentation (`\parindent=0pt`)
- **Headers**: Chapter/section marks, bold page numbers (`\ohead{\pagemark}`)

### Citations & Bibliography
**Command**: `\cite{key}` (multiple: `\cite{key1,key2}`)  
**Adding sources**: Edit `literature/lit.bib` in BibTeX format  
**Existing keys**: `pacheco2007` (Randoop), `fraser2011` (EvoSuite), `harrold1993` (HGS), `yoo2012` (TSM survey), `Kessel2022` (LASSO), `bach2017` (overlap-aware), `mongiovi2020` (REDUNET), `just2014` (Defects4J), etc.  
**Rebuild**: `make all` handles biber automatically; run twice if references show "??"

### Abbreviations
Define once in `sections/abbreviations.tex` using `\abbrev{ACRONYM}{Full Expansion}`:
```latex
\abbrev{LASSO}{Large-Scale Software Observatorium}
\abbrev{SRM}{Stimulus-Response Matrix}
\abbrev{HGS}{Harrold--Gupta--Soffa algorithm}
\abbrev{TSM}{Test Suite Minimisation}
\abbrev{ILP}{Integer Linear Programming}
\abbrev{CFG}{Control Flow Graph}
```
Note: Use `--` for en-dash in names (e.g., `Harrold--Gupta--Soffa`)

### Figures & Tables
**Placement**: Use `[H]` from `float` package to force exact location (prevents floating)
```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{graphics/diagram.pdf}
  \caption{Description with proper academic phrasing}
  \label{fig:diagram}  % Reference with \ref{fig:diagram}
\end{figure}
```
**Graphics path**: `graphics/` (no need for full path in `\includegraphics`)  
**Aspect ratio helper**: `\begin{fitcenter}...\end{fitcenter}` (custom environment using `adjustbox`)

### Math & Algorithms
**Inline**: `$T = \{t_1, t_2, \ldots, t_n\}$`  
**Display**: `\[ C(S^*) = C(T) \]` or `\begin{equation}...\end{equation}` for numbered  
**Complexity**: `$O(nm \log m)$` (standard notation)  
**Set notation**: `$S^* \subseteq T$`, `$C(T) = \bigcup_{t_i \in T} C(t_i)$`

**Algorithm flowcharts**: Use tabular with `\hline` separators (see `sections/approach.tex` Phase 1-4 example)

## Domain-Specific Content

### Core Terminology (Must Use Correctly)
- **LASSO**: Large-Scale Software Observatorium - platform for execution-based analysis at scale
- **SRM**: Stimulus-Response Matrix - $M_{ij}$ = response of system $j$ to stimulus $i$
  - Rows = stimuli (test sequences), Columns = systems, Cells = responses
  - Black-box view: I/O only; White-box view: full execution traces
- **Coverage-adapted SRM**: Binary matrix $M \in \{0,1\}^{n \times m}$ where rows=tests, columns=requirements
- **HGS algorithm**: Prioritizes rare requirements ($card_j = 1$), then overlap-aware greedy selection
- **Overlap-aware heuristics**: Penalizes tests with high coverage intersection to maximize unique coverage
- **Arena**: LASSO component for executing tests across multiple systems

### Research Questions (sections/introduction.tex)
- **RQ1**: Most effective minimisation techniques (literature)
- **RQ2**: Evaluation criteria for SRM environment
- **RQ3**: Optimal algorithmic approach (HGS+overlap)
- **RQ4**: Integration into LASSO pipeline

### Evaluation Criteria (sections/evaluation.tex)
- **C1**: Coverage Preservation (≥95% target)
- **C2**: Reduction Effectiveness (>45% target)
- **C3**: Fault Detection Retention (≥90% target)
- **C4**: Computational Scalability (O(nm log m) or better)
- **C5**: SRM Compatibility (no CFG/structural info required)
- **C6**: Implementation Feasibility (maintainability, parameter sensitivity)

### Algorithm Comparison (Key Findings)
- **Classical Greedy**: 85-95% coverage, 30-50% reduction, O(nm) - ignores rarity
# Copilot instructions — concise, repo-specific

Purpose: help AI coding agents edit this LaTeX thesis repo safely and productively.

Core rules

- Edit files directly with repository tooling (no pasted diffs in chat). Keep commits small and focused.
- Maintain academic tone: formal phrasing, present tense for facts, "We" for author actions. Every factual claim in text must cite using `\cite{}`.
- Do not introduce placeholder markers ("TODO", "TBD"). Sections in `sections/*.tex` must be content-only (no `\begin{document}` or preamble).
- Do not add new top-level markdown documentation files in the repo; this project is LaTeX-first. Updating this file is the only exception.

Quick workspace map (important files)

- `paper.tex` — main document and global package setup (KOMA-Script, geometry, biblatex).
- `Makefile` — primary developer commands: `make all` (build+clean), `make build` (build), `make watch` (latexmk -pvc), `make clean`, `make distclean`.
- `sections/` — chapter content, one file per chapter (e.g. `sections/approach.tex`, `sections/implementation.tex`). Edit these directly.
- `literature/lit.bib` — BibTeX database. Add entries here and cite with `\cite{key}` in the .tex files.
- `graphics/` — figures used by `\includegraphics{...}`.

Build & verification

- Primary: `make all` (invokes `latexmk -pdf paper.tex`, runs biber, runs makeindex if `paper.nlo` exists). If references display `??`, run `make all` twice.
- For quick iteration use `make build` to keep aux files, or `make watch` for auto-rebuilds.
- Check `paper.log` for LaTeX errors and line numbers. Common fixes: missing package in `paper.tex`, unbalanced braces, or stray `$`.

Editing conventions & examples

- Abbreviations: define once in `sections/abbreviations.tex` with `\abbrev{ACRONYM}{Full Expansion}`; use `--` for en-dash (e.g., `Harrold--Gupta--Soffa`).
- Figures: put files in `graphics/` and insert with `\begin{figure}[H] ... \includegraphics{graphics/diagram.pdf} ...`.
- Citations: add BibTeX to `literature/lit.bib` and reference keys such as `harrold1993`, `yoo2012`, `Kessel2022` are already present and used.

When to ask before changing

- Structural changes (Makefile, `paper.tex` packages, bibliography backend) — ask the repo owner.
- Adding new LaTeX packages or altering geometry/margins — notify before committing.

If something is unclear, ask: give the file path and the precise change you want to make (one-line summary + intended verification step, e.g. "Edit `sections/approach.tex` to add a paragraph and run `make build` to verify no compilation errors").

— End of concise instructions —
3. Use descriptive keys: `author2024` or `author2024topic`

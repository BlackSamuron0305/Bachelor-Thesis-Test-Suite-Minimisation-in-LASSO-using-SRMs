# GitHub Copilot Instructions

## Project Overview
Bachelor thesis: **Test Suite Minimization in LASSO Using Stimulus-Response Matrices**. LaTeX academic paper implementing the Harrold-Gupta-Soffa (HGS) algorithm with overlap-aware heuristics for test suite reduction in the LASSO platform. Language-independent approach operating on SRM representations.

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
- **RQ1**: Most effective minimization techniques (literature)
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
- **HGS**: 95-98% coverage, 45-70% reduction, O(nm log m) - optimal for LASSO
- **Delayed Greedy**: 60-80% reduction but 75-85% fault detection - too aggressive
- **ILP/REDUNET**: Optimal but exponential complexity, requires CFG - incompatible
- **GA/QIGA**: 80-90% coverage, stochastic, parameter-sensitive - poor repeatability

## Writing Style Requirements

### Tense & Voice
- Present tense for general statements: "SRMs represent behavioral data"
- Past tense for study contributions: "We implemented the HGS algorithm"
- Passive acceptable: "The algorithm is evaluated using six criteria"
- "We" for author actions: "We address this limitation by..."

### Citation Discipline
**Every claim needs evidence**: Statistics, algorithms, techniques, findings ALL require `\cite{}`
```latex
% WRONG: Test suite minimization reduces execution time.
% RIGHT: Test suite minimization reduces execution time while preserving fault detection~\cite{yoo2012}.
```

**Multi-citation format**: `\cite{harrold1993, bach2017, shi2018}` for related work

### Technical Precision
- Define terms on first use: "Stimulus-Response Matrix (SRM)"
- Use exact terminology: "statement coverage" not "code coverage" when specific
- Quantify: "45-70% reduction" not "significant reduction"
- Formal phrasing: "demonstrates superior performance" not "works better"

## Common Tasks

### Adding Content to Existing Section
1. Identify target file in `sections/`
2. Maintain chapter structure: `\section{}` → `\subsection{}` → `\subsubsection{}`
3. Add citations for new claims
4. Run `make all` to check for errors

### Adding New References
1. Open `literature/lit.bib`
2. Add BibTeX entry (use existing entries as templates)
3. Use descriptive keys: `author2024` or `author2024topic`
4. Cite in text with `\cite{newkey}`
5. Rebuild: `make all` (biber runs automatically)

### Creating Tables/Figures
1. Store images in `graphics/` directory
2. Use `[H]` placement for predictable positioning
3. Caption structure: "Description explaining what is shown and why it matters"
4. Label format: `fig:descriptive-name` or `tab:descriptive-name`
5. Reference in text: "Figure~\ref{fig:name} illustrates..."

### Debugging Compilation
**Check `paper.log` first** - LaTeX error messages include line numbers
- **"Undefined control sequence"**: Typo or missing `\usepackage{}` in `paper.tex`
- **"??" in references**: Run `make all` twice (first pass collects, second resolves)
- **Missing nomenclature**: Verify `makeindex` step in Makefile succeeded
- **Compilation hangs**: Missing `$` or unbalanced `{}` - terminal shows last line processed

## Version Control
- **Current branch**: `Version_2.2` (check with `git branch`)
- **Track**: `.tex`, `.bib`, `Makefile`, `cleanup.sh`, original graphics (not generated PDFs)
- **Ignore**: All auxiliary files (see Build System section for complete list)

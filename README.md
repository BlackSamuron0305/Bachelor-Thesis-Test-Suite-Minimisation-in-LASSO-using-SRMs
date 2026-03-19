# Test Suite Minimisation in LASSO Using Stimulus–Response Matrices

This repository contains the thesis and implementation for test suite minimisation in the LASSO platform, focusing on scalable, language-independent reduction of redundant tests using Stimulus–Response Matrices (SRMs) and mutation-aware algorithms.

**Thesis graded: 1.0 (German grade)**
**Supervised by Dr Marcus Kessel, University of Mannheim**
**University of Mannheim, School of Business Informatics and Mathematics, Chair of Software Engineering**

## Overview

- **Thesis Title:** Test Suite Minimisation in LASSO Using Stimulus–Response Matrices
- **Author:** Laith Philipp Sandouk
- **Platform:** LASSO (Large-Scale Software Observatorium)
- **Core Algorithm:** Mutation-Aware Enhanced Harrold–Gupta–Soffa (MA-EHGS)
- **Domain:** Large-scale, language-independent test suite reduction

## Motivation

Large industrial test suites (e.g., SAP with 130,000+ tests) are computationally expensive and often highly redundant. Test suite minimisation systematically removes redundant tests while preserving coverage and fault-detection capability, especially for regression testing.

## LASSO & SRMs

LASSO is a research platform for automated analysis of open-source software, supporting Java and Python. It uses SRMs to map test stimuli to observed execution outcomes, enabling language-independent coverage and mutation analysis.

## Approach

- **SRM-based minimisation:** Operates directly on SRMs, leveraging per-test coverage and mutation data.
- **Algorithm selection:** Literature survey and comparative evaluation identified MA-EHGS as the most effective, balancing coverage, reduction, mutation preservation, scalability, and SRM compatibility.
- **Implementation:** Granular per-test coverage and mutation scores are collected and integrated into LASSO’s SRM format. The minimisation algorithm is implemented as a configurable LASSO Scripting Language (LSL) action.

## Key Contributions

- Empirical evaluation of minimisation algorithms for SRM environments
- Integration of mutation-aware minimisation into LASSO
- Practical reduction levels matching state-of-the-art literature
- Language-independent, scalable minimisation pipeline

## Structure

- `paper.pdf` — Compiled thesis
- `paper.tex` — Main LaTeX source
- `sections/` — Chapter content (abstract, introduction, fundamentals, literature review, approach, implementation, evaluation, conclusion, appendix, legal)
- `graphics/` — Figures and diagrams
- `literature/` — BibTeX bibliography and citation styles
- `.gitignore` — Excludes LaTeX build artifacts

## Research Questions

1. Which minimisation techniques are most effective for LASSO?
2. What evaluation criteria best suit SRM-based minimisation?
3. Which approach best balances reduction, coverage, mutation preservation, and scalability?
4. How can minimisation be integrated into LASSO while maintaining language independence?

## License & Authorship

See `sections/Authorship.tex` and `sections/UsageRights.tex` for legal declarations.

---

This repository is intended for academic and research purposes. All content is subject to copyright and usage restrictions as specified in the thesis.

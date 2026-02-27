# Report Guide

## Create a new report

```bash
./pptex new report my-report
cd my-report
```

## Compile

```bash
./pptex compile my-report/main.tex
# With bibliography:
./pptex compile my-report/main.tex --biber
```

## Directory structure

```
my-report/
├── main.tex              # Entry point — title, author, section order
├── preamble.tex          # All package imports and settings
├── bibliography.bib      # References
├── figures/              # Place images here
└── sections/
    ├── 01_introduction.tex
    ├── 02_methodology.tex
    ├── 03_results.tex
    └── 04_conclusion.tex
```

---

## Changing the title and author

Edit these lines in `main.tex`:

```latex
\title{\textbf{Your Report Title}\\[0.4em]
       \large Optional Subtitle}
\author{Your Name\thanks{Your affiliation. \texttt{email@institution.com}}}
\date{\today}
```

---

## Adding sections

1. Create a new file, e.g. `sections/05_appendix.tex`
2. Add it in `main.tex`:

```latex
\appendix
\input{sections/05_appendix.tex}
```

---

## Math

Standard AMS commands work out of the box:

```latex
\begin{equation}
  \mathcal{L}(\theta) = -\sum_{i=1}^{N} y_i \log \hat{y}_i
  \label{eq:cross-entropy}
\end{equation}

As shown in \cref{eq:cross-entropy}, the loss is...
```

Theorem-like environments:

```latex
\begin{theorem}[Author, Year]
  Statement of the theorem.
\end{theorem}

\begin{proof}
  The proof follows from...
\end{proof}
```

---

## Figures

Place image files in `figures/`. Then:

```latex
\begin{figure}[h]
  \centering
  \includegraphics[width=0.75\textwidth]{my-diagram}
  \caption{A descriptive caption.}
  \label{fig:my-diagram}
\end{figure}

As shown in \cref{fig:my-diagram}...
```

- Prefer **PDF** for vector graphics (diagrams, plots)
- Use **PNG** for screenshots, **JPG** for photos
- Omit the file extension — LaTeX picks the best available format

### Side-by-side figures

```latex
\begin{figure}[h]
  \centering
  \begin{subfigure}{0.45\textwidth}
    \includegraphics[width=\textwidth]{figure-a}
    \caption{Figure A}
    \label{fig:a}
  \end{subfigure}
  \hfill
  \begin{subfigure}{0.45\textwidth}
    \includegraphics[width=\textwidth]{figure-b}
    \caption{Figure B}
    \label{fig:b}
  \end{subfigure}
  \caption{Both figures together.}
\end{figure}
```

---

## Tables

```latex
\begin{table}[h]
  \centering
  \caption{Caption goes above the table.}
  \label{tab:my-table}
  \begin{tabular}{lrr}
    \toprule
    Column 1 & Column 2 & Column 3 \\
    \midrule
    Row 1    & 1.23     & 4.56     \\
    Row 2    & 7.89     & 0.12     \\
    \bottomrule
  \end{tabular}
\end{table}
```

Use `\toprule`, `\midrule`, `\bottomrule` from the **booktabs** package —
never use `\hline` in professional tables.

---

## Code listings

```latex
\begin{lstlisting}[language=Python, caption={Function description.}]
def compute(x, y):
    return x ** 2 + y ** 2
\end{lstlisting}
```

Supported languages (add more in `preamble.tex`): Python, C, C++, Java,
Bash, SQL, JavaScript, MATLAB, R.

To import an external file as a listing:

```latex
\lstinputlisting[language=Python]{code/script.py}
```

---

## Bibliography

Add entries to `bibliography.bib`. Supported entry types:

```bibtex
@article{...}       % Journal articles
@book{...}          % Books
@inproceedings{...} % Conference papers
@techreport{...}    % Technical reports
@online{...}        % Websites (with url= and urldate=)
@thesis{...}        % Dissertations
```

In text:

```latex
\textcite{key}     % Author (Year)
\parencite{key}    % (Author, Year)
\cite{key}         % Author, Year  (no parentheses)
```

Compile with Biber to process the bibliography:

```bash
./pptex compile my-report/main.tex --biber
```

---

## Cross-references

Use `\label{...}` on any section, equation, figure, or table, then reference it
with `\cref{...}` (from the **cleveref** package):

```latex
\cref{fig:my-diagram}   % → Figure 3
\cref{tab:results}      % → Table 2
\cref{eq:loss}          % → Equation 1
\cref{sec:intro}        % → Section 1
```

`\cref` automatically adds the correct word (Figure, Table, etc.).

---

## Page layout

All layout settings are in `preamble.tex`. Key options:

```latex
\usepackage[
  top=2.5cm, bottom=2.5cm,
  left=3cm,  right=3cm,
]{geometry}
```

Common paper sizes:
- `a4paper` — 210 × 297 mm (default)
- `letterpaper` — 8.5 × 11 in

To switch to two-column layout, change `\documentclass` option:

```latex
\documentclass[12pt, a4paper, twocolumn]{article}
```

---

## Fonts

To use custom fonts, edit `preamble.tex`:

```latex
\setmainfont{TeX Gyre Termes}   % Times-like, bundled with TeX Live
\setsansfont{TeX Gyre Heros}    % Helvetica-like
\setmonofont{Inconsolata}       % Monospace
```

To list all available fonts, run:

```bash
./pptex shell
fc-list | sort
```

---

## Line spacing

Edit in `preamble.tex`:

```latex
\setstretch{1.15}   % current default
\setstretch{1.5}    % 1.5 spacing (common requirement)
\setstretch{2.0}    % double spacing
```

---

## Hyperlinks

All internal references and DOIs are clickable by default. To change link colors:

```latex
% in preamble.tex
\usepackage[
  colorlinks=true,
  linkcolor=black,   % internal links
  citecolor=black,   % citations
  urlcolor=blue,     % URLs
]{hyperref}
```

To disable colored links (e.g. for print):

```latex
\usepackage[hidelinks]{hyperref}
```

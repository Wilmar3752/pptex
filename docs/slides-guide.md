# Slides Guide (Beamer + Metropolis)

## Create a new presentation

```bash
./pptex new slides my-talk
cd my-talk
```

This copies `templates/slides/` into `my-talk/`.

## Compile

```bash
./pptex compile my-talk/main.tex
# Output: my-talk/main.pdf
```

## Directory structure

```
my-talk/
├── main.tex              # Entry point — edit metadata here
├── references.bib        # Bibliography entries
└── slides/
    ├── 00_title.tex      # Title slide + table of contents
    ├── 01_overview.tex   # Overview / motivation section
    ├── 02_content.tex    # Main content (tables, code, charts, diagrams)
    └── 03_conclusion.tex # Summary + thank-you slide
```

---

## Customizing metadata

Open `main.tex` and change these fields:

```latex
\title{Your Presentation Title}
\subtitle{An Optional Subtitle}
\author{Your Name}
\institute{Your Institution}
\date{\today}          % or e.g. \date{March 2025}
```

---

## Adding / removing sections

Each section lives in a separate file under `slides/`. To add a section:

1. Create `slides/04_experiments.tex`
2. Add `\input{slides/04_experiments.tex}` in `main.tex` after the other inputs.

To remove a section, delete or comment out its `\input` line.

---

## Slide types

### Plain text with bullets

```latex
\begin{frame}{Slide Title}
  \begin{itemize}
    \item First point
    \item Second point
    \item \alert{Highlighted point}
  \end{itemize}
\end{frame}
```

### Two columns

```latex
\begin{frame}{Two Columns}
  \begin{columns}[T]
    \begin{column}{0.48\textwidth}
      Left content
    \end{column}
    \begin{column}{0.48\textwidth}
      Right content
    \end{column}
  \end{columns}
\end{frame}
```

### Blocks

```latex
\begin{frame}{Blocks}
  \begin{block}{Normal block}
    Standard information.
  \end{block}
  \begin{alertblock}{Alert block}
    Critical information.
  \end{alertblock}
  \begin{exampleblock}{Example block}
    An example or demo.
  \end{exampleblock}
\end{frame}
```

### Code

```latex
\begin{frame}[fragile]{Code}
  \begin{lstlisting}[language=Python]
def greet(name):
    return f"Hello, {name}!"
  \end{lstlisting}
\end{frame}
```

> Always add `[fragile]` to the frame when using `lstlisting`.

### Image

```latex
\begin{frame}{Figure}
  \begin{figure}
    \centering
    \includegraphics[width=0.7\textwidth]{figures/my-image.pdf}
    \caption{Caption text.}
  \end{figure}
\end{frame}
```

Place image files in `figures/`. Supported formats: PDF, PNG, JPG, EPS.
PDF is preferred for vector graphics.

### Table

```latex
\begin{frame}{Table}
  \begin{table}
    \centering
    \begin{tabular}{lrr}
      \toprule
      Method & Score & Time \\
      \midrule
      A & 72\% & 1.4 s \\
      B & \textbf{91\%} & \textbf{0.8 s} \\
      \bottomrule
    \end{tabular}
    \caption{Comparison.}
  \end{table}
\end{frame}
```

---

## Aspect ratio

Change `aspectratio` in `main.tex`:

| Value | Ratio |
|---|---|
| `169` | 16:9 (default, most projectors) |
| `1610` | 16:10 |
| `43` | 4:3 (classic) |
| `32` | 3:2 |

---

## Color scheme

The template defines three colors in `main.tex`:

```latex
\definecolor{pptexBlue}{HTML}{2B4590}    % primary / header background
\definecolor{pptexAccent}{HTML}{E8433A}  % progress bar, alerts
\definecolor{pptexLight}{HTML}{F5F5F5}   % code background
```

To use a different palette, change the hex values. The colors are applied to
the Metropolis theme via `\setbeamercolor{}`.

---

## Progress bar

Metropolis shows a thin progress bar under each frame title. Options:

```latex
\usetheme[progressbar=frametitle]{metropolis}  % default — under title
\usetheme[progressbar=foot]{metropolis}        % at the bottom
\usetheme[progressbar=none]{metropolis}        % disable
```

---

## Fonts

The template uses XeLaTeX's default fonts. To switch to custom system fonts:

1. Find a font name: run `./pptex shell` then `fc-list | sort`
2. In `main.tex`, uncomment and edit:

```latex
\setmainfont{Source Serif 4}
\setsansfont{Source Sans 3}
\setmonofont{Source Code Pro}
```

The above fonts are included in the Docker image.

---

## Bibliography

Add entries to `references.bib`. In slides, cite with:

```latex
\parencite{key}          % (Author, Year)
\textcite{key}           % Author (Year)
```

Compile with Biber:

```bash
./pptex compile main.tex --biber
```

The references slide is already set up at the end of `main.tex`.

---

## Section title slides

Metropolis automatically generates a section separator slide when you use
`\section{}`. No extra code needed.

---

## Hiding slides (appendix)

```latex
\appendix

\begin{frame}{Backup slide}
  Extra material not shown in the main talk.
\end{frame}
```

Slides after `\appendix` are not counted in the progress bar.

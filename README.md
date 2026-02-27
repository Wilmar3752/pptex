# pptex

> LaTeX presentations and reports on any OS — powered by Docker, zero installation friction.

No TeX Live to install. No version conflicts. No `sudo apt install texlive-full` that takes 20 minutes.
Clone the repo, have Docker running, and you're compiling PDFs in under a minute.

---

## Features

| Feature | Details |
|---|---|
| **Slides** | Beamer + Metropolis theme, 16:9, XeLaTeX |
| **Reports** | Article class, clean layout, XeLaTeX |
| **Engines** | `pdflatex`, `xelatex`, `lualatex` |
| **Bibliography** | BibLaTeX + Biber |
| **Diagrams** | TikZ, pgfplots built-in |
| **Code** | listings package with syntax highlighting |
| **Watch mode** | Auto-recompile on save |
| **Cross-platform** | macOS, Linux, Windows (WSL) |

---

## Quick Start

### 1 — Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running
- Git

### 2 — Clone & set up

```bash
git clone https://github.com/yourusername/pptex.git
cd pptex
chmod +x pptex       # macOS / Linux only
```

### 3 — Build the Docker image

```bash
./pptex build
```

> This downloads TeX Live (~3 GB) and builds the image. It only runs once.

### 4 — Create your first presentation

```bash
./pptex new slides my-talk
./pptex compile my-talk/main.tex
```

Your PDF will be at `my-talk/main.pdf`. Open it with any PDF viewer.

### 5 — Create a report

```bash
./pptex new report my-report
./pptex compile my-report/main.tex
```

---

## CLI Reference

```
pptex <command> [options]
```

| Command | Description |
|---|---|
| `build` | Build (or rebuild) the Docker image |
| `compile <file.tex>` | Compile a LaTeX file to PDF |
| `watch <file.tex>` | Watch and auto-recompile on changes |
| `new slides <name>` | Create a new presentation from template |
| `new report <name>` | Create a new report from template |
| `shell` | Open an interactive shell in the container |
| `clean [dir]` | Remove LaTeX auxiliary files |

### Options for `compile` and `watch`

| Flag | Default | Description |
|---|---|---|
| `-e, --engine` | `xelatex` | LaTeX engine: `pdflatex`, `xelatex`, `lualatex` |
| `-b, --biber` | off | Run Biber for bibliography |
| `-o, --output-dir` | same as source | Directory to write the PDF |

### Examples

```bash
# Basic compile
./pptex compile my-talk/main.tex

# Use LuaLaTeX with bibliography
./pptex compile my-report/main.tex --engine lualatex --biber

# Watch mode (Ctrl+C to stop)
./pptex watch my-talk/main.tex

# Interactive shell (run any LaTeX command manually)
./pptex shell

# Clean auxiliary files in a project
./pptex clean my-talk/
```

---

## Makefile shortcuts

If you prefer `make`:

```bash
make build      # Build Docker image
make slides     # Compile templates/slides/main.tex
make report     # Compile templates/report/main.tex
make shell      # Interactive shell
make clean      # Remove all auxiliary files
make compile FILE=my-talk/main.tex   # Compile a specific file
```

---

## Project Structure

```
pptex/
├── pptex                   # Main CLI script
├── Dockerfile              # LaTeX Docker image
├── docker-compose.yml      # Docker Compose configuration
├── Makefile                # Convenience shortcuts
├── templates/
│   ├── slides/             # Beamer presentation template
│   │   ├── main.tex        # Entry point
│   │   ├── references.bib  # Bibliography
│   │   └── slides/         # One file per section
│   │       ├── 00_title.tex
│   │       ├── 01_overview.tex
│   │       ├── 02_content.tex
│   │       └── 03_conclusion.tex
│   └── report/             # Article report template
│       ├── main.tex        # Entry point
│       ├── preamble.tex    # All package imports
│       ├── bibliography.bib
│       ├── figures/        # Place images here
│       └── sections/       # One file per section
│           ├── 01_introduction.tex
│           ├── 02_methodology.tex
│           ├── 03_results.tex
│           └── 04_conclusion.tex
└── docs/
    ├── installation.md     # Detailed installation guide
    ├── slides-guide.md     # Slides template guide
    └── report-guide.md     # Report template guide
```

---

## Documentation

- [Installation Guide](docs/installation.md) — Docker setup, troubleshooting
- [Slides Guide](docs/slides-guide.md) — Customizing the Beamer template
- [Report Guide](docs/report-guide.md) — Customizing the report template

---

## License

MIT

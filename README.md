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
./pptex new slides congreso          # creates slides/congreso/
./pptex compile slides congreso      # → slides/congreso/main.pdf
```

Create as many projects as you want under `slides/`:

```bash
./pptex new slides curso_estadistica
./pptex compile slides curso_estadistica
./pptex list                          # see all projects
```

### 5 — Create a report

```bash
./pptex new report tesis             # creates reports/tesis/
./pptex compile reports tesis        # → reports/tesis/main.pdf
```

---

## CLI Reference

```
pptex <command> [options]
```

| Command | Description |
|---|---|
| `build` | Build (or rebuild) the Docker image |
| `new slides <name>` | Create a presentation project → `slides/<name>/` |
| `new report <name>` | Create a report project → `reports/<name>/` |
| `compile slides <name>` | Compile `slides/<name>/main.tex` |
| `compile reports <name>` | Compile `reports/<name>/main.tex` |
| `compile <file.tex>` | Compile any `.tex` file directly |
| `watch slides <name>` | Watch and auto-recompile on changes |
| `list [slides\|reports]` | List all projects |
| `clean slides <name>` | Remove auxiliary files for a project |
| `clean` | Remove auxiliary files in all projects |
| `shell` | Open an interactive shell in the container |

### Options for `compile` and `watch`

| Flag | Default | Description |
|---|---|---|
| `-e, --engine` | `xelatex` | LaTeX engine: `pdflatex`, `xelatex`, `lualatex` |
| `-b, --biber` | off | Run Biber for bibliography |
| `-o, --output-dir` | same as source | Directory to write the PDF |

### Examples

```bash
# Create and compile a presentation
./pptex new slides congreso
./pptex compile slides congreso

# Create and compile a report with bibliography
./pptex new report tesis
./pptex compile reports tesis --biber

# Watch mode (Ctrl+C to stop)
./pptex watch slides congreso

# List all projects
./pptex list

# Clean one project
./pptex clean slides congreso

# Interactive shell
./pptex shell
```

---

## Makefile shortcuts

If you prefer `make`:

```bash
make build                           # Build Docker image
make slides PROJ=congreso            # Compile slides/congreso/
make report PROJ=tesis               # Compile reports/tesis/
make watch  TYPE=slides PROJ=congreso
make new-slides NAME=curso_estadistica
make new-report NAME=practica
make list                            # List all projects
make clean  TYPE=slides PROJ=congreso
make shell
```

---

## Project Structure

```
pptex/
├── pptex                        # Main CLI script
├── Dockerfile                   # LaTeX Docker image
├── docker-compose.yml
├── Makefile
│
├── slides/                      # Your presentation projects live here
│   ├── congreso/                #   pptex new slides congreso
│   │   ├── main.tex
│   │   ├── references.bib
│   │   ├── figures/
│   │   └── slides/
│   └── curso_estadistica/       #   pptex new slides curso_estadistica
│       └── ...
│
├── reports/                     # Your report projects live here
│   └── tesis/                   #   pptex new report tesis
│       ├── main.tex
│       ├── preamble.tex
│       ├── bibliography.bib
│       ├── figures/
│       └── sections/
│
├── templates/                   # Source templates (do not edit directly)
│   ├── slides/
│   └── report/
│
└── docs/
    ├── installation.md
    ├── slides-guide.md
    └── report-guide.md
```

---

## OS Compatibility

| OS | Terminal | Works |
|---|---|---|
| **macOS** | Terminal, iTerm2 | Yes |
| **Linux** | Any | Yes |
| **Windows — WSL2** | WSL terminal | Yes — recommended for Windows |
| **Windows — Git Bash** | Git Bash | Yes |
| **Windows — PowerShell / CMD** | — | No — use WSL2 or Git Bash |

### macOS

```bash
chmod +x pptex
./pptex build
```

### Linux

```bash
chmod +x pptex
./pptex build
```

### Windows (WSL2) — recommended

The most robust option. Docker Desktop integrates natively with WSL2 and the experience is identical to Linux.

1. Enable WSL2: `wsl --install` (restart required)
2. Install [Docker Desktop](https://www.docker.com/products/docker-desktop) and enable **Settings → General → Use the WSL 2 based engine**
3. Open your WSL terminal:

```bash
git clone https://github.com/yourusername/pptex.git
cd pptex
chmod +x pptex
./pptex build
```

### Windows (Git Bash)

Works with [Git for Windows](https://git-scm.com/download/win). The script sets `MSYS_NO_PATHCONV=1` automatically to prevent Git Bash from mangling Docker volume paths.

```bash
git clone https://github.com/yourusername/pptex.git
cd pptex
./pptex build
```

---

## Documentation

- [Installation Guide](docs/installation.md) — Docker setup, troubleshooting
- [Slides Guide](docs/slides-guide.md) — Customizing the Beamer template
- [Report Guide](docs/report-guide.md) — Customizing the report template

---

## License

MIT

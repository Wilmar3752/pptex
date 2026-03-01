FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    # XeLaTeX engine + fontspec + polyglossia
    texlive-xetex \
    # beamer, metropolis, enumitem, adjustbox, listings, float, \
    # biblatex, cleveref, csquotes, parskip, setspace, caption, \
    # subcaption, microtype, longtable, multirow, lipsum, blindtext, \
    # forarray, titlesec, tabularx, fullpage, fancyhdr, marvosym
    texlive-latex-extra \
    # hyperref, graphicx, color, array, booktabs, verbatim
    texlive-latex-recommended \
    # Computer Modern, lm fonts, amsfonts
    texlive-fonts-recommended \
    # fontawesome5, extra symbol fonts
    texlive-fonts-extra \
    # tikz, pgf, pgfplots
    texlive-pictures \
    # biblatex styles
    texlive-bibtex-extra \
    # amsmath, amssymb, amsthm, mathtools
    texlive-science \
    # babel spanish
    texlive-lang-spanish \
    # build tool
    latexmk \
    # bibliography processor (biblatex)
    biber \
    # font cache
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

RUN fc-cache -fv

WORKDIR /workspace

LABEL org.opencontainers.image.title="pptex" \
      org.opencontainers.image.description="LaTeX environment for slides and reports" \
      org.opencontainers.image.source="https://github.com/Wilmar3752/pptex"

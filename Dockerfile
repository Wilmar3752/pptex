FROM texlive/texlive:latest

RUN apt-get update && apt-get install -y \
    latexmk \
    biber \
    wget \
    curl \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

# Refresh font cache
RUN fc-cache -fv

WORKDIR /workspace

LABEL org.opencontainers.image.title="pptex" \
      org.opencontainers.image.description="LaTeX environment for slides and reports" \
      org.opencontainers.image.source="https://github.com/Wilmar3752/pptex"

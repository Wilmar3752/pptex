.PHONY: build slides report shell clean help

PPTEX := ./pptex

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "  For full CLI usage: ./pptex --help"

build: ## Build the Docker image
	$(PPTEX) build

slides: ## Compile templates/slides/main.tex
	$(PPTEX) compile templates/slides/main.tex

report: ## Compile templates/report/main.tex
	$(PPTEX) compile templates/report/main.tex

shell: ## Open an interactive shell inside the container
	$(PPTEX) shell

clean: ## Remove all LaTeX auxiliary files
	$(PPTEX) clean .

# Compile a specific file: make compile FILE=path/to/main.tex
compile: ## Compile FILE= (e.g. make compile FILE=my-talk/main.tex)
	$(PPTEX) compile $(FILE)

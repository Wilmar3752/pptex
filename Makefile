.PHONY: build slides report watch list new-slides new-report shell clean help

PPTEX := ./pptex

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "  For full CLI usage: ./pptex --help"

build: ## Build the Docker image
	$(PPTEX) build

# ── Project commands (require PROJ=<name>) ───────────────────────────────────

slides: ## Compile a slides project  →  make slides PROJ=congreso
	@[ "$(PROJ)" ] || { \
	  echo "  Usage: make slides PROJ=<name>"; echo ""; \
	  $(PPTEX) list slides; exit 1; }
	$(PPTEX) compile slides $(PROJ)

report: ## Compile a report project  →  make report PROJ=mi-informe
	@[ "$(PROJ)" ] || { \
	  echo "  Usage: make report PROJ=<name>"; echo ""; \
	  $(PPTEX) list reports; exit 1; }
	$(PPTEX) compile reports $(PROJ)

watch: ## Watch a project for changes  →  make watch TYPE=slides PROJ=congreso
	@[ "$(TYPE)" ] || { echo "  Usage: make watch TYPE=slides|reports PROJ=<name>"; exit 1; }
	@[ "$(PROJ)" ] || { echo "  Usage: make watch TYPE=$(TYPE) PROJ=<name>"; exit 1; }
	$(PPTEX) watch $(TYPE) $(PROJ)

clean: ## Clean a project  →  make clean TYPE=slides PROJ=congreso  (or just 'make clean' for all)
	@if [ "$(PROJ)" ] && [ "$(TYPE)" ]; then \
	  $(PPTEX) clean $(TYPE) $(PROJ); \
	else \
	  $(PPTEX) clean; \
	fi

# ── Scaffolding ──────────────────────────────────────────────────────────────

new-slides: ## Create a new slides project  →  make new-slides NAME=congreso
	@[ "$(NAME)" ] || { echo "  Usage: make new-slides NAME=<name>"; exit 1; }
	$(PPTEX) new slides $(NAME)

new-report: ## Create a new report project  →  make new-report NAME=mi-informe
	@[ "$(NAME)" ] || { echo "  Usage: make new-report NAME=<name>"; exit 1; }
	$(PPTEX) new report $(NAME)

# ── Misc ─────────────────────────────────────────────────────────────────────

list: ## List all projects
	$(PPTEX) list

shell: ## Open an interactive shell inside the container
	$(PPTEX) shell

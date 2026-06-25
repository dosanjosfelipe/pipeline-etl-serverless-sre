PYTHON := poetry run python
PYTEST := poetry run pytest
RUFF   := poetry run ruff
PYRIGHT := poetry run pyright
AUDIT  := poetry run pip-audit
TERRAFORM := terraform
INFRA_DIR := infra

.PHONY: help sync audit format lint test tf-fmt tf-init tf-plan tf-apply all all-infra

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

sync: ## Synchronize local environment with poetry.lock
	poetry sync

audit: ## Check installed dependencies for vulnerabilities
	poetry export -f requirements.txt --without-hashes | $(AUDIT) -r /dev/stdin

format: ## Format source code using Ruff
	@echo "--- Formatando código (Ruff) ---"
	$(RUFF) format .
	$(RUFF) check --fix .

lint: ## Perform static analysis and type checking
	@echo "--- Linter Estático (Ruff) ---"
	$(RUFF) check .
	@echo "--- Verificação de Tipos (Pyright) ---"
	$(PYRIGHT)

test: ## Run test suite with coverage reporting
	$(PYTEST) --cov=. --cov-report=term-missing tests/

tf-fmt: ## Format infrastructure code
	@cd $(INFRA_DIR) && $(TERRAFORM) fmt -recursive

tf-init: ## Initialize Terraform backend and providers
	@cd $(INFRA_DIR) && $(TERRAFORM) init

tf-plan: ## Generate and show infrastructure execution plan
	@cd $(INFRA_DIR) && $(TERRAFORM) plan -out=tfplan

tf-apply: ## Apply infrastructure changes
	@cd $(INFRA_DIR) && $(TERRAFORM) apply tfplan

all: sync audit format lint test ## Run full static analysis and testing pipeline

all-infra: tf-fmt tf-init tf-plan ## Run infrastructure validation pipeline

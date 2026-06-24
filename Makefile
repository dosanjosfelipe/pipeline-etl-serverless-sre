# Variáveis para centralizar o ambiente
PYTHON := poetry run python
PYTEST := poetry run pytest
RUFF   := poetry run ruff
PYRIGHT := poetry run pyright
TERRAFORM := terraform

.PHONY: help install lint format test security clean

help: ## Exibe esta ajuda
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

sync: ## Instala as dependências do projeto
	poetry sync

lint: ## Executa checagem de código (Ruff e Pyright)
	@echo "--- Rodando Linter (Ruff) ---"
	$(RUFF) check .
	@echo "--- Rodando Verificador de Tipos (Pyright) ---"
	$(PYRIGHT)

test: ## Executa a suíte de testes com Pytest
	$(PYTEST) tests/

tf-init: ## Inicializa o diretório do Terraform
	$(TERRAFORM) init

tf-plan: ## Executa o plano de infraestrutura
	$(TERRAFORM) plan

tf-fmt: ## Formata arquivos Terraform
	$(TERRAFORM) fmt -recursive

tf-apply: ## Aplica as mudanças na infraestrutura
	$(TERRAFORM) apply -auto-approve

all: format lint security test ## Executa o pipeline completo de CI local

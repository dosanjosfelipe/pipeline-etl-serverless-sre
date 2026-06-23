# Pipeline ETL Serverless: Monitoramento SRE

Este projeto consiste em um **Pipeline de Engenharia de Dados Serverless** na AWS, focado em resiliência, observabilidade e automação total via Infraestrutura como Código (IaC). O objetivo principal é monitorar a disponibilidade e latência de APIs críticas de terceiros, garantindo respostas rápidas para a equipe de **Site Reliability Engineering (SRE)**.

## 🎯 Objetivos do Projeto
*   **Coleta Automatizada:** Captura de telemetria de APIs em intervalos regulares via Amazon EventBridge.
*   **Data Lake em Camadas:** Armazenamento imutável em camada **Raw (Bronze)** e processamento analítico para a camada **Silver (Gold)** em formato Parquet.
*   **Observabilidade:** Notificações em tempo real via Amazon SNS em caso de falhas ou latência acima do SLA.
*   **Eficiência de Custo:** Arquitetura 100% Serverless, visando custo zero ou próximo de zero dentro do AWS Free Tier.

## 🛠️ Stack Tecnológica
*   **Linguagem:** Python 3.14+ (Pandas para processamento).
*   **Infraestrutura (IaC):** Terraform.
*   **Cloud Provider (AWS):** Lambda, S3, EventBridge, Athena e SNS.
*   **Gerenciador de Dependências:** Poetry.
*   **Orquestração de Tarefas:** Makefile.

## 📂 Estrutura do Repositório
De acordo com a organização do projeto:
*   `infra/`: Arquivos de configuração do Terraform para provisionamento AWS.
*   `src/`: Código-fonte da aplicação (Lambdas de ingestão e processamento).
*   `tests/`: Suíte de testes unitários com Pytest.
*   `Makefile`: Comandos utilitários para desenvolvimento e deploy.
*   `pyproject.toml`: Configurações de dependências e ferramentas de linting.

## 🚀 Como Começar

### Pré-requisitos
*   Python 3.14+
*   Poetry
*   Terraform
*   AWS CLI configurado

### Instalação e Desenvolvimento
O projeto utiliza um `Makefile` para centralizar as tarefas comuns:

1.  **Instalar dependências:**
    ```bash
    make sync
    ```
2.  **Executar Qualidade de Código (Lint/Format):**
    ```bash
    make lint    # Executa Ruff e Pyright
    make format  # Executa Black
    ```
3.  **Executar Testes:**
    ```bash
    make test    # Executa Pytest
    ```
4.  **Segurança:**
    ```bash
    make security # Verifica vulnerabilidades com Safety
    ```

## 🏗️ Infraestrutura (Terraform)
Para gerenciar a infraestrutura:
*   `make tf-init`: Inicializa o Terraform.
*   `make tf-plan`: Visualiza as mudanças planejadas.
*   `make tf-apply`: Aplica as mudanças na AWS.

## ✅ Padrões de Qualidade
Para garantir a robustez em ambiente produtivo, o projeto segue as seguintes diretrizes:
*   Aderência estrita à **PEP 8**.
*   **Logging estruturado** e tratamento de exceções em todos os módulos.
*   Uso de **variáveis de ambiente** para configurações sensíveis.
*   CI/CD via **GitHub Actions** automatizando linting, testes e validação de infraestrutura a cada push.

---
**Autor:** Felipe dos Anjos
**Licença:** MIT

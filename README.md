# Pipeline ETL Serveless SRE

Este projeto consiste em um **Pipeline de Engenharia de Dados Serverless na AWS**, focado em resiliência, automação total via Infraestrutura como Código (IaC) e alta observabilidade. O objetivo principal é implementar um sistema de monitoramento de SLA de entrega em tempo real para a Olist, permitindo a detecção proativa de gargalos logísticos.

## 🎯 Objetivo de Negócio
Atualmente, a visibilidade da performance logística é limitada por um processamento batch diário. Esta solução propõe:
*   Reduzir o tempo de detecção de problemas em rotas críticas.
*   Garantir a integridade dos dados através de *schema enforcement*.
*   Otimizar custos operacionais utilizando uma arquitetura 100% serverless.

## 🛠️ Tecnologias e Ferramentas
*   **Linguagem:** Python 3.14+.
*   **Infraestrutura:** Terraform (IaC).
*   **Cloud (AWS):** S3, Lambda, Athena, SNS, Step Functions e EventBridge.
*   **Processamento & Qualidade:** Pandas, PyArrow, Pandera e Pytest.
*   **Padronização:** Ruff, Black e Pyright.

## 🏗️ Arquitetura (Medallion)
O pipeline organiza os dados em três camadas no S3:
1.  **Bronze (Raw):** Dados brutos e imutáveis do dataset Olist (CSV).
2.  **Silver (Trusted):** Dados limpos, tipados e convertidos para o formato Parquet.
3.  **Gold (Curated):** Data Marts com métricas de negócio focadas em SLA por região.

## 🚀 Como Executar
O projeto utiliza um `Makefile` para centralizar os comandos principais:

*   **Instalar dependências:** `make sync`.
*   **Formatar código:** `make format`.
*   **Executar Lint/Tipagem:** `make lint`.
*   **Rodar testes:** `make test`.
*   **Planejar infraestrutura (Terraform):** `make tf-plan`.
*   **Executar Pipeline de CI completo local:** `make all`.

## 📅 Roadmap de Desenvolvimento
1.  **Infra:** Scripting dos buckets S3, políticas IAM e SQS/SNS com Terraform.
2.  **Ingestão:** Script para movimentação de arquivos para a camada Bronze.
3.  **Transformação:** Lambdas para processamento entre camadas (Bronze -> Silver -> Gold).
4.  **Qualidade:** Validação de schemas e testes de integridade.
5.  **Automação:** Configuração de CI/CD via GitHub Actions.

---
**Autor:** Felipe dos Anjos

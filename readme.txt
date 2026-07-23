# Lighthouse26 - Pipeline Analítico com DBT para Dados da IL Nautical

## Visão Geral

Este projeto tem como objetivo a construção de uma solução analítica utilizando **DBT (Data Build Tool)** para transformação, modelagem e documentação dos dados da **IL Nautical**.

O trabalho contempla desde a análise exploratória dos dados brutos até a criação de modelos analíticos documentados e testados, seguindo boas práticas de **Engenharia de Dados** e **Analytics Engineering**.

---

## Análise Exploratória dos Dados

📁 `notebooks/EDA.ipynb`

### Principais análises realizadas

- Avaliação da qualidade dos dados.
- Identificação de valores nulos.
- Verificação de duplicidades.
- Distribuição das principais variáveis.
- Estatísticas descritivas.
- Identificação de inconsistências e oportunidades de tratamento.
- Entendimento das relações entre entidades do negócio.

Os resultados da análise serviram de base para a definição das transformações implementadas no DBT.

---

## Conversão dos Dados

Os dados originais foram disponibilizados em formato **JSON**.

Foi desenvolvido um script em Python para:

- Leitura dos arquivos JSON.
- Normalização das estruturas.
- Conversão para CSV.
- Disponibilização dos arquivos na pasta `seeds` do DBT.

### Fluxo de Conversão

```text
JSON
  ↓
Script Python
  ↓
CSV
  ↓
DBT Seeds
```

---

## Modelagem e Transformações DBT

### Camadas Implementadas

#### Staging

Padronização dos dados de origem:

- Renomeação de colunas.
- Tratamento de nulos.
- Conversão de tipos.
- Aplicação de regras básicas de qualidade.

#### Intermediate

Aplicação de regras de negócio intermediárias:

- Consolidação de entidades.
- Criação de métricas derivadas.
- Enriquecimento dos dados.

#### Mart

Modelos analíticos finais voltados para consumo:

- Indicadores de negócio.
- Consultas analíticas.
- Estruturas otimizadas para ferramentas de BI.

---

## Testes Implementados

Foram utilizados testes nativos do DBT para garantir a qualidade dos dados.

### Testes de Integridade

- `not_null`
- `unique`

### Testes Relacionais

- `relationships`

---

## Documentação

A documentação gerada pelo DBT encontra-se associada aos modelos do projeto.

Além disso, foi realizado o perfilamento e a análise de linhagem dos dados na pasta `docs`.

### Conteúdo da Documentação

- Dicionário de dados.
- Estatísticas descritivas.
- Indicadores de qualidade dos dados.
- Relacionamentos entre entidades.
- Evidências da análise exploratória.

### Comandos

Gerar documentação:

```bash
dbt docs generate
```

Servir documentação localmente:

```bash
dbt docs serve
```

---

## Fluxo do Pipeline

```text
Ingestão JSON
      ↓
Conversão para CSV
      ↓
DBT Seed
      ↓
Modelos Staging
      ↓
Modelos Intermediate
      ↓
Data Marts
      ↓
Testes DBT
      ↓
Atualização da Documentação
```

---

## Infraestrutura

O projeto disponibiliza um ambiente conteinerizado através do **Docker Compose**.

### Serviços

#### PostgreSQL

Banco de dados utilizado para armazenamento e execução dos modelos DBT.

#### Portainer

Interface gráfica para gerenciamento dos containers Docker.

### Inicialização do Ambiente

```bash
docker compose up -d
```

---

## Tecnologias Utilizadas

- Python
- Pandas
- Jupyter Notebook
- DBT
- PostgreSQL
- Docker
- Portainer

---

## Melhorias Futuras

### Orquestração com Apache Airflow

Uma limitação atual do projeto é a ausência de uma camada de orquestração.

Como evolução natural da arquitetura, será implementado o **Apache Airflow** para permitir:

- Agendamento automático das cargas.
- Execução sequencial do pipeline.
- Monitoramento de falhas.
- Reprocessamento automático.
- Observabilidade das etapas.
- Integração entre ingestão, seeds, DBT e validações.

### Arquitetura Futura

```text
JSON → Python → CSV → DBT Seeds → DBT Models → Data Marts
                               ↓
                          Apache Airflow
                               ↓
                   Orquestração e Monitoramento
```

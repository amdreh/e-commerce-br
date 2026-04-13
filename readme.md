# [ESTUDO DE CASO] Inteligência de Dados com SQL 🛒

![Status](https://img.shields.io/badge/Status-Fase%20SQL%20Conclu%C3%ADda-green)
![Tecnologia](https://img.shields.io/badge/Tecnologia-SQL%20%2F%20SQLite-blue)

## 👤 Autor
**André Garcia** *Analista de Dados em transição do jornalismo cultural para o mercado de tecnologia. Em busca de oportunidade para atuar na transformação de dados brutos em inteligência estratégica e suporte à decisão.*

---

## 📖 Sobre o Projeto

### Introdução
Este repositório documenta a utilização da linguagem SQL para realizar a extração e transformação de dados (ETL) de um e-commerce brasileiro (Olist). O foco deste estudo não é apenas unir tabelas, mas garantir a **integridade da informação** e gerar indicadores para dashboards de marketing e vendas.

---

### 🚀 Objetivo do Projeto
O objetivo central é responder a perguntas de negócio e preparar a base para futuras análises:
* Garantir aos relatórios de categorias de produtos um preenchimento legível e padronizado;
* Identificar clientes cadastrados que nunca realizaram uma compra (leads frios)
* Identificar clientes com maior tempo de inatividade (recência) para campanhas de marketing

---

### 🧠 Metodologia e Desenvolvimento
Nesta fase, utilizei SQL (SQLite):

1. **Inner Join como filtro de qualidade:** JOIN utilizado para traduzir os nomes das categorias, bem como ao mesmo tempo filtrar dados preenchidos incorretamente ou sem tradução.
2. **Left foin na busca leads inativos:** JOIN utilizado para constatar que não há Utilizei a lógica de nulos para identificar se a base de clientes possui usuários que ainda não converteram, gerando insights para o time de Business Development.
3. **Cálculo de Recência (Julian Day):** Implementei a conversão de strings de data para o formato numérico Juliano. Isso permitiu calcular com precisão matemática a quantidade de dias que cada cliente está sem comprar, utilizando uma data de referência estratégica (2018-10-17).

---

### 📂 Estrutura do Repositório
Os arquivos do projeto estão organizados da seguinte forma:

* **1_consultas_sql**: Contém os arquivos `.sql` com as queries comentadas linha a linha.
* **2_analise_recencia**: Documentação específica sobre o cálculo de dias sem comprar e análise de retenção.
* **data**: Referência à base de dados original da Olist.
* **README.md**: Documentação principal e apresentação do projeto.

---

### 🛠️ Tecnologias Utilizadas
* **SQLite / SQL Studio:** Manipulação e consulta de grandes volumes de dados.
* **Markdown:** Documentação técnica e estruturação do projeto.
* **GitHub:** Versionamento e exposição do portfólio.

---
**Desenvolvido por André Garcia** *Analista de Dados em transição*

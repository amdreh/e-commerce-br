# [ESTUDO DE CASO] Inteligência de Dados com SQL (Olist) 🛒

![Status](https://img.shields.io/badge/Status-Fase%20SQL%20Conclu%C3%ADda-green)
![Tecnologia](https://img.shields.io/badge/Tecnologia-SQL%20%2F%20SQLite-blue)

## 👤 Autor
**André Garcia** *Analista de Dados em transição do jornalismo cultural para o mercado de tecnologia. Em busca de oportunidade para atuar na transformação de dados brutos em inteligência estratégica e suporte à decisão.*

---

## 📖 Sobre o Projeto

### Introdução
Este repositório documenta a utilização da linguagem SQL para realizar a extração e transformação de dados (ETL) de um e-commerce brasileiro (Olist). O foco deste estudo não é apenas unir tabelas, mas garantir a **integridade da informação** e gerar indicadores que possam alimentar dashboards de marketing e vendas.

O projeto utiliza consultas complexas para identificar oportunidades de retenção de clientes e limpeza de inconsistências em bases de dados transacionais.

---

### 🚀 Objetivo do Projeto
O objetivo central é responder a perguntas críticas de negócio e preparar a base para futuras análises:
* Como garantir que os relatórios de categorias de produtos sejam legíveis e padronizados?
* Existem clientes cadastrados que nunca realizaram uma compra? (Identificação de Leads Frios)
* Quais são os clientes com maior tempo de inatividade (Recência) para campanhas de reativação?

---

### 🧠 Metodologia e Desenvolvimento
Nesta fase, utilizei SQL (SQLite) para implementar lógica de negócio diretamente nas consultas:

1. **Inner Join como Filtro de Qualidade:** Realizei a junção de categorias traduzidas, utilizando o JOIN para filtrar automaticamente dados "sujos" ou sem tradução, garantindo relatórios limpos.
2. **Análise de Leads Inativos (Left Join):** Utilizei a lógica de nulos para identificar se a base de clientes possui usuários que ainda não converteram, gerando insights para o time de Business Development.
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

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

1. **Inner join como filtro de qualidade:** JOIN utilizado para traduzir os nomes das categorias, bem como ao mesmo tempo filtrar dados preenchidos incorretamente ou sem tradução.
2. **Left join na busca leads inativos:** JOIN utilizado para constatar a inexistência de usuários que ainda não converteram, o que levanta a suspeita de que a base de dados pode estar incompleta.
3. **Join com o formato numérico Juliano:** JOIN utilizado para converter a data de texto em número, para assim calcular a quantidade de dias entre duas datas.
---

### 📂 Estrutura do Repositório
Os arquivos do projeto estão organizados da seguinte forma:

* **exports**: Contém os retornos das queries em formato csv;
* **source**: Contém as bases de dados originais em csv;
* **queries.sql**: Contém os códigos SQL das queries devidamente comentados;
* **readme.md**: É este arquivo, que contém a apresentação e esclarecimentos sobre o projeto.

---

### 🛠️ Tecnologias Utilizadas
* **SQLite / SQLiteStudio:** Manipulação do banco de dados;
* **Markdown:** Documentação técnica e estruturação do projeto;
* **GitHub:** Versionamento e exposição do portfólio.

---
**Desenvolvido por André Garcia** *Analista de Dados em transição*

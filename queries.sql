/*******************************************************************************
PROJETO: Estudo de Caso - Inteligência de Negócios com SQL
AUTOR: André Garcia
OBJETIVO: Extração de KPIs de Vendas, Tradução de Categorias e Análise de Recência.
FERRAMENTA: SQLite / SQLiteStudio
*******************************************************************************/

-- =============================================================================
-- 1. LIMPEZA E PADRONIZAÇÃO DE DADOS
-- Objetivo: Traduzir categorias e filtrar dados inconsistentes.
-- =============================================================================

-- No código abaixo obtive os nomes originais das categorias, em inlgês, tabela product_category_name_translation e juntei com ID do produto e o nome da categoria em português da tabela Products. As tabelas foram unidas pela coluna em comum (chave estrangeira) product_category_name 
SELECT
    p.product_id AS ID_Produto,
    p.product_category_name AS Categoria_Portugues,
    cn.product_category_name_english AS Categoria_Original
FROM products AS p
INNER JOIN product_category_name_translation AS cn
    -- As tabelas foram unidas pela coluna em comum (chave estrangeira) product_category_name
    ON p.product_category_name = cn.product_category_name;

-- NOTA: O INNER JOIN remove categorias sem tradução, agindo como filtro de qualidade.

/* 5 primeiros resultados:
| ID_Produto                       | Categoria_Portugues | Categoria_Original |
|----------------------------------|---------------------|--------------------|
|1e9e8ef04dbcff4541ed26657ea517e5  |perfumaria           |perfumery           |
|3aa071139cb16b67ca9e5dea641aaa2f  |artes                |art                 |
|96bd76ec8810374ed1b65e291975717f  |esporte_lazer        |sports_leisure      |
|cef67bcfe19066a932b7673e239eb23d  |bebes                |baby                |
|9dc1a7de274444849c219cff195d0b71  |utilidades_domesticas|housewares          |
*/


-- =============================================================================
-- 2. IDENTIFICAÇÃO DE LEADS FRIOS (LEFT JOIN)
-- Objetivo: Encontrar clientes cadastrados que nunca realizaram um pedido.
-- =============================================================================

-- No código abaixo obtenho o ID e cidade do cliente da tabela customers, e a ID do pedido da tabela orders. Como é um LEFT JOIN, o SQL vai pegar dados de customers e buscar um correspondente em orders.
SELECT
    c.customer_id AS ID_Cliente,
    c.customer_city AS Cidade_Cliente,
    o.order_id AS ID_Pedido
-- Foram unidas as tabelas customers e orders pela coluna em comum (chave estrangeira) customer_id.
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
-- É o filtro que vai fazer retornar só quem nunca fez uma compra buscando por valores nulos na coluna order_id da tabela orders.
WHERE o.order_id IS NULL;

/* Resultado:
| ID_Cliente | Cidade_Cliente | ID_Pedido |
|------------|----------------|-----------|
| [vazio]    | [vazio]        | [vazio]   |
|            |                |           |
*/

-- NOTA: Como o resultado foi vazio, validar a integridade da fonte de dados com o time de engenharia.

-- =============================================================================
-- 3. ANÁLISE DE RECÊNCIA (RETENÇÃO DE CLIENTES)
-- Objetivo: Calcular dias sem comprar para estratégias de reativação.
-- =============================================================================

SELECT 
    -- Obtém o ID do cliente, a data da última compra e a quantidade de dias que o cliente está sem comprar
    c.customer_id AS ID_Cliente,
    MAX(o.order_purchase_timestamp) AS Data_ultima_compra,
    -- Conversão para Julian Day para cálculo matemático de intervalo
    CAST(julianday('2018-10-17') - 
    julianday(MAX(o.order_purchase_timestamp)) AS INT) AS dias_sem_comprar
-- Une as tabelas orders e customers pela coluna em comum (chave estrangeira) customer_id.
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
-- Filtra só os que tiverem status 'delivered', agrupa por customer, ordena decrescentemente pelos dias sem comprar.
WHERE o.order_status = 'delivered'
GROUP BY c.customer_id
ORDER BY dias_sem_comprar DESC;

-- Objetivo: Clientes com mais 'dias_sem_comprar' são prioritários para réguas de desconto.

/* 5 primeiro resultados:
| ID_Cliente                       | Data_ultima_compra  | dias_sem_comprar |
|----------------------------------|---------------------|------------------|
| 37157e533f30abc219bc73fc0b62ca44 | 2016-09-15 12:16:38 | 761              |
| a95713444c68069502b4d440076a0841 | 2016-10-04 13:46:53 | 742              |
| f9516629ec4e3d348505e6b7b2586737 | 2016-10-05 13:17:33 | 741              |
| 20387588147d33b5c37895f87b321473 | 2016-10-05 15:02:51 | 741              |
| 3a49352e469506e78864775d7e780517 | 2016-10-05 15:02:51 | 741              |
*/

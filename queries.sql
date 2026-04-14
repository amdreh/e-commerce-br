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

SELECT
    p.product_id AS ID_Produto,
    p.product_category_name AS Categoria_Portugues,
    cn.product_category_name_english AS Categoria_Original
FROM products AS p
INNER JOIN product_category_name_translation AS cn
    ON p.product_category_name = cn.product_category_name;

-- NOTA: O INNER JOIN remove categorias sem tradução, agindo como filtro de qualidade.

/* Exemplo de Retorno (Top 5):
| ID_Produto                       | Categoria_Portugues | Categoria_Original |
|----------------------------------|---------------------|--------------------|
| 1e9e8ef04dbcff4541ed26657ea517e5 | perfumaria          | perfumery          |
| 3aa071139cb16b67ca9e5dea641aaa2f | artes               | art                |
| 96bd76ec8bca37b293f715973c633bc0 | esporte_lazer       | sports_leisure     |
| cef67bcfe19066a932b7673e239eb23d | bebes               | baby               |
| 9dc1a7c2754472db2192f082049d9097 | utilidades_domesticas| housewares        |
*/


-- =============================================================================
-- 2. IDENTIFICAÇÃO DE LEADS FRIOS (LEFT JOIN)
-- Objetivo: Encontrar clientes cadastrados que nunca realizaram um pedido.
-- =============================================================================

SELECT
    c.customer_id AS ID_Cliente,
    c.customer_city AS Cidade_Cliente,
    o.order_id AS ID_Pedido
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- NOTA: Caso o resultado seja vazio, validar a integridade da fonte de dados com o time de engenharia.

/* Exemplo de Retorno (Top 5):
| ID_Cliente | Cidade_Cliente | ID_Pedido |
|------------|----------------|-----------|
| [vazio]    | [vazio]        | [vazio]   |
|            |                |           |
*/


-- =============================================================================
-- 3. ANÁLISE DE RECÊNCIA (RETENÇÃO DE CLIENTES)
-- Objetivo: Calcular dias sem comprar para estratégias de reativação.
-- =============================================================================

SELECT 
    c.customer_id AS ID_Cliente,
    MAX(o.order_purchase_timestamp) AS Data_ultima_compra,
    -- Conversão para Julian Day para cálculo matemático de intervalo
    CAST(julianday('2018-10-17') - 
    julianday(MAX(o.order_purchase_timestamp)) AS INT) AS dias_sem_comprar
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_id
ORDER BY dias_sem_comprar DESC;

-- INSIGHT: Clientes com alto 'dias_sem_comprar' são prioritários para réguas de desconto.

/* Exemplo de Retorno (Top 5):
| ID_Cliente                       | Data_ultima_compra  | dias_sem_comprar |
|----------------------------------|---------------------|------------------|
| 37157e533f30abc219bc73fc0b62ca44 | 2016-09-15 12:16:38 | 761              |
| a95713444c68069502b4d440076a0841 | 2016-10-04 13:46:53 | 742              |
| f9516629ec4e3d348505e6b7b2586737 | 2016-10-05 13:17:33 | 741              |
| 20387588147d33b5c37895f87b321473 | 2016-10-05 15:02:51 | 741              |
| 3a49352e469506e78864775d7e780517 | 2016-10-05 15:02:51 | 741              |
*/

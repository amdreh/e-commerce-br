/*******************************************************************************
PROJETO: Estudo de Caso Olist - Inteligência de Negócios com SQL
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

-- OBSERVAÇÃO ANALÍTICA: Caso o resultado seja vazio, validar a integridade da 
-- fonte de dados com o time de engenharia.


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

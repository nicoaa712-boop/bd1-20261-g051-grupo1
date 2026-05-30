--
-- Scripts de CONSULTA CON PARÁMETROS de la Base de Datos  - SGBD PostgreSQL
-- 

-- =========================================================
-- CONSULTA PREPARADA
-- FILTRAR PEDIDOS POR:
-- 1. DEPARTAMENTO
-- 2. PRODUCTO
-- 3. TOTAL MÍNIMO EN COP
-- =========================================================

PREPARE consulta_pedidos (
    VARCHAR,
    VARCHAR,
    NUMERIC
)

AS

SELECT

a.departamento,

a.municipio,

p.nombre_producto,

COUNT(pe.id_pedido)
AS total_pedidos,

SUM(
pp.cantidad * pp.precio_unitario
)
AS total_ventas_cop

FROM pedido pe

INNER JOIN pedido_producto pp
ON pe.id_pedido = pp.id_pedido

INNER JOIN producto p
ON pp.id_producto = p.id_producto

INNER JOIN apiario a
ON TRUE

WHERE

a.departamento = $1
AND
p.nombre_producto = $2

GROUP BY

a.departamento,
a.municipio,
p.nombre_producto

HAVING

SUM(
pp.cantidad * pp.precio_unitario
) > $3

ORDER BY
total_ventas_cop DESC;

-- =========================================================
-- EJECUCIÓN DE LA CONSULTA PREPARADA
-- =========================================================

EXECUTE consulta_pedidos(
    'Antioquia',
    'Miel',
    100000
);
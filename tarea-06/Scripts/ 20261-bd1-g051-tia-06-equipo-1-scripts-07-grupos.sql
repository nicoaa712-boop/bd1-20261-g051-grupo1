--
-- Scripts de AGRUPAMIENTOS de la Base de Datos  - SGBD PostgreSQL
--
--
-- Scripts de CONSULTAS DE AGRUPAMIENTO
-- GROUP BY y HAVING
-- SGBD PostgreSQL
--

-- =========================================================
-- CONSULTA #1
-- AGRUPAR PRODUCTORES POR DEPARTAMENTO Y MUNICIPIO
-- =========================================================

SELECT

a.departamento,
a.municipio,

COUNT(ap.id_apicultor)
AS total_productores

FROM apiario a

INNER JOIN apicultor ap
ON a.id_apicultor = ap.id_apicultor

GROUP BY
a.departamento,
a.municipio

ORDER BY
a.departamento ASC,
a.municipio ASC;

-- =========================================================
-- CONSULTA #2
-- AGRUPAR CONSUMIDORES POR DEPARTAMENTO Y MUNICIPIO
-- =========================================================

SELECT

m.departamento,
m.municipio,

COUNT(c.id_consumidor)
AS total_consumidores

FROM mercado m

INNER JOIN consumidor c
ON TRUE

GROUP BY
m.departamento,
m.municipio

ORDER BY
m.departamento ASC,
m.municipio ASC;

-- =========================================================
-- CONSULTA #3
-- AGRUPAR PRODUCTORES DE UN DEPARTAMENTO
-- POR MUNICIPIO Y APIARIO
-- =========================================================

SELECT

a.departamento,
a.municipio,

a.nombre_apiario,

COUNT(ap.id_apicultor)
AS total_productores

FROM apiario a

INNER JOIN apicultor ap
ON a.id_apicultor = ap.id_apicultor

WHERE a.departamento = 'Antioquia'

GROUP BY

a.departamento,
a.municipio,
a.nombre_apiario

ORDER BY
a.municipio ASC;

-- =========================================================
-- CONSULTA #4
-- AGRUPAR PEDIDOS DE UN DEPARTAMENTO
-- POR MUNICIPIO Y APIARIO
-- TOTAL EN COP
-- USANDO HAVING
-- =========================================================

SELECT

a.departamento,
a.municipio,

a.nombre_apiario,

SUM(
pp.cantidad * pp.precio_unitario
)
AS total_pedidos_cop

FROM pedido pe

INNER JOIN pedido_producto pp
ON pe.id_pedido = pp.id_pedido

INNER JOIN apiario a
ON a.id_apiario IN (
    SELECT id_apiario
    FROM apiario
)

WHERE a.departamento = 'Antioquia'

GROUP BY

a.departamento,
a.municipio,
a.nombre_apiario

HAVING
SUM(pp.cantidad * pp.precio_unitario) > 100000

ORDER BY
total_pedidos_cop DESC;

-- =========================================================
-- CONSULTA #5
-- AGRUPAR PRODUCTOS PEDIDOS
-- POR DEPARTAMENTO Y MUNICIPIO
-- =========================================================

SELECT

a.departamento,
a.municipio,

p.nombre_producto,

SUM(pp.cantidad)
AS total_pedidos

FROM pedido_producto pp

INNER JOIN producto p
ON pp.id_producto = p.id_producto

INNER JOIN apiario a
ON a.id_apiario IN (
    SELECT id_apiario
    FROM apiario
)

GROUP BY

a.departamento,
a.municipio,
p.nombre_producto

ORDER BY
total_pedidos DESC;

-- =========================================================
-- PREGUNTA 1
-- PRODUCTOR QUE MÁS RECIBIÓ PEDIDOS
-- =========================================================

SELECT

ap.id_apicultor,

ap.nombre,
ap.apellido,

COUNT(pe.id_pedido)
AS total_pedidos

FROM apicultor ap

INNER JOIN apiario a
ON ap.id_apicultor = a.id_apicultor

INNER JOIN pedido pe
ON TRUE

GROUP BY

ap.id_apicultor,
ap.nombre,
ap.apellido

ORDER BY
total_pedidos DESC

LIMIT 1;

-- =========================================================
-- PREGUNTA 2
-- DEPARTAMENTO CON MÁS Y MENOS PEDIDOS
-- =========================================================

SELECT

a.departamento,

COUNT(pe.id_pedido)
AS total_pedidos

FROM apiario a

INNER JOIN pedido pe
ON TRUE

GROUP BY
a.departamento

ORDER BY
total_pedidos DESC;

-- =========================================================
-- PREGUNTA 3
-- PRODUCTO CON MENOS PEDIDOS
-- =========================================================

SELECT

p.nombre_producto,

SUM(pp.cantidad)
AS total_pedidos

FROM pedido_producto pp

INNER JOIN producto p
ON pp.id_producto = p.id_producto

GROUP BY
p.nombre_producto

ORDER BY
total_pedidos ASC

LIMIT 1;

-- =========================================================
-- PREGUNTA 4
-- MUNICIPIO CON MAYOR MONTO EN PEDIDOS
-- =========================================================

SELECT

a.municipio,

SUM(
pp.cantidad * pp.precio_unitario
)
AS total_monto_cop

FROM pedido_producto pp

INNER JOIN pedido pe
ON pp.id_pedido = pe.id_pedido

INNER JOIN apiario a
ON TRUE

GROUP BY
a.municipio

ORDER BY
total_monto_cop DESC

LIMIT 1;

--
-- Scripts de LISTADOS de la Base de Datos  - SGBD PostgreSQL
--
-- 

--
-- Scripts de CONSULTAS DE LISTADOS
-- SGBD PostgreSQL
--

-- =========================================================
-- CONSULTA #1
-- LISTAR TODOS LOS MUNICIPIOS
-- ORDEN ALFABÉTICO ASCENDENTE
-- SIN JOIN
-- =========================================================

SELECT DISTINCT municipio
FROM apiario
ORDER BY municipio ASC;

-- =========================================================
-- CONSULTA #2
-- LISTAR DEPARTAMENTOS CON SUS MUNICIPIOS
-- 1 JOIN
-- =========================================================

SELECT
m.departamento,
m.municipio

FROM mercado m

INNER JOIN apiario a
ON m.municipio = a.municipio

GROUP BY
m.departamento,
m.municipio

ORDER BY
m.departamento ASC,
m.municipio ASC;

-- =========================================================
-- CONSULTA #3
-- LISTAR MUNICIPIOS CON SUS APICULTORES
-- Y APIARIOS RESPECTIVOS
-- 2 JOIN
-- =========================================================

SELECT
a.municipio,

ap.id_apicultor,
ap.nombre,
ap.apellido,

a.nombre_apiario

FROM apiario a

INNER JOIN apicultor ap
ON a.id_apicultor = ap.id_apicultor

INNER JOIN mercado m
ON a.municipio = m.municipio

ORDER BY
a.municipio ASC,
ap.nombre ASC;

-- =========================================================
-- CONSULTA #4
-- LISTAR APICULTORES CON SUS APIARIOS
-- Y PRODUCTOS QUE ELABORA Y VENDE
-- 3 JOIN
-- =========================================================

SELECT
ap.id_apicultor,

ap.nombre,
ap.apellido,

a.nombre_apiario,

p.nombre_producto,
p.precio

FROM apicultor ap

INNER JOIN apiario a
ON ap.id_apicultor = a.id_apicultor

INNER JOIN apicultor_producto app
ON ap.id_apicultor = app.id_apicultor

INNER JOIN producto p
ON app.id_producto = p.id_producto

ORDER BY
ap.nombre ASC,
a.nombre_apiario ASC;

-- =========================================================
-- CONSULTA #5
-- LISTAR PEDIDOS DE UN MUNICIPIO
-- CON PRODUCTOR Y CONSUMIDOR
-- 3 JOIN
-- =========================================================

SELECT

pe.id_pedido,

pe.fecha_pedido,

a.municipio,

ap.id_apicultor,
(ap.nombre || ' ' || ap.apellido)
AS productor,

c.id_consumidor,
(c.nombre || ' ' || c.apellido)
AS consumidor

FROM pedido pe

INNER JOIN consumidor c
ON pe.id_consumidor = c.id_consumidor

INNER JOIN apiario a
ON a.municipio = 'Medellín (Santa Elena)'

INNER JOIN apicultor ap
ON a.id_apicultor = ap.id_apicultor

ORDER BY
pe.fecha_pedido ASC;
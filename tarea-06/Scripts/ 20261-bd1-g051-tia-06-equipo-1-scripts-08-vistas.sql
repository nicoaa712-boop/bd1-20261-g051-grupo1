--
-- Scripts de CONSULTAS CON VISTAS
-- VIEW - SGBD PostgreSQL
--

-- =========================================================
-- CREAR VISTA
-- PRODUCTORES, APIARIOS Y PRODUCTOS VENDIDOS
-- =========================================================

CREATE VIEW vista_productores_ventas AS

SELECT

ap.id_apicultor,

ap.nombre,
ap.apellido,

a.departamento,
a.municipio,

a.nombre_apiario,

p.nombre_producto,

SUM(pp.cantidad)
AS total_vendido,

SUM(
pp.cantidad * pp.precio_unitario
)
AS total_ventas_cop

FROM apicultor ap

INNER JOIN apiario a
ON ap.id_apicultor = a.id_apicultor

INNER JOIN apicultor_producto app
ON ap.id_apicultor = app.id_apicultor

INNER JOIN producto p
ON app.id_producto = p.id_producto

INNER JOIN pedido_producto pp
ON p.id_producto = pp.id_producto

WHERE
a.departamento = 'Antioquia'

GROUP BY

ap.id_apicultor,
ap.nombre,
ap.apellido,

a.departamento,
a.municipio,

a.nombre_apiario,

p.nombre_producto

HAVING
SUM(pp.cantidad) > 2;

-- =========================================================
-- CONSULTAR VISTA
-- =========================================================

SELECT *
FROM vista_productores_ventas
ORDER BY total_ventas_cop DESC;

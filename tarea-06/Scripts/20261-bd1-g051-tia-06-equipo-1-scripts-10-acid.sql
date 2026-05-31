--
-- Scripst de VALIDACIÓN PROPIEDADES ACID de la Base de Datos  - SGBD PostgreSQL
-- 
--
-- Scripts de VALIDACIÓN DE PROPIEDADES ACID
-- SGBD PostgreSQL
--

-- =========================================================
-- 1. ATOMICIDAD
-- BEGIN - ROLLBACK
-- =========================================================

-- VERIFICAR DATOS ANTES

SELECT *
FROM producto
WHERE nombre_producto = 'Miel';

SELECT *
FROM mercado
WHERE municipio = 'Cali';

-- INICIAR TRANSACCIÓN

BEGIN;

-- ACTUALIZAR PRODUCTO

UPDATE producto
SET precio = 50000
WHERE nombre_producto = 'Miel';

-- ACTUALIZAR MERCADO

UPDATE mercado
SET direccion_mercado = 'Carrera 100 #20-50'
WHERE municipio = 'Cali';

-- VERIFICAR CAMBIOS TEMPORALES

SELECT *
FROM producto
WHERE nombre_producto = 'Miel';

SELECT *
FROM mercado
WHERE municipio = 'Cali';

-- CANCELAR TRANSACCIÓN

ROLLBACK;

-- VERIFICAR QUE LOS DATOS
-- REGRESARON AL ESTADO ORIGINAL

SELECT *
FROM producto
WHERE nombre_producto = 'Miel';

SELECT *
FROM mercado
WHERE municipio = 'Cali';

-- =========================================================
-- 2. CONSISTENCIA
-- =========================================================

-- ---------------------------------------------------------
-- CASO 1:
-- INSERT CON PRIMARY KEY DUPLICADA
-- ---------------------------------------------------------

INSERT INTO rol (
    id_rol,
    nombre_rol
)

VALUES (
    (
        SELECT id_rol
        FROM rol
        LIMIT 1
    ),

    'Rol Duplicado'
);

-- EXPLICACIÓN:
-- FALLA PORQUE LA PRIMARY KEY YA EXISTE

-- ---------------------------------------------------------
-- CASO 2:
-- UPDATE QUE VIOLA NOT NULL
-- ---------------------------------------------------------

UPDATE producto
SET id_lote = NULL
WHERE id_producto = (
    SELECT id_producto
    FROM producto
    LIMIT 1
);

-- EXPLICACIÓN:
-- FALLA PORQUE id_lote NO PERMITE VALORES NULL

-- ---------------------------------------------------------
-- CASO 3:
-- DELETE QUE VIOLA FOREIGN KEY
-- ---------------------------------------------------------

DELETE FROM producto
WHERE id_producto = (
    SELECT id_producto
    FROM pedido_producto
    LIMIT 1
);

-- EXPLICACIÓN:
-- FALLA PORQUE EL PRODUCTO
-- ESTÁ REFERENCIADO EN pedido_producto

-- =========================================================
-- 3. AISLAMIENTO
-- =========================================================

-- CASO HIPOTÉTICO:

-- USUARIO 1:
-- REALIZA UNA TRANSACCIÓN PARA
-- ACTUALIZAR EL PRECIO DE UN PRODUCTO

-- USUARIO 2:
-- INTENTA CONSULTAR EL MISMO PRODUCTO
-- MIENTRAS LA TRANSACCIÓN SIGUE ABIERTA

-- EL NIVEL DE AISLAMIENTO EVITA
-- QUE EL USUARIO 2 VEA DATOS
-- PARCIALES O NO CONFIRMADOS

-- =========================================================
-- 4. DURABILIDAD
-- COMMIT
-- =========================================================

-- CONSULTA ANTES

SELECT *
FROM producto
WHERE nombre_producto = 'Polen';

-- INICIAR TRANSACCIÓN

BEGIN;

-- ACTUALIZAR DATO

UPDATE producto
SET precio = 25000
WHERE nombre_producto = 'Polen';

-- CONFIRMAR CAMBIOS

COMMIT;

-- CONSULTA DESPUÉS

SELECT *
FROM producto
WHERE nombre_producto = 'Polen';

-- EL CAMBIO QUEDA ALMACENADO
-- PERMANENTEMENTE EN LA BASE DE DATOS

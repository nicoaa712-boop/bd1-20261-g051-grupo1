--
-- Scripts de DELETE de la Base de Datos - SGBD PostgreSQL
--

-- =========================================================
-- INSERTAR PRODUCTO TEMPORAL
-- =========================================================

INSERT INTO producto (
    id_producto,
    id_lote,
    nombre_producto,
    precio,
    unidad_medida
)

VALUES (
    gen_random_uuid(),

    (
        SELECT id_lote
        FROM lote
        LIMIT 1
    ),

    'Miel Experimental',

    50000,

    '1 kg'
);

-- =========================================================
-- ELIMINAR PRODUCTO TEMPORAL
-- =========================================================

DELETE FROM producto
WHERE nombre_producto = 'Miel Experimental';

-- =========================================================
-- INSERTAR APICULTOR TEMPORAL
-- =========================================================

INSERT INTO apicultor (
    id_apicultor,
    id_rol,
    nombre,
    apellido,
    identificacion,
    telefono,
    email
)

VALUES (

    gen_random_uuid(),

    (
        SELECT id_rol
        FROM rol
        LIMIT 1
    ),

    'Carlos',

    'Temporal',

    'TEMP-999',

    '3000000000',

    'temporal@gmail.com'
);

-- =========================================================
-- ELIMINAR APICULTOR TEMPORAL
-- =========================================================

DELETE FROM apicultor
WHERE identificacion = 'TEMP-999';
-- =========================================================
-- TABLAS NUEVAS AGREGADAS AL MODELO FÍSICO
-- =========================================================

-- =========================================================
-- TABLA MERCADO
-- =========================================================

CREATE TABLE mercado (
    id_mercado UUID PRIMARY KEY,
    nombre_mercado TEXT NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) UNIQUE NOT NULL,
    tipo_mercado VARCHAR(30) NOT NULL
);

-- =========================================================
-- TABLA APICULTOR_PRODUCTO
-- =========================================================

CREATE TABLE apicultor_producto (

    id_apicultor UUID NOT NULL,
    id_producto UUID NOT NULL,

    PRIMARY KEY (
        id_apicultor,
        id_producto
    ),

    CONSTRAINT fk_ap_producto_apicultor
    FOREIGN KEY (id_apicultor)
    REFERENCES apicultor(id_apicultor),

    CONSTRAINT fk_ap_producto_producto
    FOREIGN KEY (id_producto)
    REFERENCES producto(id_producto)
);

-- =========================================================
-- MODIFICACIÓN TABLA APIARIO
-- =========================================================

ALTER TABLE apiario
ADD COLUMN ubicacion_geografica JSONB;

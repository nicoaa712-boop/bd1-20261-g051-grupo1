--
-- Script de MANIPULACIÓN DE DATOS JSON
-- SGBD PostgreSQL
--

-- =========================================================
-- INSERTAR DATO JSONB
-- =========================================================

UPDATE apiario

SET ubicacion_geografica =

'{
    "coordenadas": {
        "latitud": 6.25184,
        "longitud": -75.56359
    },

    "altitud_msnm": 1550,

    "region": {
        "pais": "Colombia",
        "departamento": "Antioquia",
        "municipio": "Medellín",
        "vereda": "Santa Elena"
    },

    "tipo_zona": "rural",

    "condiciones_ambientales": {
        "flora_dominante": [
            "eucalipto",
            "café"
        ],

        "fuente_agua_cercana": true
    }

}'::jsonb

WHERE id_apiario = (
    SELECT id_apiario
    FROM apiario
    LIMIT 1
);

-- =========================================================
-- CONSULTAR DATO JSONB
-- =========================================================

SELECT

nombre_apiario,

ubicacion_geografica -> 'region' ->> 'departamento'
AS departamento,

ubicacion_geografica -> 'region' ->> 'municipio'
AS municipio,

ubicacion_geografica ->> 'tipo_zona'
AS tipo_zona

FROM apiario

WHERE
ubicacion_geografica -> 'region' ->> 'departamento'
= 'Antioquia';

-- =========================================================
-- ACTUALIZAR DATO DENTRO DEL JSONB
-- =========================================================

UPDATE apiario

SET ubicacion_geografica =

jsonb_set(

    ubicacion_geografica,

    '{tipo_zona}',

    '"periurbana"'

)

WHERE id_apiario = (
    SELECT id_apiario
    FROM apiario
    LIMIT 1
);

-- =========================================================
-- VERIFICAR ACTUALIZACIÓN
-- =========================================================

SELECT

nombre_apiario,

ubicacion_geografica ->> 'tipo_zona'
AS tipo_zona_actualizada

FROM apiario

WHERE id_apiario = (
    SELECT id_apiario
    FROM apiario
    LIMIT 1
);
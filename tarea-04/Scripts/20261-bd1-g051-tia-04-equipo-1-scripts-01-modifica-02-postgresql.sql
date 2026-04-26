--
-- Scripts de Modificación de la Base de Datos - SGBD PostgreSQL
-- Todas las instrucciones se deben realizar en secuencia sin errores
-- Probar los scripts en detalle
--

--
-- Modificación de la Base de Datos
-- 


--
-- 1.- DATOS SEMI-ESTRUCTURADOS PARA DATOS IOT (Sensores)
-- Gestionar el campo "datos_ambientales" en cualquier tabla que considere adecuada o
-- Si es necesario, crear una nueva
-- 1.- "agregar" un campo tipo JSON o JSNOB
-- 2.- Agregar un par de registros
-- 3.- Consultar la información agregada
-- 4.- Describir el campo y explicar su propósito
--
-- 1.1
ALTER TABLE sensor_iot ADD COLUMN datos_ambientales JSONB;

-- 1.2
INSERT INTO sensor_iot (id_sensor_iot, id_apiario, tipo_sensor, modelo, estado_sensor, datos_ambientales)
VALUES 
    (gen_random_uuid(), gen_random_uuid(), 'temperatura', 'DHT22', TRUE,
     '{"lecturas":[{"fecha":"2026-04-22T10:00:00","valor":28.5},{"fecha":"2026-04-22T11:00:00","valor":29.1}]}'),
    (gen_random_uuid(), gen_random_uuid(), 'humedad', 'HUM100', TRUE,
     '{"lecturas":[{"fecha":"2026-04-22T10:00:00","valor":65.2},{"fecha":"2026-04-22T11:00:00","valor":64.8}]}');

-- 1.3
SELECT id_sensor_iot, datos_ambientales->'lecturas' AS lecturas
FROM sensor_iot;

-- 1.4
El campo datos_ambientales permite almacenar lecturas de sensores en formato semi‑estructurado (JSONB), esto es útil para manejar datos IoT que pueden variar en cantidad y estructura (ej. múltiples lecturas de temperatura, humedad, etc.) sin necesidad de alterar el esquema relacional cada vez.

--
-- 2.- DATOS SEMI-ESTRUCTURADOS (PARA BIG DATA o IOT)
-- Gestionar un nuevo campo "nombre_campo" (de su propia creación) en cualquier tabla (de las existentes) que considere adecuada
-- 1.- "agregar" un campo tipo JSON o JSONB
-- 2.- Agregar un par de registros de información
-- 3.- Consultar la información agregada
-- 4.- Describir el campo y explicar su propósito
--
-- 2.1
ALTER TABLE registro_ambiental ADD COLUMN metadata JSONB;

-- 2.2
INSERT INTO registro_ambiental (id_registro, id_sensor_iot, fecha_registro, temperatura, humedad, tipo_alerta, metadata)
VALUES
    (gen_random_uuid(), gen_random_uuid(), NOW(), 27.3, 60.1, FALSE,
     '{"ubicacion":"Apiario Norte","condiciones":{"viento":"moderado","lluvia":"leve"}}'),
    (gen_random_uuid(), gen_random_uuid(), NOW(), 30.2, 55.8, TRUE,
     '{"ubicacion":"Apiario Sur","condiciones":{"viento":"fuerte","lluvia":"ninguna"}}');

-- 2.3
SELECT id_registro, metadata->>'ubicacion' AS ubicacion,
       metadata->'condiciones'->>'viento' AS viento
FROM registro_ambiental;

-- 2.4
El campo metadata permite enriquecer los registros ambientales con información contextual (ubicación, condiciones climáticas, observaciones adicionales) y esto facilita análisis de big data, correlaciones y consultas flexibles sin necesidad de añadir columnas fijas para cada tipo de dato.

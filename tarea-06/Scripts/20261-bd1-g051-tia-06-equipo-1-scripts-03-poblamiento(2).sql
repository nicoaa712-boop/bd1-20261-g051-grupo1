-- =========================================================
-- SCRIPTS DE POBLAMIENTO - POSTGRESQL
-- BD APICULTURA
-- ESTRUCTURA CON UUID FIJOS PARA RELACIONES EXACTAS
-- =========================================================

-- =========================================================
-- 1. TABLAS MAESTRAS (INDEPENDIENTES)
-- =========================================================

-- TABLA: rol
INSERT INTO rol (id_rol, nombre_rol, descripcion) 
VALUES ('11111111-1111-1111-1111-111111111111', 'Apicultor', 'Productor y dueño de apiarios');

INSERT INTO rol (id_rol, nombre_rol, descripcion) 
VALUES ('22222222-2222-2222-2222-222222222222', 'Consumidor', 'Cliente comprador');

INSERT INTO rol (id_rol, nombre_rol, descripcion) 
VALUES ('33333333-3333-3333-3333-333333333333', 'Entidad Gubernamental', 'Ente regulador');

-- TABLA: mercado
INSERT INTO mercado (id_mercado, nombre_mercado, departamento, municipio, tipo_mercado, direccion_mercado) 
VALUES ('44444444-4444-4444-4444-444444444444', 'Mercado de Santa Elena', 'Antioquia', 'Medellín (Santa Elena)', 'Local', 'Parque Principal');

-- =========================================================
-- 2. TABLAS DE USUARIOS (DEPENDEN DE ROL)
-- =========================================================

-- TABLA: apicultor (Usa el id_rol 1111...)
INSERT INTO apicultor (id_apicultor, id_rol, nombre, apellido, identificacion, telefono, email) 
VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'Carlos', 'Restrepo', 'CC-1001', '3001112233', 'carlos@correo.com');

-- TABLA: consumidor (Usa el id_rol 2222...)
INSERT INTO consumidor (id_consumidor, id_rol, nombre, apellido, email_consumidor, telefono_consumidor, direccion) 
VALUES ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', 'Andrés', 'García', 'andres.g@correo.com', '3200001111', 'Calle 10 # 20-30 Medellín');

-- TABLA: entidad_gubernamental (Usa el id_rol 3333...)
INSERT INTO entidad_gubernamental (id_entidad_gubernamental, id_rol, nombre, email, telefono_entidad) 
VALUES ('cccccccc-cccc-cccc-cccc-cccccccccccc', '33333333-3333-3333-3333-333333333333', 'ICA', 'contacto@ica.gov.co', '6017777777');

-- =========================================================
-- 3. GESTIÓN DE APIARIOS Y SENSORES (DEPENDEN DE APICULTOR)
-- =========================================================

-- TABLA: apiario (Usa el id_apicultor aaaa...)
INSERT INTO apiario (id_apiario, id_apicultor, nombre_apiario, departamento, municipio, direccion_apiario, ubicacion_geografica) 
VALUES (
    'dddddddd-dddd-dddd-dddd-dddddddddddd',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 
    'Apiario La Montaña', 'Antioquia', 'Medellín (Santa Elena)', 'Vereda Santa Elena',
    '{"coordenadas": {"latitud": 6.25184, "longitud": -75.56359}, "altitud_msnm": 1550, "tipo_zona": "rural"}'
);

-- TABLA: colmena (Depende del apiario dddd...)
INSERT INTO colmena (id_colmena, id_apiario, nombre_colmena, estado_colmena) 
VALUES ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'dddddddd-dddd-dddd-dddd-dddddddddddd', 'Colmena 1 - Reina', true);

-- TABLA: sensor_iot (Depende del apiario dddd...)
INSERT INTO sensor_iot (id_sensor_iot, id_apiario, tipo_sensor, modelo, estado_sensor) 
VALUES ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'dddddddd-dddd-dddd-dddd-dddddddddddd', 'Temperatura', 'Sensor-X10', true);

-- TABLA: registro_ambiental (Depende del sensor ffff...)
INSERT INTO registro_ambiental (id_registro, id_sensor_iot, fecha_registro, temperatura, humedad, tipo_alerta) 
VALUES ('1a1a1a1a-1a1a-1a1a-1a1a-1a1a1a1a1a1a', 'ffffffff-ffff-ffff-ffff-ffffffffffff', CURRENT_TIMESTAMP, 35.50, 65.00, true);

-- TABLA: alerta (Depende del registro 1a1a...)
INSERT INTO alerta (id_alerta, id_registro, tipo_alerta, descripcion, fecha_alerta, estado_alerta) 
VALUES ('2b2b2b2b-2b2b-2b2b-2b2b-2b2b2b2b2b2b', '1a1a1a1a-1a1a-1a1a-1a1a-1a1a1a1a1a1a', 'Alta Temperatura', 'Superó los 35 grados', CURRENT_TIMESTAMP, false);

-- =========================================================
-- 4. CADENA DE PRODUCCIÓN: COSECHA -> LOTE -> PRODUCTO
-- =========================================================

-- TABLA: cosecha (Depende del apiario dddd...)
INSERT INTO cosecha (id_cosecha, id_apiario, fecha_cosecha, volumen_cosecha, condiciones_ambientales) 
VALUES ('3c3c3c3c-3c3c-3c3c-3c3c-3c3c3c3c3c3c', 'dddddddd-dddd-dddd-dddd-dddddddddddd', CURRENT_DATE, 20.00, true);

-- TABLA: lote (Depende de la cosecha 3c3c...)
INSERT INTO lote (id_lote, id_cosecha, codigo_qr, fecha_produccion, volumen_total, estado_lote) 
VALUES ('4d4d4d4d-4d4d-4d4d-4d4d-4d4d4d4d4d4d', '3c3c3c3c-3c3c-3c3c-3c3c-3c3c3c3c3c3c', 'QR-MIEL-001', CURRENT_DATE, 20.00, true);

-- TABLA: producto (Depende del lote 4d4d...)
INSERT INTO producto (id_producto, id_lote, nombre_producto, precio, unidad_medida) 
VALUES ('5e5e5e5e-5e5e-5e5e-5e5e-5e5e5e5e5e5e', '4d4d4d4d-4d4d-4d4d-4d4d-4d4d4d4d4d4d', 'Miel', 25000.00, '1 kg');

-- =========================================================
-- 5. COMERCIALIZACIÓN: PEDIDOS Y PAGOS
-- =========================================================

-- TABLA: pedido (Depende del consumidor bbbb...)
INSERT INTO pedido (id_pedido, id_consumidor, fecha_pedido, estado_pedido, direccion_entrega) 
VALUES ('6f6f6f6f-6f6f-6f6f-6f6f-6f6f6f6f6f6f', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', CURRENT_DATE, true, 'Calle 10 # 20-30 Medellín');

-- TABLA: pago (Depende del pedido 6f6f...)
INSERT INTO pago (id_pago, id_pedido, fecha_pago, metodo_pago, monto, estado_pago, referencia) 
VALUES ('7a7a7a7a-7a7a-7a7a-7a7a-7a7a7a7a7a7a', '6f6f6f6f-6f6f-6f6f-6f6f-6f6f6f6f6f6f', CURRENT_TIMESTAMP, 'Transferencia', 25000.00, true, 'REF-9988');

-- =========================================================
-- 6. CERTIFICACIONES (CRUZA ENTIDAD, LOTE Y APICULTOR)
-- =========================================================

-- TABLA: certificacion (Usa apicultor aaaa, lote 4d4d, entidad cccc)
INSERT INTO certificacion (id_certificacion, numero_certificacion, fecha_certificacion, inspeccion, estado, id_apicultor, id_lote, id_entidad) 
VALUES ('8b8b8b8b-8b8b-8b8b-8b8b-8b8b8b8b8b8b', 'CERT-001', CURRENT_DATE, 'Aprobada', 'Activa', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '4d4d4d4d-4d4d-4d4d-4d4d-4d4d4d4d4d4d', 'cccccccc-cccc-cccc-cccc-cccccccccccc');

-- =========================================================
-- 7. TABLAS INTERMEDIAS (MUCHOS A MUCHOS)
-- =========================================================

-- TABLA: apicultor_producto (Carlos aaaa... hace Miel 5e5e...)
INSERT INTO apicultor_producto (id_apicultor, id_producto) 
VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '5e5e5e5e-5e5e-5e5e-5e5e-5e5e5e5e5e5e');

-- TABLA: pedido_producto (Pedido 6f6f... incluye Miel 5e5e...)
INSERT INTO pedido_producto (id_pedido, id_producto, cantidad, precio_unitario) 
VALUES ('6f6f6f6f-6f6f-6f6f-6f6f-6f6f6f6f6f6f', '5e5e5e5e-5e5e-5e5e-5e5e-5e5e5e5e5e5e', 1, 25000.00);

-- TABLA: lote_certificacion (Lote 4d4d... tiene certificado 8b8b...)
INSERT INTO lote_certificacion (id_lote, id_certificacion, fecha_asignacion) 
VALUES ('4d4d4d4d-4d4d-4d4d-4d4d-4d4d4d4d4d4d', '8b8b8b8b-8b8b-8b8b-8b8b-8b8b8b8b8b8b', CURRENT_TIMESTAMP);

-- TABLA: colmena_cosecha (Colmena eeee... aportó a cosecha 3c3c...)
INSERT INTO colmena_cosecha (id_colmena, id_cosecha, volumen_colmena) 
VALUES ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '3c3c3c3c-3c3c-3c3c-3c3c-3c3c3c3c3c3c', 5.50);

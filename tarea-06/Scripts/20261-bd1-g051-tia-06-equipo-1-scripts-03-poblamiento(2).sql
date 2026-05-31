-- =========================================================
-- SCRIPTS DE POBLAMIENTO - POSTGRESQL
-- BD APICULTURA
-- ESTRUCTURA CON UUID FIJOS PARA RELACIONES EXACTAS
-- =========================================================

-- =========================================================
-- 1. TABLAS MAESTRAS (INDEPENDIENTES)
-- =========================================================

-- TABLA: rol
INSERT INTO rol (id_rol, nombre_rol, descripcion) VALUES 
('11111111-1111-1111-1111-000000000001', 'Apicultor', 'Productor'),
('11111111-1111-1111-1111-000000000002', 'Consumidor', 'Cliente comprador'),
('11111111-1111-1111-1111-000000000003', 'Entidad Gubernamental', 'Ente de control y certificación');


-- TABLA: mercado
INSERT INTO mercado (id_mercado, nombre_mercado, departamento, municipio, tipo_mercado) VALUES 
('22222222-2222-2222-2222-000000000001', 'Mercado Sta Fe', 'Antioquia', 'Santa Fe de Antioquia', 'Local'),
('22222222-2222-2222-2222-000000000002', 'Mercado Sta Elena', 'Antioquia', 'Medellín (Santa Elena)', 'Regional'),
('22222222-2222-2222-2222-000000000003', 'Mercado Fusa', 'Cundinamarca', 'Fusagasugá', 'Local'),
('22222222-2222-2222-2222-000000000004', 'Mercado Girardot', 'Cundinamarca', 'Girardot', 'Local'),
('22222222-2222-2222-2222-000000000005', 'Mercado Tunja', 'Boyacá', 'Tunja', 'Nacional'),
('22222222-2222-2222-2222-000000000006', 'Mercado Sogamoso', 'Boyacá', 'Sogamoso', 'Local'),
('22222222-2222-2222-2222-000000000007', 'Mercado BGA', 'Santander', 'Bucaramanga', 'Nacional'),
('22222222-2222-2222-2222-000000000008', 'Mercado Neiva', 'Huila', 'Neiva', 'Regional'),
('22222222-2222-2222-2222-000000000009', 'Mercado Villavo', 'Meta', 'Villavicencio', 'Regional'),
('22222222-2222-2222-2222-000000000010', 'Mercado Montería', 'Córdoba', 'Monteria', 'Regional'),
('22222222-2222-2222-2222-000000000011', 'Mercado Sincelejo', 'Sucre', 'Sincelejo', 'Local'),
('22222222-2222-2222-2222-000000000012', 'Mercado Corozal', 'Sucre', 'Corozal', 'Local'),
('22222222-2222-2222-2222-000000000013', 'Mercado Sta Marta', 'Magdalena', 'Santa Marta', 'Regional'),
('22222222-2222-2222-2222-000000000014', 'Mercado Ciénaga', 'Magdalena', 'Ciénaga', 'Local'),
('22222222-2222-2222-2222-000000000015', 'Mercado Cali', 'Valle del Cauca', 'Cali', 'Nacional'),
('22222222-2222-2222-2222-000000000016', 'Mercado Palmira', 'Valle del Cauca', 'Palmira', 'Local');


-- =========================================================
-- 2. TABLAS DE USUARIOS (DEPENDEN DE ROL)
-- =========================================================

-- TABLA: apicultor (Usa el id_rol 1111...)
INSERT INTO apicultor (id_apicultor, id_rol, nombre, apellido, identificacion, telefono) VALUES 
('33333333-3333-3333-3333-000000000001', '11111111-1111-1111-1111-000000000001', 'Carlos', 'Restrepo', 'CC-101', '300111'),
('33333333-3333-3333-3333-000000000002', '11111111-1111-1111-1111-000000000001', 'Maria', 'Lopez', 'CC-102', '310222'),
('33333333-3333-3333-3333-000000000003', '11111111-1111-1111-1111-000000000001', 'Jorge', 'Diaz', 'CC-103', '320333');

-- TABLA: consumidor (Usa el id_rol 1111...)
INSERT INTO consumidor (id_consumidor, id_rol, nombre, apellido, email_consumidor, telefono_consumidor, direccion) VALUES 
('66666666-6666-6666-6666-000000000001', '11111111-1111-1111-1111-000000000002', 'Andres', 'Gomez', 'andres@mail.com', '32100001112', 'Calle 10 # 20-30 Medellín'),
('66666666-6666-6666-6666-000000000002', '11111111-1111-1111-1111-000000000002', 'Laura', 'Perez', 'laura@mail.com'), '32200001113', 'Calle 20 # 15-25 Medellín'),
('66666666-6666-6666-6666-000000000003', '11111111-1111-1111-1111-000000000002', 'Pedro', 'Ruiz', 'pedro@mail.com');  '32300001114', 'Calle 30 # 10-20 Medellín');



-- TABLA: entidad_gubernamental (Usa el id_rol 1111...)
-- Creamos 3 entidades (ICA, INVIMA, MinAgricultura)
INSERT INTO entidad_gubernamental (id_entidad_gubernamental, id_rol, nombre, email, telefono_entidad) VALUES 
('88888888-8888-8888-8888-000000000001', '11111111-1111-1111-1111-000000000003', 'ICA', 'contacto@ica.gov.co', '6011112233'),
('88888888-8888-8888-8888-000000000002', '11111111-1111-1111-1111-000000000003', 'INVIMA', 'registro@invima.gov.co', '6014445566'),
('88888888-8888-8888-8888-000000000003', '11111111-1111-1111-1111-000000000003', 'MinAmbiente', 'info@minambiente.gov.co', '6017778899');


-- =========================================================
-- 3. GESTIÓN DE APIARIOS Y SENSORES (DEPENDEN DE APICULTOR)
-- =========================================================

-- TABLA: apiario (Usa el id_apicultor aaaa...)
INSERT INTO apiario (id_apiario, id_apicultor, nombre_apiario, departamento, municipio, direccion_apiario, ubicacion_geografica) VALUES 
('44444444-4444-4444-4444-000000000001', '33333333-3333-3333-3333-000000000001', 'Apiario Antioquia', 'Antioquia', 'Medellín (Santa Elena)', 'Vereda 1', '{"zona":"rural"}'),
('44444444-4444-4444-4444-000000000002', '33333333-3333-3333-3333-000000000001', 'Apiario Cundinamarca', 'Cundinamarca', 'Fusagasugá', 'Finca 2', '{"zona":"rural"}'),
('44444444-4444-4444-4444-000000000003', '33333333-3333-3333-3333-000000000002', 'Apiario Boyaca', 'Boyacá', 'Tunja', 'Sector 3', '{"zona":"rural"}'),
('44444444-4444-4444-4444-000000000004', '33333333-3333-3333-3333-000000000002', 'Apiario Santander', 'Santander', 'Bucaramanga', 'Lote 4', '{"zona":"periurbana"}'),
('44444444-4444-4444-4444-000000000005', '33333333-3333-3333-3333-000000000003', 'Apiario Huila', 'Huila', 'Neiva', 'Vía 5', '{"zona":"rural"}'),
('44444444-4444-4444-4444-000000000006', '33333333-3333-3333-3333-000000000003', 'Apiario Valle', 'Valle del Cauca', 'Cali', 'Km 6', '{"zona":"rural"}');


-- TABLA: colmena (Depende del apiario dddd...)
INSERT INTO colmena (id_colmena, id_apiario, nombre_colmena, estado_colmena) VALUES 
('99999999-9999-9999-9999-000000000001', '44444444-4444-4444-4444-000000000001', 'Colmena Alfa', true),
('99999999-9999-9999-9999-000000000002', '44444444-4444-4444-4444-000000000001', 'Colmena Beta', true),
('99999999-9999-9999-9999-000000000003', '44444444-4444-4444-4444-000000000001', 'Colmena Gamma', false),
('99999999-9999-9999-9999-000000000004', '44444444-4444-4444-4444-000000000002', 'Colmena Reina 1', true),
('99999999-9999-9999-9999-000000000005', '44444444-4444-4444-4444-000000000002', 'Colmena Reina 2', true);

-- TABLA: sensor_iot (Depende del apiario dddd...)
INSERT INTO sensor_iot (id_sensor_iot, id_apiario, tipo_sensor, modelo, estado_sensor) VALUES 
('aaaaaaaa-aaaa-aaaa-aaaa-000000000001', '44444444-4444-4444-4444-000000000001', 'Temperatura/Humedad', 'TH-100', true),
('aaaaaaaa-aaaa-aaaa-aaaa-000000000002', '44444444-4444-4444-4444-000000000001', 'Peso', 'W-200', true),
('aaaaaaaa-aaaa-aaaa-aaaa-000000000003', '44444444-4444-4444-4444-000000000002', 'Temperatura/Humedad', 'TH-100', true),
('aaaaaaaa-aaaa-aaaa-aaaa-000000000004', '44444444-4444-4444-4444-000000000003', 'Acústico', 'SND-50', false),
('aaaaaaaa-aaaa-aaaa-aaaa-000000000005', '44444444-4444-4444-4444-000000000004', 'Temperatura/Humedad', 'TH-101', true);


-- TABLA: registro_ambiental (Depende del sensor ffff...)
INSERT INTO registro_ambiental (id_registro, id_sensor_iot, fecha_registro, temperatura, humedad, tipo_alerta) VALUES 
('bbbbbbbb-bbbb-bbbb-bbbb-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-000000000001', CURRENT_TIMESTAMP - INTERVAL '2 days', 24.5, 60.0, false),
('bbbbbbbb-bbbb-bbbb-bbbb-000000000002', 'aaaaaaaa-aaaa-aaaa-aaaa-000000000001', CURRENT_TIMESTAMP - INTERVAL '1 day', 36.0, 55.0, true), -- Alerta alta temp
('bbbbbbbb-bbbb-bbbb-bbbb-000000000003', 'aaaaaaaa-aaaa-aaaa-aaaa-000000000003', CURRENT_TIMESTAMP, 22.0, 80.0, false),
('bbbbbbbb-bbbb-bbbb-bbbb-000000000004', 'aaaaaaaa-aaaa-aaaa-aaaa-000000000005', CURRENT_TIMESTAMP, 15.0, 90.0, true), -- Alerta baja temp/alta humedad
('bbbbbbbb-bbbb-bbbb-bbbb-000000000005', 'aaaaaaaa-aaaa-aaaa-aaaa-000000000001', CURRENT_TIMESTAMP, 25.0, 62.0, false);

-- TABLA: alerta (Depende del registro bbbb... -- Derivadas de los registros con tipo_alerta = true)
INSERT INTO alerta (id_alerta, id_registro, tipo_alerta, descripcion, fecha_alerta, estado_alerta) VALUES 
('cccccccc-cccc-cccc-cccc-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-000000000002', 'Temperatura Crítica', 'Temperatura superó los 35°C', CURRENT_TIMESTAMP - INTERVAL '1 day', true),
('cccccccc-cccc-cccc-cccc-000000000002', 'bbbbbbbb-bbbb-bbbb-bbbb-000000000004', 'Humedad Crítica', 'Riesgo de hongos por humedad > 85%', CURRENT_TIMESTAMP, false),
('cccccccc-cccc-cccc-cccc-000000000003', 'bbbbbbbb-bbbb-bbbb-bbbb-000000000004', 'Temperatura Baja', 'Temperatura inferior a 18°C', CURRENT_TIMESTAMP, true);



-- =========================================================
-- 4. CADENA DE PRODUCCIÓN: COSECHA -> LOTE -> PRODUCTO
-- =========================================================

-- TABLA: cosecha (Depende del apiario dddd...)
INSERT INTO cosecha (id_cosecha, id_apiario, fecha_cosecha, volumen_cosecha, condiciones_ambientales) VALUES 
('dddddddd-dddd-dddd-dddd-000000000001', '44444444-4444-4444-4444-000000000001', CURRENT_DATE - INTERVAL '30 days', 45.5, true),
('dddddddd-dddd-dddd-dddd-000000000002', '44444444-4444-4444-4444-000000000002', CURRENT_DATE - INTERVAL '15 days', 60.0, true),
('dddddddd-dddd-dddd-dddd-000000000003', '44444444-4444-4444-4444-000000000003', CURRENT_DATE - INTERVAL '5 days', 30.0, false),
('dddddddd-dddd-dddd-dddd-000000000004', '44444444-4444-4444-4444-000000000004', CURRENT_DATE, 50.0, true);

-- TABLA: lote (Depende de la cosecha dddd...)
INSERT INTO lote (id_lote, id_cosecha, codigo_qr, fecha_produccion, volumen_total, estado_lote) 
VALUES ('00000000-0000-0000-0000-000000000001', 'dddddddd-dddd-dddd-dddd-000000000001', 'QR-001', CURRENT_DATE, 100, true);



-- TABLA: producto (Depende del lote 0000...)
INSERT INTO producto (id_producto, id_lote, nombre_producto, precio, unidad_medida) VALUES 
('55555555-5555-5555-5555-000000000001', '00000000-0000-0000-0000-000000000001', 'Miel', 25000, '1 kg'),
('55555555-5555-5555-5555-000000000002', '00000000-0000-0000-0000-000000000001', 'Polen', 20000, '250 g'),
('55555555-5555-5555-5555-000000000003', '00000000-0000-0000-0000-000000000001', 'Propóleo', 35000, '30 ml');


-- =========================================================
-- 5. COMERCIALIZACIÓN: PEDIDOS Y PAGOS
-- =========================================================

-- TABLA: pedido (Depende del consumidor 6666...)
INSERT INTO pedido (id_pedido, id_consumidor, fecha_pedido, estado_pedido, direccion_entrega) VALUES 
('77777777-7777-7777-7777-000000000001', '66666666-6666-6666-6666-000000000001', CURRENT_DATE, true, 'Santa Fe de Antioquia'),
('77777777-7777-7777-7777-000000000002', '66666666-6666-6666-6666-000000000002', CURRENT_DATE, true, 'Medellín (Santa Elena)'),
('77777777-7777-7777-7777-000000000003', '66666666-6666-6666-6666-000000000003', CURRENT_DATE, true, 'Fusagasugá'),
('77777777-7777-7777-7777-000000000004', '66666666-6666-6666-6666-000000000001', CURRENT_DATE, true, 'Girardot'),
('77777777-7777-7777-7777-000000000005', '66666666-6666-6666-6666-000000000002', CURRENT_DATE, true, 'Tunja'),
('77777777-7777-7777-7777-000000000006', '66666666-6666-6666-6666-000000000003', CURRENT_DATE, true, 'Sogamoso'),
('77777777-7777-7777-7777-000000000007', '66666666-6666-6666-6666-000000000001', CURRENT_DATE, true, 'Bucaramanga'),
('77777777-7777-7777-7777-000000000008', '66666666-6666-6666-6666-000000000002', CURRENT_DATE, true, 'Neiva'),
('77777777-7777-7777-7777-000000000009', '66666666-6666-6666-6666-000000000003', CURRENT_DATE, true, 'Villavicencio'),
('77777777-7777-7777-7777-000000000010', '66666666-6666-6666-6666-000000000001', CURRENT_DATE, true, 'Monteria'),
('77777777-7777-7777-7777-000000000011', '66666666-6666-6666-6666-000000000002', CURRENT_DATE, true, 'Sincelejo'),
('77777777-7777-7777-7777-000000000012', '66666666-6666-6666-6666-000000000003', CURRENT_DATE, true, 'Corozal'),
('77777777-7777-7777-7777-000000000013', '66666666-6666-6666-6666-000000000001', CURRENT_DATE, true, 'Santa Marta'),
('77777777-7777-7777-7777-000000000014', '66666666-6666-6666-6666-000000000002', CURRENT_DATE, true, 'Ciénaga'),
('77777777-7777-7777-7777-000000000015', '66666666-6666-6666-6666-000000000003', CURRENT_DATE, true, 'Cali'),
('77777777-7777-7777-7777-000000000016', '66666666-6666-6666-6666-000000000001', CURRENT_DATE, true, 'Palmira');


-- TABLA: pago (Depende del pedido 7777...)
INSERT INTO pago (id_pago, id_pedido, fecha_pago, metodo_pago, monto, estado_pago, referencia) VALUES 
('ffffffff-ffff-ffff-ffff-000000000001', '77777777-7777-7777-7777-000000000001', CURRENT_TIMESTAMP, 'PSE', 50000, true, 'REF-1001'),
('ffffffff-ffff-ffff-ffff-000000000002', '77777777-7777-7777-7777-000000000002', CURRENT_TIMESTAMP, 'Tarjeta Crédito', 125000, true, 'REF-1002'),
('ffffffff-ffff-ffff-ffff-000000000003', '77777777-7777-7777-7777-000000000003', CURRENT_TIMESTAMP, 'Efectivo', 25000, false, 'REF-1003'),
('ffffffff-ffff-ffff-ffff-000000000004', '77777777-7777-7777-7777-000000000004', CURRENT_TIMESTAMP, 'PSE', 75000, true, 'REF-1004'),
('ffffffff-ffff-ffff-ffff-000000000005', '77777777-7777-7777-7777-000000000005', CURRENT_TIMESTAMP, 'Transferencia', 50000, true, 'REF-1005');

-- =========================================================
-- 6. CERTIFICACIONES (CRUZA ENTIDAD, LOTE Y APICULTOR)
-- =========================================================

-- TABLA: certificacion (Usa apicultor 3333, lote 0000, entidad 8888 )
INSERT INTO certificacion (id_certificacion, numero_certificacion, fecha_certificacion, inspeccion, estado, id_apicultor, id_lote, id_entidad) VALUES 
('eeeeeeee-eeee-eeee-eeee-000000000001', 'CERT-ICA-101', CURRENT_DATE - INTERVAL '60 days', 'Aprobada', 'Activa', '33333333-3333-3333-3333-000000000001', '00000000-0000-0000-0000-000000000001', '88888888-8888-8888-8888-000000000001'),
('eeeeeeee-eeee-eeee-eeee-000000000002', 'CERT-INV-202', CURRENT_DATE - INTERVAL '10 days', 'Pendiente', 'En Trámite', '33333333-3333-3333-3333-000000000002', '00000000-0000-0000-0000-000000000001', '88888888-8888-8888-8888-000000000002'),
('eeeeeeee-eeee-eeee-eeee-000000000003', 'CERT-MIN-303', CURRENT_DATE - INTERVAL '400 days', 'Rechazada', 'Vencida', '33333333-3333-3333-3333-000000000003', '00000000-0000-0000-0000-000000000001', '88888888-8888-8888-8888-000000000003');



-- =========================================================
-- 7. TABLAS INTERMEDIAS (MUCHOS A MUCHOS)
-- =========================================================

-- TABLA: apicultor_producto -- Carlos hace Miel, Maria Polen, Jorge Propóleo
INSERT INTO apicultor_producto (id_apicultor, id_producto) VALUES 
('33333333-3333-3333-3333-000000000001', '55555555-5555-5555-5555-000000000001'),
('33333333-3333-3333-3333-000000000002', '55555555-5555-5555-5555-000000000002'),
('33333333-3333-3333-3333-000000000003', '55555555-5555-5555-5555-000000000003');

-- TABLA: pedido_producto (Pedido 7777...)
-- Miel (25000)
INSERT INTO pedido_producto (id_pedido, id_producto, cantidad, precio_unitario) VALUES 
('77777777-7777-7777-7777-000000000001', '55555555-5555-5555-5555-000000000001', 2, 25000),
('77777777-7777-7777-7777-000000000002', '55555555-5555-5555-5555-000000000001', 5, 25000),
('77777777-7777-7777-7777-000000000003', '55555555-5555-5555-5555-000000000001', 1, 25000),
('77777777-7777-7777-7777-000000000004', '55555555-5555-5555-5555-000000000001', 3, 25000),
('77777777-7777-7777-7777-000000000005', '55555555-5555-5555-5555-000000000001', 2, 25000);

-- Polen (20000)
INSERT INTO pedido_producto (id_pedido, id_producto, cantidad, precio_unitario) VALUES 
('77777777-7777-7777-7777-000000000006', '55555555-5555-5555-5555-000000000002', 4, 20000),
('77777777-7777-7777-7777-000000000007', '55555555-5555-5555-5555-000000000002', 2, 20000),
('77777777-7777-7777-7777-000000000008', '55555555-5555-5555-5555-000000000002', 1, 20000),
('77777777-7777-7777-7777-000000000009', '55555555-5555-5555-5555-000000000002', 10, 20000),
('77777777-7777-7777-7777-000000000010', '55555555-5555-5555-5555-000000000002', 3, 20000);

-- Propóleo (35000)
INSERT INTO pedido_producto (id_pedido, id_producto, cantidad, precio_unitario) VALUES 
('77777777-7777-7777-7777-000000000011', '55555555-5555-5555-5555-000000000003', 2, 35000),
('77777777-7777-7777-7777-000000000012', '55555555-5555-5555-5555-000000000003', 1, 35000),
('77777777-7777-7777-7777-000000000013', '55555555-5555-5555-5555-000000000003', 4, 35000),
('77777777-7777-7777-7777-000000000014', '55555555-5555-5555-5555-000000000003', 2, 35000),
('77777777-7777-7777-7777-000000000015', '55555555-5555-5555-5555-000000000003', 5, 35000),
('77777777-7777-7777-7777-000000000016', '55555555-5555-5555-5555-000000000003', 1, 35000);

-- TABLA: lote_certificacion (Lote 4d4d... tiene certificado 8b8b...)
INSERT INTO lote_certificacion (id_lote, id_certificacion, fecha_asignacion) VALUES 
('00000000-0000-0000-0000-000000000001', 'eeeeeeee-eeee-eeee-eeee-000000000001', CURRENT_DATE - INTERVAL '55 days'),
('00000000-0000-0000-0000-000000000001', 'eeeeeeee-eeee-eeee-eeee-000000000002', CURRENT_DATE - INTERVAL '5 days');


-- TABLA: colmena_cosecha (Colmena eeee... aportó a cosecha 3c3c...)
INSERT INTO colmena_cosecha (id_colmena, id_cosecha, volumen_colmena) VALUES 
('99999999-9999-9999-9999-000000000001', 'dddddddd-dddd-dddd-dddd-000000000001', 20.0),
('99999999-9999-9999-9999-000000000002', 'dddddddd-dddd-dddd-dddd-000000000001', 25.5),
('99999999-9999-9999-9999-000000000004', 'dddddddd-dddd-dddd-dddd-000000000002', 30.0),
('99999999-9999-9999-9999-000000000005', 'dddddddd-dddd-dddd-dddd-000000000002', 30.0);


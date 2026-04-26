--
-- Scripst de Creación de la Base de Datos  - SGBD PostgreSQL
--
-- Todas las instrucciones se DEBEN EJECUTAR EN SECUENCIA SIN ERRORES
-- NOTA: Ojo con las tablas relacionadas. Primero las independientes y después las dependientes
--

--
-- Creación de las tablas
-- 

-- Rol
CREATE TABLE rol (
    id_rol UUID PRIMARY KEY,
    nombre_rol VARCHAR(30) UNIQUE NOT NULL,
    descripcion TEXT
);

-- Apicultor
CREATE TABLE apicultor (
    id_apicultor UUID PRIMARY KEY,
    id_rol UUID NOT NULL,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    identificacion VARCHAR(20) UNIQUE NOT NULL, -- cambio de UUID a VARCHAR
    telefono VARCHAR(20),
    email TEXT,
    CONSTRAINT fk_apicultor_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- Apiario
CREATE TABLE apiario (
    id_apiario UUID PRIMARY KEY,
    id_apicultor UUID NOT NULL,
    nombre_apiario TEXT NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    direccion_apiario TEXT NOT NULL,
    CONSTRAINT fk_apiario_apicultor FOREIGN KEY (id_apicultor) REFERENCES apicultor(id_apicultor)
);

-- Consumidor
CREATE TABLE consumidor (
    id_consumidor UUID PRIMARY KEY,
    id_rol UUID NOT NULL,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    email_consumidor TEXT UNIQUE NOT NULL,
    telefono_consumidor VARCHAR(20),
    direccion TEXT,
    CONSTRAINT fk_consumidor_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- Entidad gubernamental
CREATE TABLE entidad_gubernamental (
    id_entidad_gubernamental UUID PRIMARY KEY,
    id_rol UUID NOT NULL,
    nombre TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    telefono_entidad VARCHAR(20) NOT NULL,
    CONSTRAINT fk_entidad_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- Colmena
CREATE TABLE colmena (
    id_colmena UUID PRIMARY KEY,
    id_apiario UUID NOT NULL,
    nombre_colmena TEXT,
    estado_colmena BOOLEAN NOT NULL,
    CONSTRAINT fk_colmena_apiario FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);

-- Sensor IoT
CREATE TABLE sensor_iot (
    id_sensor_iot UUID PRIMARY KEY,
    id_apiario UUID NOT NULL,
    tipo_sensor TEXT NOT NULL,
    modelo TEXT,
    estado_sensor BOOLEAN NOT NULL,
    CONSTRAINT fk_sensor_apiario FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);

-- Registro ambiental
CREATE TABLE registro_ambiental (
    id_registro UUID PRIMARY KEY,
    id_sensor_iot UUID NOT NULL,
    fecha_registro TIMESTAMP NOT NULL,
    temperatura NUMERIC(5,2) NOT NULL,
    humedad NUMERIC(5,2) NOT NULL,
    tipo_alerta BOOLEAN NOT NULL,
    CONSTRAINT fk_registro_sensor FOREIGN KEY (id_sensor_iot) REFERENCES sensor_iot(id_sensor_iot)
);

-- Alerta
CREATE TABLE alerta (
    id_alerta UUID PRIMARY KEY,
    id_registro UUID NOT NULL,
    tipo_alerta VARCHAR(30) NOT NULL,
    descripcion TEXT,
    fecha_alerta TIMESTAMP NOT NULL,
    estado_alerta BOOLEAN NOT NULL,
    CONSTRAINT fk_alerta_registro FOREIGN KEY (id_registro) REFERENCES registro_ambiental(id_registro)
);

-- Cosecha
CREATE TABLE cosecha (
    id_cosecha UUID PRIMARY KEY,
    id_apiario UUID NOT NULL,
    fecha_cosecha DATE NOT NULL,
    volumen_cosecha NUMERIC(6,2) NOT NULL,
    condiciones_ambientales BOOLEAN,
    CONSTRAINT fk_cosecha_apiario FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);

-- Lote
CREATE TABLE lote (
    id_lote UUID PRIMARY KEY,
    id_cosecha UUID NOT NULL,
    codigo_qr TEXT UNIQUE NOT NULL,
    fecha_produccion DATE NOT NULL,
    volumen_total NUMERIC(6,2) NOT NULL,
    estado_lote BOOLEAN NOT NULL,
    CONSTRAINT fk_lote_cosecha FOREIGN KEY (id_cosecha) REFERENCES cosecha(id_cosecha)
);

-- Producto
CREATE TABLE producto (
    id_producto UUID PRIMARY KEY,
    id_lote UUID NOT NULL,
    nombre_producto TEXT NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL, -- cambio de INTEGER a VARCHAR
    CONSTRAINT fk_producto_lote FOREIGN KEY (id_lote) REFERENCES lote(id_lote)
);

-- Pedido
CREATE TABLE pedido (
    id_pedido UUID PRIMARY KEY,
    id_consumidor UUID NOT NULL,
    fecha_pedido DATE NOT NULL,
    estado_pedido BOOLEAN NOT NULL,
    direccion_entrega TEXT NOT NULL,
    CONSTRAINT fk_pedido_consumidor FOREIGN KEY (id_consumidor) REFERENCES consumidor(id_consumidor)
);

-- Pago
CREATE TABLE pago (
    id_pago UUID PRIMARY KEY,
    id_pedido UUID NOT NULL,
    fecha_pago TIMESTAMP NOT NULL,
    metodo_pago TEXT NOT NULL,
    monto NUMERIC(10,2) NOT NULL,
    estado_pago BOOLEAN NOT NULL,
    referencia VARCHAR(50) UNIQUE NOT NULL,
    CONSTRAINT fk_pago_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- Certificacion
CREATE TABLE certificacion (
    id_certificacion UUID PRIMARY KEY,
    numero_certificacion VARCHAR(50) UNIQUE NOT NULL,
    fecha_certificacion DATE NOT NULL,
    inspeccion VARCHAR(20) NOT NULL, -- 'aprobado' / 'pendiente'
    estado VARCHAR(20) NOT NULL,     -- 'vigente' / 'vencida'
    id_apicultor UUID NOT NULL,
    id_lote UUID NOT NULL,
    id_entidad UUID NOT NULL,
    CONSTRAINT fk_cert_apicultor FOREIGN KEY (id_apicultor) REFERENCES apicultor(id_apicultor),
    CONSTRAINT fk_cert_lote FOREIGN KEY (id_lote) REFERENCES lote(id_lote),
    CONSTRAINT fk_cert_entidad FOREIGN KEY (id_entidad) REFERENCES entidad_gubernamental(id_entidad_gubernamental)
);

-- Pedido_Producto (relación N:M)
CREATE TABLE pedido_producto (
    id_pedido UUID NOT NULL,
    id_producto UUID NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT fk_pp_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_pp_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Lote_Certificacion (relación N:M)
CREATE TABLE lote_certificacion (
    id_lote UUID NOT NULL,
    id_certificacion UUID NOT NULL,
    fecha_asignacion TIMESTAMP NOT NULL,
    PRIMARY KEY (id_lote, id_certificacion),
    CONSTRAINT fk_lc_lote FOREIGN KEY (id_lote) REFERENCES lote(id_lote),
    CONSTRAINT fk_lc_cert FOREIGN KEY (id_certificacion) REFERENCES certificacion(id_certificacion)
);

-- Colmena_Cosecha (relación N:M)
CREATE TABLE colmena_cosecha (
    id_colmena UUID NOT NULL,
    id_cosecha UUID NOT NULL,
    volumen_colmena NUMERIC(6,2),
    PRIMARY KEY (id_colmena, id_cosecha),
    CONSTRAINT fk_cc_colmena FOREIGN KEY (id_colmena) REFERENCES colmena(id_colmena),
    CONSTRAINT fk_cc_cosecha FOREIGN KEY (id_cosecha) REFERENCES cosecha(id_cosecha)
);

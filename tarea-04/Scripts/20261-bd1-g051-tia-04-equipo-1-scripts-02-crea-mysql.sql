--
-- Scripst de Creación de la Base de Datos - SGBD MySQL
--
-- Todas las instrucciones se DEBEN EJECUTAR EN SECUENCIA SIN ERRORES
-- NOTA: Ojo con las tablas relacionadas. Primero las independientes y después las dependientes
--

--
-- Creación de las tablas
-- 

-- 1. Rol
CREATE TABLE rol (
    id_rol CHAR(36) PRIMARY KEY,
    nombre_rol VARCHAR(30) UNIQUE NOT NULL,
    descripcion TEXT
);

-- 2. Apicultor
CREATE TABLE apicultor (
    id_apicultor CHAR(36) PRIMARY KEY,
    id_rol CHAR(36) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    identificacion VARCHAR(20) UNIQUE NOT NULL, 
    telefono VARCHAR(20),
    email VARCHAR(100),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- 3. Apiario
CREATE TABLE apiario (
    id_apiario CHAR(36) PRIMARY KEY,
    id_apicultor CHAR(36) NOT NULL,
    nombre_apiario VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    direccion_apiario VARCHAR(120) NOT NULL,
    FOREIGN KEY (id_apicultor) REFERENCES apicultor(id_apicultor)
);

-- 4. Consumidor
CREATE TABLE consumidor (
    id_consumidor CHAR(36) PRIMARY KEY,
    id_rol CHAR(36) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email_consumidor VARCHAR(100) UNIQUE NOT NULL,
    telefono_consumidor VARCHAR(20),
    direccion VARCHAR(120),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- 5. Entidad gubernamental
CREATE TABLE entidad_gubernamental (
    id_entidad_gubernamental CHAR(36) PRIMARY KEY,
    id_rol CHAR(36) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono_entidad VARCHAR(20),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- 6. Colmena
CREATE TABLE colmena (
    id_colmena CHAR(36) PRIMARY KEY,
    id_apiario CHAR(36) NOT NULL,
    nombre_colmena VARCHAR(20),
    estado_colmena TINYINT(1) NOT NULL,
    FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);

-- 7. Sensor IoT
CREATE TABLE sensor_iot (
    id_sensor_iot CHAR(36) PRIMARY KEY,
    id_apiario CHAR(36) NOT NULL,
    tipo_sensor VARCHAR(30) NOT NULL,
    modelo VARCHAR(30),
    estado_sensor TINYINT(1) NOT NULL,
    FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);

-- 8. Registro ambiental
CREATE TABLE registro_ambiental (
    id_registro CHAR(36) PRIMARY KEY,
    id_sensor_iot CHAR(36) NOT NULL,
    fecha_registro DATETIME NOT NULL,
    temperatura DECIMAL(5,2) NOT NULL,
    humedad DECIMAL(5,2) NOT NULL,
    tipo_alerta TINYINT(1) NOT NULL,
    FOREIGN KEY (id_sensor_iot) REFERENCES sensor_iot(id_sensor_iot)
);

-- 9. Alerta
CREATE TABLE alerta (
    id_alerta CHAR(36) PRIMARY KEY,
    id_registro CHAR(36) NOT NULL,
    tipo_alerta VARCHAR(30) NOT NULL,
    descripcion TEXT,
    fecha_alerta DATETIME NOT NULL,
    estado_alerta TINYINT(1) NOT NULL,
    FOREIGN KEY (id_registro) REFERENCES registro_ambiental(id_registro)
);

-- 10. Cosecha
CREATE TABLE cosecha (
    id_cosecha CHAR(36) PRIMARY KEY,
    id_apiario CHAR(36) NOT NULL,
    fecha_cosecha DATE NOT NULL,
    volumen_cosecha DECIMAL(6,2) NOT NULL,
    condiciones_ambientales TINYINT(1),
    FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);

-- 11. Lote
CREATE TABLE lote (
    id_lote CHAR(36) PRIMARY KEY,
    id_cosecha CHAR(36) NOT NULL,
    codigo_qr VARCHAR(50) UNIQUE NOT NULL,
    fecha_produccion DATE NOT NULL,
    volumen_total DECIMAL(6,2) NOT NULL,
    estado_lote TINYINT(1) NOT NULL,
    FOREIGN KEY (id_cosecha) REFERENCES cosecha(id_cosecha)
);

-- 12. Producto
CREATE TABLE producto (
    id_producto CHAR(36) PRIMARY KEY,
    id_lote CHAR(36) NOT NULL,
    nombre_producto VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL, 
    FOREIGN KEY (id_lote) REFERENCES lote(id_lote)
);

-- 13. Pedido
CREATE TABLE pedido (
    id_pedido CHAR(36) PRIMARY KEY,
    id_consumidor CHAR(36) NOT NULL,
    fecha_pedido DATE NOT NULL,
    estado_pedido TINYINT(1) NOT NULL,
    direccion_entrega VARCHAR(120) NOT NULL,
    FOREIGN KEY (id_consumidor) REFERENCES consumidor(id_consumidor)
);

-- 14. Pago
CREATE TABLE pago (
    id_pago CHAR(36) PRIMARY KEY,
    id_pedido CHAR(36) NOT NULL,
    fecha_pago DATETIME NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    estado_pago TINYINT(1) NOT NULL,
    referencia VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- 15. Certificacion
CREATE TABLE certificacion (
    id_certificacion CHAR(36) PRIMARY KEY,
    numero_certificacion VARCHAR(50) UNIQUE NOT NULL,
    fecha_certificacion DATE NOT NULL,
    inspeccion VARCHAR(20) NOT NULL, -- 'aprobado' / 'pendiente'
    estado VARCHAR(20) NOT NULL,     -- 'vigente' / 'vencida'
    id_apicultor CHAR(36) NOT NULL,
    id_lote CHAR(36) NOT NULL,
    id_entidad CHAR(36) NOT NULL,
    FOREIGN KEY (id_apicultor) REFERENCES apicultor(id_apicultor),
    FOREIGN KEY (id_lote) REFERENCES lote(id_lote),
    FOREIGN KEY (id_entidad) REFERENCES entidad_gubernamental(id_entidad_gubernamental)
);

-- 16. Pedido_Producto (N:M)
CREATE TABLE pedido_producto (
    id_pedido CHAR(36) NOT NULL,
    id_producto CHAR(36) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- 17. Lote_Certificacion (N:M)
CREATE TABLE lote_certificacion (
    id_lote CHAR(36) NOT NULL,
    id_certificacion CHAR(36) NOT NULL,
    fecha_asignacion DATETIME NOT NULL,
    PRIMARY KEY (id_lote, id_certificacion),
    FOREIGN KEY (id_lote) REFERENCES lote(id_lote),
    FOREIGN KEY (id_certificacion) REFERENCES certificacion(id_certificacion)
);

-- 18. Colmena_Cosecha (N:M)
CREATE TABLE colmena_cosecha (
    id_colmena CHAR(36) NOT NULL,
    id_cosecha CHAR(36) NOT NULL,
    volumen_colmena DECIMAL(6,2),
    PRIMARY KEY (id_colmena, id_cosecha),
    FOREIGN KEY (id_colmena) REFERENCES colmena(id_colmena),
    FOREIGN KEY (id_cosecha) REFERENCES cosecha(id_cosecha)
);

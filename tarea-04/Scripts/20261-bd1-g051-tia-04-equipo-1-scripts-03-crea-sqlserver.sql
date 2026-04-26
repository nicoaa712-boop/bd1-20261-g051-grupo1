--
-- Scripst de Creación de la Base de Datos - SGBD MS SQL Server
--
-- Todas las instrucciones se DEBEN EJECUTAR EN SECUENCIA SIN ERRORES
-- NOTA: Ojo con las tablas relacionadas. Primero las independientes y después las dependientes
--

--
-- Creación de las tablas
-- 
-- 1. Rol
CREATE TABLE Rol (
    id_rol UNIQUEIDENTIFIER PRIMARY KEY,
    nombre_rol VARCHAR(30) UNIQUE NOT NULL,
    descripcion VARCHAR(150) NULL
);

-- 2. Apicultor
CREATE TABLE Apicultor (
    id_apicultor UNIQUEIDENTIFIER PRIMARY KEY,
    id_rol UNIQUEIDENTIFIER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    identificacion VARCHAR(20) UNIQUE NOT NULL, -- cambio de UNIQUEIDENTIFIER a VARCHAR
    telefono VARCHAR(20) NULL,
    email VARCHAR(100) NULL,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- 3. Apiario
CREATE TABLE Apiario (
    id_apiario UNIQUEIDENTIFIER PRIMARY KEY,
    id_apicultor UNIQUEIDENTIFIER NOT NULL,
    nombre_apiario VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    direccion_apiario VARCHAR(120) NOT NULL,
    FOREIGN KEY (id_apicultor) REFERENCES Apicultor(id_apicultor)
);

-- 4. Consumidor
CREATE TABLE Consumidor (
    id_consumidor UNIQUEIDENTIFIER PRIMARY KEY,
    id_rol UNIQUEIDENTIFIER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email_consumidor VARCHAR(100) UNIQUE NOT NULL,
    telefono_consumidor VARCHAR(20) NULL,
    direccion VARCHAR(120) NULL,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- 5. Entidad gubernamental
CREATE TABLE Entidad_Gubernamental (
    id_entidad_gubernamental UNIQUEIDENTIFIER PRIMARY KEY,
    id_rol UNIQUEIDENTIFIER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono_entidad VARCHAR(20) NULL,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- 6. Colmena
CREATE TABLE Colmena (
    id_colmena UNIQUEIDENTIFIER PRIMARY KEY,
    id_apiario UNIQUEIDENTIFIER NOT NULL,
    nombre_colmena VARCHAR(20) NULL,
    estado_colmena BIT NOT NULL,
    FOREIGN KEY (id_apiario) REFERENCES Apiario(id_apiario)
);

-- 7. Sensor IoT
CREATE TABLE Sensor_IoT (
    id_sensor_iot UNIQUEIDENTIFIER PRIMARY KEY,
    id_apiario UNIQUEIDENTIFIER NOT NULL,
    tipo_sensor VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NULL,
    estado_sensor BIT NOT NULL,
    FOREIGN KEY (id_apiario) REFERENCES Apiario(id_apiario)
);

-- 8. Registro ambiental
CREATE TABLE Registro_Ambiental (
    id_registro UNIQUEIDENTIFIER PRIMARY KEY,
    id_sensor_iot UNIQUEIDENTIFIER NOT NULL,
    fecha_registro DATETIME NOT NULL,
    temperatura DECIMAL(5,2) NOT NULL,
    humedad DECIMAL(5,2) NOT NULL,
    tipo_alerta BIT NOT NULL,
    FOREIGN KEY (id_sensor_iot) REFERENCES Sensor_IoT(id_sensor_iot)
);

-- 9. Alerta
CREATE TABLE Alerta (
    id_alerta UNIQUEIDENTIFIER PRIMARY KEY,
    id_registro UNIQUEIDENTIFIER NOT NULL,
    tipo_alerta VARCHAR(30) NOT NULL,
    descripcion VARCHAR(150) NULL,
    fecha_alerta DATETIME NOT NULL,
    estado_alerta BIT NOT NULL,
    FOREIGN KEY (id_registro) REFERENCES Registro_Ambiental(id_registro)
);

-- 10. Cosecha
CREATE TABLE Cosecha (
    id_cosecha UNIQUEIDENTIFIER PRIMARY KEY,
    id_apiario UNIQUEIDENTIFIER NOT NULL,
    fecha_cosecha DATE NOT NULL,
    volumen_cosecha DECIMAL(6,2) NOT NULL,
    condiciones_ambientales BIT NULL,
    FOREIGN KEY (id_apiario) REFERENCES Apiario(id_apiario)
);

-- 11. Lote
CREATE TABLE Lote (
    id_lote UNIQUEIDENTIFIER PRIMARY KEY,
    id_cosecha UNIQUEIDENTIFIER NOT NULL,
    codigo_qr VARCHAR(50) UNIQUE NOT NULL,
    fecha_produccion DATE NOT NULL,
    volumen_total DECIMAL(6,2) NOT NULL,
    estado_lote BIT NOT NULL,
    FOREIGN KEY (id_cosecha) REFERENCES Cosecha(id_cosecha)
);

-- 12. Producto
CREATE TABLE Producto (
    id_producto UNIQUEIDENTIFIER PRIMARY KEY,
    id_lote UNIQUEIDENTIFIER NOT NULL,
    nombre_producto VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL, -- cambio de INT a VARCHAR
    FOREIGN KEY (id_lote) REFERENCES Lote(id_lote)
);

-- 13. Pedido
CREATE TABLE Pedido (
    id_pedido UNIQUEIDENTIFIER PRIMARY KEY,
    id_consumidor UNIQUEIDENTIFIER NOT NULL,
    fecha_pedido DATE NOT NULL,
    estado_pedido BIT NOT NULL,
    direccion_entrega VARCHAR(120) NOT NULL,
    FOREIGN KEY (id_consumidor) REFERENCES Consumidor(id_consumidor)
);

-- 14. Pago
CREATE TABLE Pago (
    id_pago UNIQUEIDENTIFIER PRIMARY KEY,
    id_pedido UNIQUEIDENTIFIER NOT NULL,
    fecha_pago DATETIME NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    estado_pago BIT NOT NULL,
    referencia VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- 15. Certificacion
CREATE TABLE Certificacion (
    id_certificacion UNIQUEIDENTIFIER PRIMARY KEY,
    numero_certificacion VARCHAR(50) UNIQUE NOT NULL,
    fecha_certificacion DATE NOT NULL,
    inspeccion VARCHAR(20) NOT NULL, -- 'aprobado' / 'pendiente'
    estado VARCHAR(20) NOT NULL,     -- 'vigente' / 'vencida'
    id_apicultor UNIQUEIDENTIFIER NOT NULL,
    id_lote UNIQUEIDENTIFIER NOT NULL,
    id_entidad UNIQUEIDENTIFIER NOT NULL,
    FOREIGN KEY (id_apicultor) REFERENCES Apicultor(id_apicultor),
    FOREIGN KEY (id_lote) REFERENCES Lote(id_lote),
    FOREIGN KEY (id_entidad) REFERENCES Entidad_Gubernamental(id_entidad_gubernamental)
);

-- 16. Pedido_Producto (N:M)
CREATE TABLE Pedido_Producto (
    id_pedido UNIQUEIDENTIFIER NOT NULL,
    id_producto UNIQUEIDENTIFIER NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- 17. Lote_Certificacion (N:M)
CREATE TABLE Lote_Certificacion (
    id_lote UNIQUEIDENTIFIER NOT NULL,
    id_certificacion UNIQUEIDENTIFIER NOT NULL,
    fecha_asignacion DATETIME NOT NULL,
    PRIMARY KEY (id_lote, id_certificacion),
    FOREIGN KEY (id_lote) REFERENCES Lote(id_lote),
    FOREIGN KEY (id_certificacion) REFERENCES Certificacion(id_certificacion)
);

-- 18. Colmena_Cosecha (N:M)
CREATE TABLE Colmena_Cosecha (
    id_colmena UNIQUEIDENTIFIER NOT NULL,
    id_cosecha UNIQUEIDENTIFIER NOT NULL,
    volumen_colmena DECIMAL(6,2) NULL,
    PRIMARY KEY (id_colmena, id_cosecha),
    FOREIGN KEY (id_colmena) REFERENCES Colmena(id_colmena),
    FOREIGN KEY (id_cosecha) REFERENCES Cosecha(id_cosecha)
);

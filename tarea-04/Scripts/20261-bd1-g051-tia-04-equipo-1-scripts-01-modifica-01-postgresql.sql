--
-- Scripts de Modificación de la Base de Datos - SGBD PostgreSQL
-- Todas las instrucciones se deben realizar en secuencia sin errores
-- Probar los scripts en detalle
--

--
-- Modificación de la Base de Datos
-- 

--
-- 1.1.- Agregar un campo a la tabla de "productor" de la red apicola
--

--
-- 1.2.- Modificar un campo de la tabla de "productor"
--

--
-- Gestionar una tabla "nueva"
-- 1.- "agregar" una nueva tabla a la base de datos que tenga relación con el sistema
-- 2.- Darle un nombre "coherente"
-- 3.- Agregar campos coherentes con la tabla
-- 4.- Realizar todas las operaciones que se solicitan a continuación
--

-- 1.3.1
-- Crear una tabla "nueva" de su iniciativa (una tabla coherente con el sistema con su nombre, no coloque "nueva" como nombre)
--

-- 1.3.2
-- Agregar una clave primaria y otros 3 campos cualquiera a la tabla "nueva"
-- Mínimo un campo tipo texto y uno numérico
--

-- 1.3.3
-- Quitar uno de los campos de la tabla "nueva"
--

-- 1.3.4
-- Cambiar el nombre de la tabla "nueva" a otro nombre "otro_nombre"
-- Todas las operaciones siguientes se realizan sobre la tabla renombrada
--

-- 1.3.5 
-- Agregar un campo único a la tabla 
--

-- 1.3.6
-- Agregar 2 fechas de inicio y fin; y colocar un control de orden de fechas
--

-- 1.3.7
-- Agregar 1 campo entero y colocar un control para que no sea negativo
--

-- 1.3.8
-- Modificar el tamaño de un campo texto de la tabla renombra
--

-- 1.3.7
-- Modificar el campo numeríco y colocar un control de rango 
--

-- 1.3.8
-- Agregar un índice a la tabla (cualquier campo)
--

--
-- 1.3.9 
-- Eliminar una de las fechas
--

-- 1.3.10
-- Borrar todos los datos de una tabla sin dejar traza
--

-- 1.1 Agregar un campo a la tabla "apicultor" (productor de la red apícola)
ALTER TABLE apicultor ADD COLUMN experiencia_anios INTEGER;

-- 1.2 Modificar un campo de la tabla "apicultor"
-- Ejemplo: cambiar tamaño del campo nombre
ALTER TABLE apicultor ALTER COLUMN nombre TYPE VARCHAR(100);

-- 1.3.1 Crear una tabla nueva coherente con el sistema
CREATE TABLE certificacion (
    id_certificacion UUID PRIMARY KEY,
    nombre TEXT NOT NULL,
    organismo TEXT NOT NULL,
    nivel INTEGER NOT NULL
);

-- 1.3.2 Agregar 3 campos adicionales a la tabla nueva
ALTER TABLE certificacion ADD COLUMN descripcion TEXT;
ALTER TABLE certificacion ADD COLUMN costo NUMERIC(10,2);
ALTER TABLE certificacion ADD COLUMN vigente BOOLEAN;

-- 1.3.3 Quitar uno de los campos de la tabla nueva
ALTER TABLE certificacion DROP COLUMN vigente;

-- 1.3.4 Cambiar el nombre de la tabla nueva
ALTER TABLE certificacion RENAME TO certificacion_apicola;

-- 1.3.5 Agregar un campo único
ALTER TABLE certificacion_apicola ADD COLUMN codigo VARCHAR(20) UNIQUE;

-- 1.3.6 Agregar 2 fechas y control de orden
ALTER TABLE certificacion_apicola ADD COLUMN fecha_inicio DATE;
ALTER TABLE certificacion_apicola ADD COLUMN fecha_fin DATE;
ALTER TABLE certificacion_apicola ADD CONSTRAINT chk_fechas CHECK (fecha_inicio < fecha_fin);

-- 1.3.7 Agregar un campo entero con control no negativo
ALTER TABLE certificacion_apicola ADD COLUMN puntaje INTEGER;
ALTER TABLE certificacion_apicola ADD CONSTRAINT chk_puntaje CHECK (puntaje >= 0);

-- 1.3.8 Modificar tamaño de un campo texto
ALTER TABLE certificacion_apicola ALTER COLUMN nombre TYPE VARCHAR(150);

-- 1.3.9 Modificar campo numérico con rango
ALTER TABLE certificacion_apicola ADD CONSTRAINT chk_nivel CHECK (nivel BETWEEN 1 AND 5);

-- 1.3.10 Agregar un índice
CREATE INDEX idx_certificacion_codigo ON certificacion_apicola(codigo);

-- 1.3.11 Eliminar una de las fechas
ALTER TABLE certificacion_apicola DROP COLUMN fecha_fin;

-- 1.3.12 Borrar todos los datos de una tabla sin dejar traza
TRUNCATE TABLE certificacion_apicola;


-- =========================
-- SHELL - Conexión
-- =========================

-- Conexión con usuario postgres
-- psql -U postgres 

-- Linux (recomendado si hay error de autenticación)
-- sudo -u postgres psql

-- Parámetros personalizados
-- psql -U postgres -h localhost -p 5432 -d nombre_db

-- Acceso directo a una DB
-- psql -U postgres -d nombre_db

-- Ver bases de datos
-- \l

-- Conectarse a una base
-- \c nombre_db

-- Ver tablas
-- \dt       

-- Salir
-- \q


-- =========================
-- CREACIÓN
-- =========================

-- Crear DB
CREATE DATABASE nombre_db;

-- Crear tabla
CREATE TABLE nombre_tabla (
    col1 tipo,
    col2 tipo
);

-- Crear esquema
CREATE SCHEMA nombre_esquema;

-- Crear esquema con autorización
CREATE SCHEMA nombre_esquema AUTHORIZATION usuario;

-- Crear roles
CREATE ROLE nombre_rol;

-- Crear usuario (rol con login)
CREATE ROLE nombre_usuario WITH LOGIN PASSWORD 'tu_password';


-- =========================
-- ALTERACIÓN
-- =========================

-- Renombrar database (NO estar conectado a esa DB)
ALTER DATABASE nombre_db RENAME TO nuevo_nombre;

-- Renombrar tabla
ALTER TABLE nombre_tabla RENAME TO nuevo_nombre;

-- Renombrar columna
ALTER TABLE nombre_tabla RENAME COLUMN nombre_columna TO nuevo_nombre;

-- Cambiar tipo de dato
ALTER TABLE nombre_tabla 
ALTER COLUMN nombre_columna TYPE nuevo_tipo;

-- Quitar NOT NULL (permitir null)
ALTER TABLE nombre_tabla 
ALTER COLUMN nombre_columna DROP NOT NULL;

-- Agregar NOT NULL
ALTER TABLE nombre_tabla 
ALTER COLUMN nombre_columna SET NOT NULL;

-- Renombrar esquema
ALTER SCHEMA nombre_actual RENAME TO nuevo_nombre;


-- =========================
-- ELIMINAR
-- =========================

-- Eliminar columna
ALTER TABLE nombre_tabla DROP COLUMN nombre_columna;

-- Eliminar tabla
DROP TABLE nombre_tabla;

-- Eliminar tabla si existe
DROP TABLE IF EXISTS nombre_tabla;

-- Eliminar registros de tabla (todos)
DELETE FROM nombre_tabla;

-- Eliminar registros con condición
DELETE FROM nombre_tabla WHERE condicion;

-- Vaciar tabla (más rápido que DELETE)
TRUNCATE TABLE nombre_tabla;

-- Eliminar esquema
DROP SCHEMA nombre_esquema;

-- Eliminar esquema con todo su contenido
DROP SCHEMA nombre_esquema CASCADE;

-- Eliminar base de datos
DROP DATABASE nombre_db;

-- Eliminar roles
DROP ROLE nombre_rol;


-- =========================
-- INSERT
-- =========================

-- Insertar valores
INSERT INTO nombre_tabla (col1, col2)
VALUES (val1, val2);

-- Insertar múltiples valores
INSERT INTO nombre_tabla (col1, col2)
VALUES 
    (val1, val2),
    (val1, val2),
    (val1, val2);


-- =========================
-- UPDATE
-- =========================

-- Actualizar todos los registros
UPDATE nombre_tabla 
SET nombre_columna = valor;

-- Actualizar con condición
UPDATE nombre_tabla 
SET nombre_columna = valor 
WHERE id = 2;

-- Actualizar múltiples columnas
UPDATE nombre_tabla 
SET col1 = val1, col2 = val2;

-- Con condición
UPDATE nombre_tabla 
SET col1 = val1, col2 = val2
WHERE id = 2;


-- =========================
-- SECUENCIAS
-- =========================

-- Crear secuencia (corregido)
CREATE SEQUENCE seq_prueba
INCREMENT BY 1
MINVALUE 1;

-- Usar secuencia
INSERT INTO nombre_tabla (col1, col2)
VALUES (nextval('seq_prueba'), 'AB');

-- Obtener último valor generado
SELECT currval('seq_prueba');
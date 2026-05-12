-- =========================
-- CONSTRAINTS
-- =========================

-- PRIMARY KEY
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

-- FOREIGN KEY
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    usuario_id INT,

    CONSTRAINT fk_usuario
    FOREIGN KEY (usuario_id)
    REFERENCES usuarios(id)
);

-- UNIQUE
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    correo VARCHAR(100) UNIQUE
);

-- CHECK
CREATE TABLE usuarios (
    edad INT CHECK (edad >= 18)
);

-- DEFAULT
CREATE TABLE usuarios (
    activo BOOLEAN DEFAULT true
);

-- NOT NULL
CREATE TABLE usuarios (
    nombre VARCHAR(100) NOT NULL
);


-- =========================
-- ALTER TABLE AVANZADO
-- =========================

-- Agregar columna
ALTER TABLE usuarios
ADD COLUMN telefono VARCHAR(20);

-- Agregar constraint UNIQUE
ALTER TABLE usuarios
ADD CONSTRAINT uq_correo UNIQUE(correo);

-- Agregar FOREIGN KEY
ALTER TABLE pedidos
ADD CONSTRAINT fk_usuario
FOREIGN KEY(usuario_id)
REFERENCES usuarios(id);

-- Eliminar constraint
ALTER TABLE usuarios
DROP CONSTRAINT uq_correo;


-- =========================
-- ÍNDICES
-- =========================

-- Crear índice
CREATE INDEX idx_nombre
ON usuarios(nombre);

-- Índice único
CREATE UNIQUE INDEX idx_correo
ON usuarios(correo);

-- Índice compuesto
CREATE INDEX idx_nombre_apellido
ON usuarios(nombre, apellido);

-- Eliminar índice
DROP INDEX idx_nombre;


-- =========================
-- CASE
-- =========================

-- Condicional simple
SELECT nombre,
CASE
    WHEN edad >= 18 THEN 'Mayor'
    ELSE 'Menor'
END AS categoria
FROM usuarios;


-- =========================
-- COALESCE
-- =========================

-- Reemplazar NULL
SELECT nombre,
COALESCE(telefono, 'Sin teléfono')
FROM usuarios;


-- =========================
-- NULLIF
-- =========================

-- Retorna NULL si son iguales
SELECT NULLIF(10, 10);


-- =========================
-- CAST
-- =========================

-- Convertir tipo
SELECT CAST('123' AS INT);

-- Forma corta
SELECT '123'::INT;


-- =========================
-- EXISTS
-- =========================

-- Verificar existencia
SELECT nombre
FROM usuarios u
WHERE EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.usuario_id = u.id
);


-- =========================
-- ANY / ALL
-- =========================

-- ANY
SELECT *
FROM empleados
WHERE salario > ANY (
    SELECT salario
    FROM empleados
    WHERE departamento = 'Ventas'
);

-- ALL
SELECT *
FROM empleados
WHERE salario > ALL (
    SELECT salario
    FROM empleados
    WHERE departamento = 'Ventas'
);


-- =========================
-- UNION
-- =========================

-- Combinar resultados sin duplicados
SELECT nombre
FROM clientes

UNION

SELECT nombre
FROM proveedores;

-- Con duplicados
SELECT nombre
FROM clientes

UNION ALL

SELECT nombre
FROM proveedores;


-- =========================
-- CTE (WITH)
-- =========================

-- Consulta temporal
WITH empleados_activos AS (
    SELECT *
    FROM empleados
    WHERE activo = true
)

SELECT *
FROM empleados_activos;


-- =========================
-- FUNCIONES DE TEXTO
-- =========================

-- Concatenar
SELECT CONCAT(nombre, ' ', apellido)
FROM usuarios;

-- Substring
SELECT SUBSTRING(nombre, 1, 3)
FROM usuarios;

-- Reemplazar texto
SELECT REPLACE(nombre, 'a', '@')
FROM usuarios;

-- Eliminar espacios
SELECT TRIM(nombre)
FROM usuarios;


-- =========================
-- FUNCIONES NUMÉRICAS
-- =========================

-- Redondear
SELECT ROUND(15.678, 2);

-- Truncar
SELECT TRUNC(15.678, 2);

-- Valor absoluto
SELECT ABS(-50);

-- Potencia
SELECT POWER(2, 3);


-- =========================
-- FUNCIONES DE FECHA
-- =========================

-- Fecha actual
SELECT CURRENT_DATE;

-- Hora actual
SELECT CURRENT_TIME;

-- Fecha y hora
SELECT NOW();

-- Extraer mes
SELECT EXTRACT(MONTH FROM NOW());

-- Diferencia entre fechas
SELECT AGE('2025-01-01', '2000-01-01');


-- =========================
-- GENERATE_SERIES
-- =========================

-- Generar números
SELECT *
FROM generate_series(1, 10);

-- Generar fechas
SELECT *
FROM generate_series(
    '2025-01-01'::date,
    '2025-01-10'::date,
    '1 day'
);


-- =========================
-- UPSERT
-- =========================

-- Insertar o actualizar
INSERT INTO usuarios(id, nombre)
VALUES (1, 'Juan')

ON CONFLICT(id)
DO UPDATE
SET nombre = EXCLUDED.nombre;


-- =========================
-- RETURNING
-- =========================

-- Retornar datos insertados
INSERT INTO usuarios(nombre)
VALUES ('Carlos')
RETURNING *;

-- Retornar datos eliminados
DELETE FROM usuarios
WHERE id = 1
RETURNING *;


-- =========================
-- VISTAS MATERIALIZADAS
-- =========================

-- Crear materialized view
CREATE MATERIALIZED VIEW vista_resumen AS
SELECT departamento, COUNT(*)
FROM empleados
GROUP BY departamento;

-- Actualizar vista
REFRESH MATERIALIZED VIEW vista_resumen;

-- Eliminar vista
DROP MATERIALIZED VIEW vista_resumen;


-- =========================
-- ENUM
-- =========================

-- Crear tipo ENUM
CREATE TYPE estado_enum AS ENUM (
    'activo',
    'inactivo',
    'pendiente'
);

-- Usar ENUM
CREATE TABLE usuarios (
    estado estado_enum
);


-- =========================
-- UUID
-- =========================

-- Habilitar extensión
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Generar UUID
SELECT uuid_generate_v4();

-- Usar UUID
CREATE TABLE usuarios (
    id UUID DEFAULT uuid_generate_v4()
);


-- =========================
-- JSON / JSONB
-- =========================

-- Crear tabla JSONB
CREATE TABLE productos (
    id SERIAL,
    info JSONB
);

-- Insertar JSON
INSERT INTO productos(info)
VALUES (
    '{"nombre":"Laptop","precio":15000}'
);

-- Obtener valor JSON
SELECT info->>'nombre'
FROM productos;

-- Buscar por JSON
SELECT *
FROM productos
WHERE info->>'nombre' = 'Laptop';


-- =========================
-- PERMISOS
-- =========================

-- Dar permisos
GRANT SELECT, INSERT, UPDATE
ON usuarios
TO usuario_app;

-- Revocar permisos
REVOKE UPDATE
ON usuarios
FROM usuario_app;


-- =========================
-- EXPORTAR / IMPORTAR
-- =========================

-- Exportar tabla CSV
COPY usuarios TO '/ruta/usuarios.csv'
DELIMITER ','
CSV HEADER;

-- Importar CSV
COPY usuarios
FROM '/ruta/usuarios.csv'
DELIMITER ','
CSV HEADER;
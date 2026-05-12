-- =========================
-- FUNCIONES (FUNCTION)
-- =========================

-- Crear función simple
CREATE OR REPLACE FUNCTION saludar()
RETURNS TEXT AS
$$
BEGIN
    RETURN 'Hola mundo';
END;
$$ LANGUAGE plpgsql;

-- Ejecutar función
SELECT saludar();

-- Función con parámetros
CREATE OR REPLACE FUNCTION suma(a INT, b INT)
RETURNS INT AS
$$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;

-- Ejecutar
SELECT suma(10, 5);


-- =========================
-- PROCEDIMIENTOS
-- =========================

-- Crear procedimiento
CREATE OR REPLACE PROCEDURE actualizar_salarios()
LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE empleados
    SET salario = salario * 1.10;
END;
$$;

-- Ejecutar procedimiento
CALL actualizar_salarios();


-- =========================
-- TRIGGERS
-- =========================

-- Función para trigger
CREATE OR REPLACE FUNCTION actualizar_fecha()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear trigger
CREATE TRIGGER trg_actualizar_fecha
BEFORE UPDATE
ON usuarios
FOR EACH ROW
EXECUTE FUNCTION actualizar_fecha();


-- =========================
-- TABLAS PARTICIONADAS
-- =========================

-- Tabla principal
CREATE TABLE ventas (
    id SERIAL,
    fecha DATE,
    total NUMERIC
)
PARTITION BY RANGE (fecha);

-- Partición
CREATE TABLE ventas_2025
PARTITION OF ventas
FOR VALUES FROM ('2025-01-01')
TO ('2026-01-01');


-- =========================
-- WINDOW FUNCTIONS
-- =========================

-- ROW_NUMBER
SELECT nombre,
ROW_NUMBER() OVER(ORDER BY salario DESC)
FROM empleados;

-- RANK
SELECT nombre,
RANK() OVER(ORDER BY salario DESC)
FROM empleados;

-- SUM OVER
SELECT nombre,
SUM(salario) OVER()
FROM empleados;


-- =========================
-- TRANSACCIONES AVANZADAS
-- =========================

-- Savepoint
BEGIN;

UPDATE cuentas
SET saldo = saldo - 100
WHERE id = 1;

SAVEPOINT punto_seguro;

UPDATE cuentas
SET saldo = saldo + 100
WHERE id = 2;

-- Volver al savepoint
ROLLBACK TO punto_seguro;

COMMIT;


-- =========================
-- BLOQUES DO
-- =========================

-- Ejecutar bloque anónimo
DO
$$
BEGIN
    RAISE NOTICE 'Hola desde PostgreSQL';
END;
$$;


-- =========================
-- CURSORES
-- =========================

-- Cursor manual
BEGIN;

DECLARE cursor_usuarios CURSOR FOR
SELECT nombre
FROM usuarios;

FETCH NEXT FROM cursor_usuarios;

CLOSE cursor_usuarios;

COMMIT;


-- =========================
-- MANEJO DE EXCEPCIONES
-- =========================

CREATE OR REPLACE FUNCTION dividir(a NUMERIC, b NUMERIC)
RETURNS NUMERIC AS
$$
BEGIN
    RETURN a / b;

EXCEPTION
    WHEN division_by_zero THEN
        RAISE NOTICE 'No se puede dividir entre cero';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- =========================
-- TABLAS TEMPORALES
-- =========================

-- Crear tabla temporal
CREATE TEMP TABLE temp_usuarios (
    id INT,
    nombre TEXT
);

-- Insertar datos
INSERT INTO temp_usuarios
VALUES (1, 'Juan');


-- =========================
-- EXPLAIN
-- =========================

-- Ver plan de ejecución
EXPLAIN
SELECT *
FROM usuarios
WHERE id = 1;

-- Analizar rendimiento real
EXPLAIN ANALYZE
SELECT *
FROM usuarios
WHERE id = 1;


-- =========================
-- LOCKS
-- =========================

-- Bloquear fila
BEGIN;

SELECT *
FROM usuarios
WHERE id = 1
FOR UPDATE;

COMMIT;


-- =========================
-- RECURSIVE CTE
-- =========================

-- CTE recursivo
WITH RECURSIVE numeros AS (

    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numeros
    WHERE n < 10
)

SELECT *
FROM numeros;


-- =========================
-- ARRAY
-- =========================

-- Crear array
SELECT ARRAY[1,2,3];

-- Acceder elemento
SELECT ARRAY[1,2,3][1];

-- Buscar en array
SELECT *
FROM usuarios
WHERE 'admin' = ANY(roles);


-- =========================
-- OPERADORES JSONB
-- =========================

-- Obtener campo JSON
SELECT info->>'nombre'
FROM productos;

-- Obtener objeto JSON
SELECT info->'direccion'
FROM usuarios;

-- Verificar clave
SELECT *
FROM productos
WHERE info ? 'precio';

-- Contiene JSON
SELECT *
FROM productos
WHERE info @> '{"nombre":"Laptop"}';


-- =========================
-- FULL TEXT SEARCH
-- =========================

-- Búsqueda textual
SELECT *
FROM articulos
WHERE to_tsvector(contenido)
@@ to_tsquery('postgres');

-- Ranking
SELECT titulo,
ts_rank(
    to_tsvector(contenido),
    to_tsquery('postgres')
)
FROM articulos;


-- =========================
-- LISTEN / NOTIFY
-- =========================

-- Escuchar canal
LISTEN nuevo_evento;

-- Enviar notificación
NOTIFY nuevo_evento, 'Nuevo registro creado';


-- =========================
-- EXTENSIONES
-- =========================

-- Ver extensiones
SELECT *
FROM pg_extension;

-- Instalar extensión
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Eliminar extensión
DROP EXTENSION "uuid-ossp";


-- =========================
-- INFORMACIÓN DEL SISTEMA
-- =========================

-- Versión PostgreSQL
SELECT version();

-- Usuario actual
SELECT current_user;

-- Base actual
SELECT current_database();

-- Puerto
SHOW port;

-- Directorio de datos
SHOW data_directory;


-- =========================
-- ADMINISTRACIÓN
-- =========================

-- Ver conexiones activas
SELECT *
FROM pg_stat_activity;

-- Terminar proceso
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE pid = 12345;

-- Ver tamaño de DB
SELECT pg_size_pretty(
    pg_database_size('nombre_db')
);

-- Ver tamaño de tabla
SELECT pg_size_pretty(
    pg_total_relation_size('usuarios')
);


-- =========================
-- BACKUP AVANZADO
-- =========================

-- Backup custom
pg_dump -U postgres -Fc nombre_db > backup.dump

-- Restaurar custom
pg_restore -U postgres -d nombre_db backup.dump

-- Backup comprimido
pg_dump nombre_db | gzip > backup.sql.gz


-- =========================
-- REINDEX / VACUUM
-- =========================

-- Limpiar espacio
VACUUM;

-- Analizar estadísticas
ANALYZE;

-- Vacuum completo
VACUUM FULL;

-- Reindexar tabla
REINDEX TABLE usuarios;


-- =========================
-- ROLES AVANZADOS
-- =========================

-- Crear rol administrador
CREATE ROLE admin
WITH
LOGIN
SUPERUSER
CREATEDB
CREATEROLE
PASSWORD 'password';

-- Cambiar contraseña
ALTER ROLE admin
PASSWORD 'nueva_password';


-- =========================
-- HERENCIA DE TABLAS
-- =========================

-- Tabla padre
CREATE TABLE persona (
    nombre TEXT
);

-- Tabla hija
CREATE TABLE empleado (
    salario NUMERIC
)
INHERITS (persona);


-- =========================
-- DOMINIOS
-- =========================

-- Crear dominio personalizado
CREATE DOMAIN correo_valido AS TEXT
CHECK (
    VALUE ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
);

-- Usar dominio
CREATE TABLE usuarios (
    correo correo_valido
);
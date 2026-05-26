-- =========================
-- USUARIOS / ROLES
-- =========================

CREATE USER usuario WITH PASSWORD '1234';

CREATE ROLE usuario LOGIN PASSWORD '1234';

ALTER USER usuario WITH PASSWORD 'nueva_pass';

DROP USER usuario;

ALTER USER usuario WITH SUPERUSER;

ALTER USER usuario WITH NOSUPERUSER;

ALTER USER usuario CREATEDB;

ALTER USER usuario NOCREATEDB;

ALTER USER usuario CREATEROLE;

ALTER USER usuario NOCREATEROLE;

-- Ver usuarios
\du

SELECT * FROM pg_roles;


-- =========================
-- BASES DE DATOS
-- =========================

CREATE DATABASE mibd;

CREATE DATABASE mibd OWNER usuario;

DROP DATABASE mibd;

-- Ver bases
\l

SELECT datname FROM pg_database;

-- Conectarse
\c mibd


-- =========================
-- TABLAS
-- =========================

CREATE TABLE alumnos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

DROP TABLE alumnos;

-- Ver tablas
\dt


-- =========================
-- PRIVILEGIOS DATABASE
-- =========================

GRANT CONNECT ON DATABASE mibd TO usuario;

GRANT ALL PRIVILEGES ON DATABASE mibd TO usuario;

REVOKE CONNECT ON DATABASE mibd FROM usuario;

REVOKE ALL PRIVILEGES ON DATABASE mibd FROM usuario;


-- =========================
-- PRIVILEGIOS SCHEMA
-- =========================

GRANT USAGE ON SCHEMA public TO usuario;

GRANT CREATE ON SCHEMA public TO usuario;

GRANT ALL ON SCHEMA public TO usuario;

REVOKE CREATE ON SCHEMA public FROM usuario;

REVOKE ALL ON SCHEMA public FROM usuario;


-- =========================
-- PRIVILEGIOS TABLAS
-- =========================

GRANT SELECT ON alumnos TO usuario;

GRANT INSERT ON alumnos TO usuario;

GRANT UPDATE ON alumnos TO usuario;

GRANT DELETE ON alumnos TO usuario;

GRANT TRUNCATE ON alumnos TO usuario;

GRANT REFERENCES ON alumnos TO usuario;

GRANT TRIGGER ON alumnos TO usuario;

GRANT ALL PRIVILEGES ON alumnos TO usuario;

REVOKE SELECT ON alumnos FROM usuario;

REVOKE INSERT ON alumnos FROM usuario;

REVOKE UPDATE ON alumnos FROM usuario;

REVOKE DELETE ON alumnos FROM usuario;

REVOKE ALL PRIVILEGES ON alumnos FROM usuario;


-- =========================
-- TODAS LAS TABLAS
-- =========================

GRANT SELECT
ON ALL TABLES IN SCHEMA public
TO usuario;

GRANT ALL PRIVILEGES
ON ALL TABLES IN SCHEMA public
TO usuario;

REVOKE ALL PRIVILEGES
ON ALL TABLES IN SCHEMA public
FROM usuario;


-- =========================
-- PERMISOS FUTUROS
-- =========================

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLES TO usuario;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL
ON TABLES TO usuario;


-- =========================
-- SECUENCIAS
-- =========================

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO usuario;

GRANT ALL PRIVILEGES
ON ALL SEQUENCES IN SCHEMA public
TO usuario;

REVOKE ALL PRIVILEGES
ON ALL SEQUENCES IN SCHEMA public
FROM usuario;


-- =========================
-- CONSULTAS ÚTILES
-- =========================

SELECT current_user;

SELECT current_database();

SELECT * FROM information_schema.role_table_grants;

\z alumnos

\dn

\dp
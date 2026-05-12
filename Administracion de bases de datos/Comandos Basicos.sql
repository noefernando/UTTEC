-- =========================
-- SELECT
-- =========================

-- Obtener todos los registros
SELECT * FROM nombre_tabla;

-- Obtener columnas específicas
SELECT col1, col2
FROM nombre_tabla;

-- Alias de columnas
SELECT col1 AS alias
FROM nombre_tabla;

-- Valores únicos
SELECT DISTINCT col1
FROM nombre_tabla;


-- =========================
-- WHERE
-- =========================

-- Condición simple
SELECT *
FROM nombre_tabla
WHERE id = 1;

-- Mayor que
SELECT *
FROM nombre_tabla
WHERE edad > 18;

-- Menor que
SELECT *
FROM nombre_tabla
WHERE edad < 18;

-- Diferente
SELECT *
FROM nombre_tabla
WHERE estado != 'activo';

-- AND
SELECT *
FROM nombre_tabla
WHERE edad > 18
AND activo = true;

-- OR
SELECT *
FROM nombre_tabla
WHERE ciudad = 'CDMX'
OR ciudad = 'Puebla';

-- IN
SELECT *
FROM nombre_tabla
WHERE id IN (1,2,3);

-- BETWEEN
SELECT *
FROM nombre_tabla
WHERE edad BETWEEN 18 AND 30;

-- LIKE
SELECT *
FROM nombre_tabla
WHERE nombre LIKE 'A%';

-- NULL
SELECT *
FROM nombre_tabla
WHERE correo IS NULL;

-- NOT NULL
SELECT *
FROM nombre_tabla
WHERE correo IS NOT NULL;


-- =========================
-- ORDER BY
-- =========================

-- Orden ascendente
SELECT *
FROM nombre_tabla
ORDER BY nombre ASC;

-- Orden descendente
SELECT *
FROM nombre_tabla
ORDER BY id DESC;


-- =========================
-- LIMIT / OFFSET
-- =========================

-- Limitar resultados
SELECT *
FROM nombre_tabla
LIMIT 10;

-- Saltar registros
SELECT *
FROM nombre_tabla
OFFSET 5;

-- Paginación
SELECT *
FROM nombre_tabla
LIMIT 10 OFFSET 20;


-- =========================
-- FUNCIONES DE AGREGACIÓN
-- =========================

-- Contar registros
SELECT COUNT(*)
FROM nombre_tabla;

-- Suma
SELECT SUM(salario)
FROM empleados;

-- Promedio
SELECT AVG(salario)
FROM empleados;

-- Máximo
SELECT MAX(salario)
FROM empleados;

-- Mínimo
SELECT MIN(salario)
FROM empleados;


-- =========================
-- GROUP BY
-- =========================

-- Agrupar registros
SELECT departamento, COUNT(*)
FROM empleados
GROUP BY departamento;

-- Agrupar con suma
SELECT departamento, SUM(salario)
FROM empleados
GROUP BY departamento;


-- =========================
-- HAVING
-- =========================

-- Filtrar grupos
SELECT departamento, COUNT(*)
FROM empleados
GROUP BY departamento
HAVING COUNT(*) > 5;


-- =========================
-- INNER JOIN
-- =========================

-- Relacionar tablas
SELECT *
FROM pedidos p
INNER JOIN clientes c
ON p.cliente_id = c.id;


-- =========================
-- LEFT JOIN
-- =========================

-- Todos los registros de la izquierda
SELECT *
FROM clientes c
LEFT JOIN pedidos p
ON c.id = p.cliente_id;


-- =========================
-- RIGHT JOIN
-- =========================

-- Todos los registros de la derecha
SELECT *
FROM clientes c
RIGHT JOIN pedidos p
ON c.id = p.cliente_id;


-- =========================
-- FULL JOIN
-- =========================

-- Todos los registros de ambas tablas
SELECT *
FROM clientes c
FULL JOIN pedidos p
ON c.id = p.cliente_id;


-- =========================
-- SUBCONSULTAS
-- =========================

-- Subconsulta simple
SELECT *
FROM empleados
WHERE salario > (
    SELECT AVG(salario)
    FROM empleados
);


-- =========================
-- ALIAS
-- =========================

-- Alias de tabla
SELECT u.nombre
FROM usuarios u;

-- Alias de columnas
SELECT nombre AS usuario
FROM usuarios;


-- =========================
-- OPERADORES ÚTILES
-- =========================

-- Concatenar texto
SELECT nombre || ' ' || apellido
FROM usuarios;

-- Redondear
SELECT ROUND(promedio, 2)
FROM calificaciones;

-- Longitud de texto
SELECT LENGTH(nombre)
FROM usuarios;

-- Convertir mayúsculas
SELECT UPPER(nombre)
FROM usuarios;

-- Convertir minúsculas
SELECT LOWER(nombre)
FROM usuarios;


-- =========================
-- FECHAS
-- =========================

-- Fecha actual
SELECT CURRENT_DATE;

-- Fecha y hora actual
SELECT NOW();

-- Extraer año
SELECT EXTRACT(YEAR FROM NOW());

-- Sumar días
SELECT CURRENT_DATE + INTERVAL '5 days';


-- =========================
-- VISTAS
-- =========================

-- Crear vista
CREATE VIEW vista_usuarios AS
SELECT nombre, correo
FROM usuarios;

-- Consultar vista
SELECT *
FROM vista_usuarios;

-- Eliminar vista
DROP VIEW vista_usuarios;


-- =========================
-- TRANSACCIONES
-- =========================

-- Iniciar transacción
BEGIN;

-- Operaciones
UPDATE cuentas
SET saldo = saldo - 100
WHERE id = 1;

UPDATE cuentas
SET saldo = saldo + 100
WHERE id = 2;

-- Confirmar cambios
COMMIT;

-- Deshacer cambios
ROLLBACK;
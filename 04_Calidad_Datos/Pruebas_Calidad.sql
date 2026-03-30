USE jardineria_staging;

-- =================================================================
-- PRUEBAS DE VERIFICACIÓN DE CALIDAD DE DATOS (DATA QUALITY)
-- =================================================================

-- 1. PRUEBA DE COMPLETITUD (Valores Nulos)
-- Objetivo: Verificar que no falten datos críticos para los KPIs (cantidades o precios).
-- Resultado esperado: 0 registros.
SELECT 'Cantidades Nulas' AS Metrica, COUNT(*) AS Total_Errores 
FROM stg_detalle_pedido 
WHERE cantidad IS NULL OR cantidad = ''
UNION
SELECT 'Precios Nulos', COUNT(*) 
FROM stg_detalle_pedido 
WHERE precio_unidad IS NULL OR precio_unidad = '';

-- 2. PRUEBA DE INTEGRIDAD REFERENCIAL (Datos Huérfanos)
-- Objetivo: Verificar si existen pedidos asignados a un cliente que no existe en la base de datos.
-- Resultado esperado: 0 registros.
SELECT p.ID_pedido, p.ID_cliente AS Cliente_Inexistente
FROM stg_pedido p
LEFT JOIN stg_cliente c ON p.ID_cliente = c.ID_cliente
WHERE c.ID_cliente IS NULL;

-- 3. PRUEBA DE VALIDEZ (Rangos lógicos)
-- Objetivo: Asegurar que no existan cantidades negativas o precios ilógicos (menores a 0).
-- Resultado esperado: 0 registros.
SELECT ID_pedido, ID_producto, cantidad, precio_unidad
FROM stg_detalle_pedido
WHERE cantidad <= 0 OR precio_unidad < 0;

-- 4. PRUEBA DE UNICIDAD (Duplicados)
-- Objetivo: Garantizar que no se haya migrado el mismo cliente más de una vez a Staging.
-- Resultado esperado: Ninguna fila devuelta. Si devuelve algo, indica el ID duplicado.
SELECT ID_cliente, COUNT(*) as Frecuencia
FROM stg_cliente
GROUP BY ID_cliente
HAVING Frecuencia > 1;

-- 5. PRUEBA DE CONSISTENCIA DE FORMATO (Longitud de códigos)
-- Objetivo: Validar que los códigos de producto mantengan un estándar (no estén vacíos ni sean excesivamente cortos/largos por error tipográfico).
-- Resultado esperado: 0 registros.
SELECT ID_producto, nombre 
FROM stg_producto 
WHERE LENGTH(ID_producto) < 2 OR LENGTH(ID_producto) > 15;
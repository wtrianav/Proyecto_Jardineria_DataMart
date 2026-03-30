-- ------------------------------------------------------------------
-- PASO 1: Creación de la Base de Datos Staging
-- ------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS jardineria_staging;
USE jardineria_staging;

-- ------------------------------------------------------------------
-- PASO 2: Creación de Tablas Staging (Estructuras simplificadas, sin FKs)
-- ------------------------------------------------------------------
DROP TABLE IF EXISTS stg_cliente;
CREATE TABLE stg_cliente (
  ID_cliente INT,
  nombre_cliente VARCHAR(50),
  ciudad VARCHAR(50),
  region VARCHAR(50),
  pais VARCHAR(50)
);

DROP TABLE IF EXISTS stg_categoria_producto;
CREATE TABLE stg_categoria_producto (
  Id_Categoria INT,
  Desc_Categoria VARCHAR(50)
);

DROP TABLE IF EXISTS stg_producto;
CREATE TABLE stg_producto (
  ID_producto VARCHAR(15), 
  nombre VARCHAR(70),
  Categoria INT,
  proveedor VARCHAR(50),
  precio_venta NUMERIC(15,2)
);

DROP TABLE IF EXISTS stg_pedido;
CREATE TABLE stg_pedido (
  ID_pedido INT,
  fecha_pedido DATE,
  ID_cliente INT
);

DROP TABLE IF EXISTS stg_detalle_pedido;
CREATE TABLE stg_detalle_pedido (
  ID_pedido INT,
  ID_producto VARCHAR(15),
  cantidad INT,
  precio_unidad NUMERIC(15,2)
);

-- ------------------------------------------------------------------
-- PASO 3: Extracción de Datos (Poblado del área de Staging)
-- ------------------------------------------------------------------
-- Se usa TRUNCATE por si el script se corre múltiples veces, evitar duplicados.
TRUNCATE TABLE stg_cliente;
INSERT INTO stg_cliente (ID_cliente, nombre_cliente, ciudad, region, pais)
SELECT ID_cliente, nombre_cliente, ciudad, region, pais 
FROM jardineria.cliente;

TRUNCATE TABLE stg_categoria_producto;
INSERT INTO stg_categoria_producto (Id_Categoria, Desc_Categoria)
SELECT Id_Categoria, Desc_Categoria 
FROM jardineria.Categoria_producto;

TRUNCATE TABLE stg_producto;
INSERT INTO stg_producto (ID_producto, nombre, Categoria, proveedor, precio_venta)
SELECT ID_producto, nombre, Categoria, proveedor, precio_venta 
FROM jardineria.producto;

TRUNCATE TABLE stg_pedido;
INSERT INTO stg_pedido (ID_pedido, fecha_pedido, ID_cliente)
SELECT ID_pedido, fecha_pedido, ID_cliente 
FROM jardineria.pedido;

TRUNCATE TABLE stg_detalle_pedido;
INSERT INTO stg_detalle_pedido (ID_pedido, ID_producto, cantidad, precio_unidad)
SELECT ID_pedido, ID_producto, cantidad, precio_unidad 
FROM jardineria.detalle_pedido;

-- ------------------------------------------------------------------
-- PASO 4: Validación
-- ------------------------------------------------------------------
-- Ejecutar para comprobar que los datos pasaron correctamente
SELECT 'Clientes Migrados' AS Tabla, COUNT(*) AS Total FROM stg_cliente
UNION
SELECT 'Productos Migrados', COUNT(*) FROM stg_producto
UNION
SELECT 'Detalles Migrados', COUNT(*) FROM stg_detalle_pedido;
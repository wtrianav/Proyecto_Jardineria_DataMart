CREATE DATABASE IF NOT EXISTS Jardineria_DataMart;
USE Jardineria_DataMart;

CREATE TABLE Dim_Tiempo (
  PK_Tiempo INT NOT NULL,
  Fecha_Completa DATE NOT NULL,
  Anio INT NOT NULL,
  Trimestre INT NOT NULL,
  Mes_Numero INT NOT NULL,
  Mes_Nombre VARCHAR(20) NOT NULL,
  Dia_Numero INT NOT NULL,
  Dia_Semana VARCHAR(20) NOT NULL,
  PRIMARY KEY (PK_Tiempo)
);

CREATE TABLE Dim_Producto (
  PK_Producto INT NOT NULL AUTO_INCREMENT,
  Codigo_Producto_Original VARCHAR(15) NOT NULL,
  Nombre_Producto VARCHAR(70) NOT NULL,
  Proveedor VARCHAR(50) DEFAULT NULL,
  Categoria_Nombre VARCHAR(50) NOT NULL,
  Categoria_Descripcion TEXT DEFAULT NULL,
  Precio_Venta_Actual DECIMAL(15,2) NOT NULL,
  PRIMARY KEY (PK_Producto)
);

CREATE TABLE Dim_Cliente (
  PK_Cliente INT NOT NULL AUTO_INCREMENT,
  ID_Cliente_Original INT NOT NULL,
  Nombre_Cliente VARCHAR(50) NOT NULL,
  Ciudad VARCHAR(50) NOT NULL,
  Pais VARCHAR(50) DEFAULT NULL,
  Region VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (PK_Cliente)
);

CREATE TABLE Hechos_Ventas (
  PK_Hecho INT NOT NULL AUTO_INCREMENT,
  FK_Tiempo INT NOT NULL,
  FK_Producto INT NOT NULL,
  FK_Cliente INT NOT NULL,
  Cantidad_Vendida INT NOT NULL,
  Precio_Unitario_Venta DECIMAL(15,2) NOT NULL,
  Total_Linea_Venta DECIMAL(15,2) NOT NULL,
  Numero_Pedido_Original INT NOT NULL,
  PRIMARY KEY (PK_Hecho),
  
  -- Definición de claves foráneas (Relaciones)
  INDEX idx_tiempo (FK_Tiempo ASC),
  INDEX idx_producto (FK_Producto ASC),
  INDEX idx_cliente (FK_Cliente ASC),
  
  CONSTRAINT fk_hechos_tiempo
    FOREIGN KEY (FK_Tiempo)
    REFERENCES Dim_Tiempo (PK_Tiempo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    
  CONSTRAINT fk_hechos_producto
    FOREIGN KEY (FK_Producto)
    REFERENCES Dim_Producto (PK_Producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    
  CONSTRAINT fk_hechos_cliente
    FOREIGN KEY (FK_Cliente)
    REFERENCES Dim_Cliente (PK_Cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
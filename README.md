# 🌿 Proyecto de Inteligencia de Negocios: Data Mart "Jardinería"

![Status](https://img.shields.io/badge/Estado-Completado-success)
![Database](https://img.shields.io/badge/Base_de_Datos-MySQL-blue)
![Architecture](https://img.shields.io/badge/Arquitectura-OLTP_a_OLAP-orange)

## 📖 Descripción del Proyecto

Este repositorio contiene el diseño, desarrollo e implementación de una solución de Inteligencia de Negocios (Business Intelligence) para la empresa ficticia "Jardinería".

El objetivo principal fue migrar los datos desde un sistema transaccional altamente normalizado (OLTP) hacia un modelo dimensional en estrella (Data Mart / OLAP), pasando por un área intermedia de preparación de datos (Staging). Esto permite a la gerencia realizar análisis históricos eficientes y tomar decisiones basadas en datos.

## 🎯 Indicadores Clave de Rendimiento (KPIs) Analizados

El modelo estrella fue diseñado específicamente para responder con alta eficiencia a las siguientes preguntas de negocio:

1. ¿Cuál es el **producto más vendido** históricamente?
2. ¿Cuál es la **categoría que concentra la mayor cantidad de productos**?
3. ¿Cuál ha sido el **año con el mayor volumen de ventas** (ingresos)?

## 🏗️ Arquitectura de la Solución

El proyecto se desarrolló en tres fases principales:

1. **Origen (OLTP):** Base de datos relacional original `jardineria`.
2. **Staging Area:** Base de datos `jardineria_staging`. Un entorno temporal donde se extrajo la información en crudo sin alterar el rendimiento del sistema original, aplicando limpieza de datos y eliminando restricciones de claves foráneas.
3. **Data Mart (OLAP):** Base de datos `Jardineria_DataMart` estructurada en un Modelo Estrella, compuesto por una tabla central (`Hechos_Ventas`) y dimensiones desnormalizadas (`Dim_Producto`, `Dim_Cliente`, `Dim_Tiempo`).

## 📂 Estructura del Repositorio

```text
📁 Proyecto_Jardineria_DataMart
│
├── 📂 01_Documentacion/
│   └── Informes_Proyecto_Jardineria_APA.pdf   # Documentos formales con análisis, planteamiento y conclusiones.
│
├── 📂 02_Modelado/
│   ├── Modelo_Relacional_Original.jpg         # DER de la base de datos OLTP.
│   └── Modelo_Estrella_DataMart.png           # Diseño del esquema en estrella resultante.
│
├── 📂 03_Scripts_SQL/
│   ├── 01_Creacion_Jardineria_Original.sql    # Script original con datos limpios y corregidos.
│   ├── 02_Creacion_Staging.sql                # Script ETL (Extracción a área de Staging).
│   └── 03_Creacion_Jardineria_DataMart.sql    # DDL del modelo dimensional en estrella.
│
├── 📂 04_Calidad_Datos/
│   └── 04_Pruebas_Calidad.sql                 # Consultas de auditoría (Completitud, Integridad, Validez, Unicidad).
│
├── 📂 05_Backups/
│   ├── BK_Jardineria_Original.sql             # Respaldo de la base de datos fuente.
│   └── BK_Jardineria_Staging.sql              # Respaldo del área de staging.
│
└── README.md                                  # Este archivo.


## 🛠️ Tecnologías Utilizadas
* **Motor de Base de Datos:** MySQL
* **Herramientas de Modelado:** MySQL Workbench / Mermaid
* **Control de Versiones:** Git & GitHub
* **Lenguaje:** SQL (DDL, DML, TCL)

## 🚀 Instrucciones de Ejecución
Para reproducir este entorno de manera local, ejecuta los scripts ubicados en la carpeta `03_Scripts_SQL` utilizando MySQL Workbench en el siguiente orden estricto:

1. Ejecutar `01_Creacion_Jardineria_Original.sql` para levantar el sistema fuente operativo.
2. Ejecutar `02_Creacion_Staging.sql` para crear el área temporal y migrar los datos masivamente.
3. Ejecutar `03_Creacion_Jardineria_DataMart.sql` para generar la estructura del Data Warehouse analítico.
4. *(Opcional)* Ejecutar el script dentro de `04_Calidad_Datos/` para verificar la limpieza e integridad de la migración.

## 👨‍💻 Autor
* **[Wilmer Andrés Triana Vega]** - *Análisis, Modelado de Datos y Desarrollo SQL.*
```

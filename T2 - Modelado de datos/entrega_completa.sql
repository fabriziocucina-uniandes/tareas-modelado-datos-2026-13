DROP TABLE IF EXISTS Hecho_Movimiento;
DROP TABLE IF EXISTS Fecha;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Proveedor;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS TipoTransaccion;

-- ---------------------- Dimension Fecha ------------------------------
CREATE TABLE Fecha (
    ID_Fecha          INT,
    Fecha             DATE,
    Dia               TINYINT,
    Mes               VARCHAR(20),
    Anio              SMALLINT,
    Numero_semana_ISO TINYINT,
    PRIMARY KEY (ID_Fecha)
);

-- ---------------------- Dimension Producto ---------------------------
CREATE TABLE Producto (
    ID_Producto_DWH               SMALLINT,
    ID_Producto_T                 SMALLINT,
    Nombre                        VARCHAR(100),
    Marca                         VARCHAR(30),
    Paquete_de_compra             VARCHAR(20),
    Color                         VARCHAR(10),
    Necesita_refrigeracion        BOOLEAN,
    Dias_tiempo_entrega           SMALLINT,
    cantidad_por_salida           INT,
    Precio_minorista_recomendado  FLOAT,
    Paquete_de_venta              VARCHAR(20),
    Precio_unitario               FLOAT,
    PRIMARY KEY (ID_Producto_DWH)
);

-- ---------------------- Dimension Proveedor --------------------------
CREATE TABLE Proveedor (
    ID_Proveedor_DWH    INT,
    ID_Proveedor_T      INT,
    Nombre              VARCHAR(20),
    Categoria           VARCHAR(20),
    Contacto_principal  VARCHAR(30),
    Dias_pago           INT,
    Codigo_postal       INT,
    PRIMARY KEY (ID_Proveedor_DWH)
);

-- ---------------------- Dimension TipoTransaccion --------------------
CREATE TABLE TipoTransaccion (
    ID_Tipo_transaccion_DWH  TINYINT,
    ID_Tipo_transaccion_T    TINYINT,
    Tipo                     VARCHAR(20),
    PRIMARY KEY (ID_Tipo_transaccion_DWH)
);

-- ---------------------- Dimension Cliente --------------------
CREATE TABLE Cliente (
    ID_Cliente_DWH        INT,
    ID_Cliente_T          INT,
    Nombre                VARCHAR(100),
    ClienteFactura        VARCHAR(100),
    ID_CiudadEntrega_DWH  INT,
    LimiteCredito         FLOAT,
    FechaAperturaCuenta   DATE,
    DiasPago              INT,
    NombreGrupoCompra     VARCHAR(50),
    NombreCategoria       VARCHAR(50),
    PRIMARY KEY (ID_Cliente_DWH)
);

-- ---------------------- Tabla de Hechos Movimiento -----------
CREATE TABLE Hecho_Movimiento (
    ID_Movimiento            INT AUTO_INCREMENT,
    ID_Fecha                 INT,
    ID_Producto_DWH          SMALLINT,
    ID_Proveedor_DWH         INT,
    ID_Cliente_DWH           INT,
    ID_Tipo_transaccion_DWH  TINYINT,
    Cantidad                 INT,
    PRIMARY KEY (ID_Movimiento),
    CONSTRAINT fk_mov_fecha     FOREIGN KEY (ID_Fecha)
        REFERENCES Fecha(ID_Fecha),
    CONSTRAINT fk_mov_producto  FOREIGN KEY (ID_Producto_DWH)
        REFERENCES Producto(ID_Producto_DWH),
    CONSTRAINT fk_mov_proveedor FOREIGN KEY (ID_Proveedor_DWH)
        REFERENCES Proveedor(ID_Proveedor_DWH),
    CONSTRAINT fk_mov_cliente   FOREIGN KEY (ID_Cliente_DWH)
        REFERENCES Cliente(ID_Cliente_DWH),
    CONSTRAINT fk_mov_tipo      FOREIGN KEY (ID_Tipo_transaccion_DWH)
        REFERENCES TipoTransaccion(ID_Tipo_transaccion_DWH)
);

INSERT INTO Fecha (ID_Fecha, Fecha, Dia, Mes, Anio, Numero_semana_ISO) VALUES
(20260115, '2026-01-15', 15, 'Enero',   2026, 3),
(20260220, '2026-02-20', 20, 'Febrero', 2026, 8);

INSERT INTO Producto
(ID_Producto_DWH, ID_Producto_T, Nombre, Marca, Paquete_de_compra, Color,
 Necesita_refrigeracion, Dias_tiempo_entrega, cantidad_por_salida,
 Precio_minorista_recomendado, Paquete_de_venta, Precio_unitario) VALUES
(1, 1001, 'USB 32GB',         'Litware', 'Caja', 'Negro', FALSE, 7, 10, 25.00, 'Unidad', 18.50),
(2, 1002, 'Cuaderno A4 x100', 'Northwind', 'Caja', 'Azul', FALSE, 5, 20, 8.00,  'Unidad', 5.20);

INSERT INTO Proveedor
(ID_Proveedor_DWH, ID_Proveedor_T, Nombre, Categoria, Contacto_principal, Dias_pago, Codigo_postal) VALUES
(10, 5001, 'Litware Inc',   'Electronica', 'Ana Ruiz',  30, 110111),
(20, 5002, 'Northwind Ltd', 'Papeleria',   'Luis Pena', 45, 220222);

INSERT INTO Cliente
(ID_Cliente_DWH, ID_Cliente_T, Nombre, ClienteFactura, ID_CiudadEntrega_DWH,
 LimiteCredito, FechaAperturaCuenta, DiasPago, NombreGrupoCompra, NombreCategoria) VALUES
(100, 9001, 'Tailspin Toys',  'Tailspin Toys (Head Office)', 501, 50000.00, '2024-03-10', 30, 'Tailspin Toys', 'Novelty Shop'),
(200, 9002, 'Wingtip Store',  'Wingtip Toys (Head Office)',  502, 30000.00, '2025-06-01', 45, 'Wingtip Toys',  'Gift Store');

INSERT INTO TipoTransaccion
(ID_Tipo_transaccion_DWH, ID_Tipo_transaccion_T, Tipo) VALUES
(1, 10, 'Entrada'),
(2, 20, 'Salida');

INSERT INTO Hecho_Movimiento
(ID_Fecha, ID_Producto_DWH, ID_Proveedor_DWH, ID_Cliente_DWH, ID_Tipo_transaccion_DWH, Cantidad) VALUES
(20260115, 1, 10, 100, 1, 50),
(20260115, 2, 20, 200, 2, 30),
(20260220, 1, 10, 200, 2, 75),
(20260220, 2, 20, 100, 1, 40);

SELECT
    c.Nombre  AS Cliente,
    pr.Nombre AS Proveedor,
    tt.Tipo   AS Tipo_Transaccion,
    SUM(m.Cantidad) AS Productos_Movidos
FROM Hecho_Movimiento m
    JOIN Cliente          c  ON m.ID_Cliente_DWH          = c.ID_Cliente_DWH
    JOIN Proveedor        pr ON m.ID_Proveedor_DWH        = pr.ID_Proveedor_DWH
    JOIN TipoTransaccion  tt ON m.ID_Tipo_transaccion_DWH = tt.ID_Tipo_transaccion_DWH
    JOIN Fecha            f  ON m.ID_Fecha                = f.ID_Fecha
WHERE f.Fecha BETWEEN '2026-01-01' AND '2026-03-31'
GROUP BY c.Nombre, pr.Nombre, tt.Tipo
ORDER BY Productos_Movidos DESC;
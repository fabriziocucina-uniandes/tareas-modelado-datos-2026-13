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
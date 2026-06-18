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
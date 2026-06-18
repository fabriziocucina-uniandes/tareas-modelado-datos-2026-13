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
USE henry_m3;

SELECT DISTINCT IdCliente
FROM cliente;

SELECT DISTINCT Fecha
FROM venta;

SELECT v.Fecha, (SUM(v.Precio * v.Cantidad) - SUM(c.Precio * c.Cantidad)) as Diferencia
FROM venta v
INNER JOIN compra c ON(v.Fecha=c.Fecha)
WHERE YEAR(v.Fecha) = 2016
GROUP BY MONTH(v.Fecha)
-- ORDER BY Diferencia DESC;
ORDER BY month(v.Fecha);

SELECT p.IdProducto, p.Producto, ROUND(AVG(v.Precio - c.Precio),2) AS Diferencia
FROM venta v
JOIN producto p ON (v.IdProducto = p.IdProducto)
JOIN compra c ON(p.IdProducto=c.IdProducto)
GROUP BY p.IdProducto, p.Producto
ORDER BY Diferencia DESC;





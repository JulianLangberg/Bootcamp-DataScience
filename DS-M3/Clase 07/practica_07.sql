use henry_m3;
SELECT COUNT(*)
FROM 
	(SELECT  v.Fecha,
			c.Nombre_y_Apellido,
			(v.Precio * v.Cantidad) as Venta
	FROM venta v
	LEFT JOIN cliente c ON(v.IdCliente = c.IdCliente)) v;

SELECT COUNT(*)
FROM 
	(SELECT  v.Fecha,
			c.Nombre_y_Apellido,
			(v.Precio * v.Cantidad) as Venta
	FROM venta v
	RIGHT JOIN cliente c ON(v.IdCliente = c.IdCliente)) v;
    
SELECT  v.Fecha,
		c.Nombre_y_Apellido,
		(v.Precio * v.Cantidad) as Venta
FROM cliente c
-- INNER JOIN venta v ON(v.IdCliente = c.IdCliente);
-- FROM cliente c
LEFT JOIN venta v ON(v.IdCliente = c.IdCliente);
-- FROM venta v
-- RIGHT JOIN cliente c ON(v.IdCliente = c.IdCliente);
    

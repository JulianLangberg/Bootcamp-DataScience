use henry_m3;

SELECT IdProducto, avg(Precio) as promedio, avg(Precio) + (3*stddev(Precio)) as maximo 
-- No es necesario
-- SELECT IdProducto, avg(Precio) as promedio, avg(Precio) - (3*stddev(Precio)) as minimo 
from venta
GROUP BY IdProducto;

SELECT v.*, o.promedio, o.maximo
FROM venta v
JOIN (SELECT	IdProducto,
				avg(Precio) as promedio,
                avg(Precio) + (3*stddev(Precio)) as maximo 
				from venta
                GROUP BY IdProducto) o
	ON (v.IdProducto = o.IdProducto)
WHERE v.Precio > o.maximo;
SELECT *
FROM venta
WHERE IdProducto = 42890;

SELECT v.*, o.promedio, o.maximo
FROM venta v
JOIN (SELECT	IdProducto,
				avg(Cantidad) as promedio,
                avg(Cantidad) + (3*stddev(Cantidad)) as maximo 
				from venta
                GROUP BY IdProducto) o
	ON (v.IdProducto = o.IdProducto)
WHERE v.Cantidad > o.maximo;
SELECT *
FROM venta
WHERE IdProducto = 42992;

INSERT into aux_venta
SELECT v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad,2
FROM venta v
JOIN (SELECT	IdProducto,
				avg(Cantidad) as promedio,
                avg(Cantidad) + (3*stddev(Cantidad)) as maximo 
				from venta
                GROUP BY IdProducto) v2
	ON (v.IdProducto = v2.IdProducto)
WHERE v.Cantidad > v2.maximo OR v.Cantidad < 0;

INSERT into aux_venta
SELECT v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad,3
FROM venta v
JOIN (SELECT	IdProducto,
				avg(Precio) as promedio,
                avg(Precio) + (3*stddev(Precio)) as maximo 
				from venta
                GROUP BY IdProducto) v2
	ON (v.IdProducto = v2.IdProducto)
WHERE v.Precio > v2.maximo OR v.Precio < 0;

ALTER TABLE venta ADD Outlier TINYINT NOT NULL DEFAULT 1 AFTER Cantidad;

UPDATE venta v
JOIN aux_venta a
ON (v.IdVenta = a.IdVenta AND a.Motivo IN (2,3))
SET v.Outlier = 0;

-- KPI: Margen de Ganancia por producto superior a 20%
SELECT 	venta.Producto, 
		venta.SumaVentas, 
        venta.CantidadVentas, 
        venta.SumaVentasOutliers,
        compra.SumaCompras, 
        compra.CantidadCompras,
        ((venta.SumaVentas / compra.SumaCompras - 1) * 100) as margen
FROM
	(SELECT 	p.Producto,
			SUM(v.Precio * v.Cantidad * v.Outlier) 	as 	SumaVentas,
			SUM(v.Outlier) 							as	CantidadVentas,
			SUM(v.Precio * v.Cantidad) 				as 	SumaVentasOutliers,
			COUNT(*) 								as	CantidadVentasOutliers
	FROM venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto
			AND YEAR(v.Fecha) = 2019)
	GROUP BY p.Producto) AS venta
JOIN
	(SELECT 	p.Producto,
			SUM(c.Precio * c.Cantidad) 				as SumaCompras,
			COUNT(*)								as CantidadCompras
	FROM compra c JOIN producto p
		ON (c.IdProducto = p.IdProducto
			AND YEAR(c.Fecha) = 2019)
	GROUP BY p.Producto) as compra
ON (venta.Producto = compra.Producto)
WHERE ((venta.SumaVentas / compra.SumaCompras - 1) * 100) > 20;
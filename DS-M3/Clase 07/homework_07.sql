use henry_m3;

-- 1. Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto 
-- junto al id del producto y su respectivo precio.

SELECT  DISTINCT
		c.IdCliente,
        c.Nombre_y_Apellido,
		v.IdProducto,
        v.Precio
FROM venta v
LEFT JOIN cliente c ON (v.idCliente = c.IdCliente);

-- 2. Obteber un listado de clientes con la cantidad de productos adquiridos,
-- incluyendo aquellos que nunca compraron algún producto.
-- SELECT ifnull(null, 0);

SELECT  c.IdCliente,
		c.Nombre_y_apellido,
        SUM(ifnull(v.Cantidad, 0)) AS cantidad_productos,
        SUM(v.Cantidad) AS cantidad_productos_null
FROM cliente c
LEFT JOIN venta v ON (v.IdCliente = c.IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido
ORDER BY SUM(ifnull(v.Cantidad, 0)) DESC;

-- 3. Obtener un listado de cual fue el volumen de compra (cantidad) por año de cada cliente.
SELECT  c.IdCliente,
		c.Nombre_y_apellido,
        YEAR(v.Fecha),
        COUNT(v.IdVenta) AS Total_Compras
FROM venta v
INNER JOIN cliente c ON(c.IdCliente = v.IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido, YEAR(v.Fecha)
ORDER BY YEAR(v.Fecha) DESC;

-- 4. Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto al id del producto,
-- la cantidad de productos adquiridos y el precio promedio.
SELECT  c.IdCliente,
		c.Nombre_y_Apellido,
        p.Producto,
        p.IdProducto,
        SUM(v.Cantidad) as Cantidad_Productos,
        ROUND(avg(v.Precio), 2) AS Precio_Promedio
FROM venta v
INNER JOIN producto p ON (v.IdProducto=p.IdProducto)
INNER JOIN cliente c ON (v.IdCliente=c.IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido, p.IdProducto, p.Producto
ORDER BY c.IdCliente;

-- 5. Cacular la cantidad de productos vendidos y la suma total de ventas para cada localidad,
-- presentar el análisis en un listado con el nombre de cada localidad.
-- SELECT Localidad from localidad GROUP BY Localidad having count(*) >1; -- Búsqueda de duplicados

SELECT  p.Provincia,
		l.localidad,
        SUM(v.Cantidad) AS Cantidad_Productos,
        SUM(v.Precio * v.Cantidad) AS Total_Ventas,
        COUNT(v.IdVenta) AS Volumen_Venta
FROM venta v
LEFT JOIN cliente c ON(v.IdCliente=c.IdCliente)
LEFT JOIN localidad l ON (l.IdLocalidad=c.IdLocalidad)
LEFT JOIN provincia p ON(l.IdProvincia=p.IdProvincia)
WHERE v.Outlier = 1
GROUP BY p.IdProvincia, p.Provincia, l.IdLocalidad, l.Localidad
ORDER BY p.Provincia, l.Localidad;

-- 6. Cacular la cantidad de productos vendidos y la suma total de ventas para cada provincia,
-- presentar el análisis en un listado con el nombre de cada provincia,
-- pero solo en aquellas donde la suma total de las ventas fue superior a $100.000.

SELECT  p.Provincia,
        SUM(v.Cantidad) AS Cantidad_Productos,
        SUM(v.Precio * v.Cantidad) AS Total_Ventas,
        COUNT(v.IdVenta) AS Volumen_Venta
FROM venta v
LEFT JOIN cliente c ON(v.IdCliente=c.IdCliente)
LEFT JOIN localidad l ON (l.IdLocalidad=c.IdLocalidad)
LEFT JOIN provincia p ON(l.IdProvincia=p.IdProvincia)
WHERE v.Outlier = 1
GROUP BY p.IdProvincia, p.Provincia
HAVING  Total_Ventas > 100000
ORDER BY p.Provincia;

-- 7. Obtener un listado de dos campos en donde por un lado se obtenga la cantidad de productos vendidos por rango etario
-- y las ventas totales en base a esta misma dimensión. El resultado debe obtenerse en un solo listado.

SELECT c.Rango_Etario,
        SUM(v.Cantidad) AS Cantidad_Productos,
        SUM(v.Precio * v.Cantidad) AS Total_Ventas
FROM venta v
INNER JOIN cliente c ON(v.IdCliente=c.IdCliente)
WHERE v.Outlier = 1
GROUP BY c.Rango_Etario
ORDER BY c.Rango_Etario;

-- 8. Obtener la cantidad de clientes por provincia.
SELECT  p.IdProvincia,
		p.Provincia,
        COUNT(c.IdCliente) AS Cantidad_Clientes
from provincia p
LEFT JOIN localidad l ON (p.IdProvincia = l.IdProvincia)
LEFT JOIN cliente c ON (l.IdLocalidad = c.IdLocalidad)
GROUP BY p.IdProvincia, p.Provincia
ORDER BY p.Provincia;



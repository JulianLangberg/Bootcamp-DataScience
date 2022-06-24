USE henry_checkpoint_m3;
-- 6
SELECT ven.anio, ven.IdSucursal, ven.Venta_Total, gas.Gasto_Total, ven.Venta_Total - gas.Gasto_Total AS Ganancia, s.Sucursal
FROM (	SELECT date_format(Fecha, '%Y') AS anio, IdSucursal, SUM(Precio * Cantidad) AS Venta_Total
		FROM venta
		GROUP BY anio, IdSucursal
		HAVING anio = 2020) ven
INNER JOIN 
	(	SELECT date_format(Fecha, '%Y') AS anio, IdSucursal, SUM(Monto) AS Gasto_Total
		FROM gasto
		GROUP BY anio, IdSucursal
		HAVING anio = 2020) gas
ON (Ven.IdSucursal = gas.IdSucursal)
INNER JOIN sucursal s
ON (ven.IdSucursal = s.IdSucursal)
ORDER BY Ganancia DESC
LIMIT 10;

-- 7
SELECT ven.anio, ven.IdProducto, ven.Venta_Total, com.Compra_Total, ven.Venta_Total - com.Compra_Total AS Ganancia, TP.TipoProducto
FROM (	SELECT date_format(Fecha, '%Y') AS anio, IdProducto, SUM(Precio * Cantidad) AS Venta_Total
		FROM venta
		GROUP BY anio, IdProducto
		HAVING anio = 2020) ven
INNER JOIN 
	(	SELECT date_format(Fecha, '%Y') AS anio, IdProducto, SUM(Precio * Cantidad) AS Compra_Total
		FROM compra
		GROUP BY anio, IdProducto
		HAVING anio = 2020) com
ON (ven.IdProducto = com.IdProducto)
INNER JOIN
	(	SELECT p.IdProducto, tp.TipoProducto
		FROM producto p
		INNER JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)) TP
ON (ven.IdProducto = TP.IdProducto)
ORDER BY Ganancia DESC
LIMIT 10;

-- 8
SELECT COUNT(sv.IdCliente) AS Visita, sv.IdCliente
FROM ( 	SELECT IdSucursal, IdCliente, Fecha
		FROM venta
        WHERE YEAR(Fecha) = 2020
        GROUP BY IdCliente,IdSucursal
) sv
GROUP BY sv.IdCliente
HAVING Visita = 1;
-- 9
SELECT (COUNT(co20.IdCliente) - COUNT(co19.IdCliente)) / COUNT(co20.IdCliente) AS Porcentaje
FROM (	SELECT date_format(Fecha, '%Y') AS anio, IdCliente
		FROM venta
		GROUP BY anio, IdCliente
		HAVING anio = 2020) co20
LEFT JOIN 
	(	SELECT date_format(Fecha, '%Y') AS anio, IdCliente
		FROM venta
		GROUP BY anio, IdCliente
		HAVING anio = 2019) co19
ON (co20.IdCliente = co19.IdCliente);

-- 10
SELECT COUNT(co20.IdCliente) / COUNT(co19.IdCliente) AS Porcentaje
FROM (	SELECT date_format(Fecha, '%Y') AS anio, IdCliente
		FROM venta
		GROUP BY anio, IdCliente
		HAVING anio = 2020) co20
RIGHT JOIN 
	(	SELECT date_format(Fecha, '%Y') AS anio, IdCliente
		FROM venta
		GROUP BY anio, IdCliente
		HAVING anio = 2019) co19
ON (co20.IdCliente = co19.IdCliente);

-- 11
SELECT	c.Fecha, c.IdCliente, COUNT(c.IdCliente) AS Cantidad, cv.Canal
FROM (	SELECT Fecha, IdCliente, IdCanal
		FROM venta
		WHERE YEAR(Fecha) BETWEEN 2019 AND 2020
		GROUP BY IdCliente, IdCanal) c
LEFT JOIN canal_venta cv
ON (c.IdCanal = cv.IdCanal)
GROUP BY c.IdCliente
HAVING Cantidad = 1 AND Canal = 'OnLine';

-- 12 (Revisar)
SELECT date_format(v.Fecha, '%Y') AS anio, v.IdCliente, cl.Provincia AS Provincia_Cliente, v.IdSucursal, su.Provincia AS Provincia_Sucursalv, SUM(v.Precio * v.Cantidad) AS Ganancia
FROM venta v
INNER JOIN (
			SELECT s.IdSucursal, l.Localidad, p.Provincia
			FROM sucursal s
			INNER JOIN localidad l
			ON (s.IdLocalidad = l.IdLocalidad)
			INNER JOIN provincia p
			ON (l.IdProvincia = p.IdProvincia)) su
ON (v.IdSucursal = su.IdSucursal)
INNER JOIN (
			SELECT c.IdCliente, l.Localidad, p.Provincia
			FROM cliente c
			INNER JOIN localidad l
			ON (c.IdLocalidad = l.IdLocalidad)
			INNER JOIN provincia p
			ON (l.IdProvincia = p.IdProvincia)
            WHERE Localidad NOT IN ('Sin Dato')) cl
ON (v.IdCliente = cl.IdCliente)
WHERE cl.Provincia != su.Provincia
GROUP BY v.IdSucursal,anio
HAVING anio = 2020;

-- 13
SELECT vt.mes, (POW((vt.Venta_Total20 - ct.Compra_Total20 - gt.Monto_Total20),2) - POW((vt.Venta_Total19 - ct.Compra_Total19 - gt.Monto_Total19),2)) / POW((vt.Venta_Total19 - ct.Compra_Total19 - gt.Monto_Total19),2) AS DIF
FROM (	SELECT v19.Mes, v19.Venta_Total19, v20.Venta_Total20
		FROM (	SELECT date_format(Fecha, '%m') AS Mes, SUM(Precio * Cantidad) AS Venta_Total19
				FROM venta
				WHERE YEAR(Fecha) = 2019
				GROUP BY Mes
				ORDER BY Mes) v19
		INNER JOIN
			(	SELECT date_format(Fecha, '%m') AS Mes, SUM(Precio * Cantidad) AS Venta_Total20
				FROM venta
				WHERE YEAR(Fecha) = 2020
				GROUP BY Mes
				ORDER BY Mes) v20
		ON (v19.Mes = v20.Mes)) vt
INNER JOIN
	(	SELECT c19.Mes, c19.Compra_Total19, c20.Compra_Total20
		FROM (	SELECT date_format(Fecha, '%m') AS Mes, SUM(Precio * Cantidad) AS Compra_Total19
				FROM compra
				WHERE YEAR(Fecha) = 2019
				GROUP BY Mes) c19
		INNER JOIN
			(	SELECT date_format(Fecha, '%m') AS Mes, SUM(Precio * Cantidad) AS Compra_Total20
				FROM compra
				WHERE YEAR(Fecha) = 2020
				GROUP BY Mes) c20
		ON (c19.Mes = c20.mes)) ct
ON (vt.mes = ct.mes)
INNER JOIN
	(	SELECT g19.Mes, g19.Monto_Total19, g20.Monto_Total20
		FROM (	SELECT date_format(Fecha, '%m') AS Mes, SUM(Monto) AS Monto_Total19
				FROM gasto
				WHERE YEAR(Fecha) = 2019
				GROUP BY Mes) g19
		INNER JOIN
			(	SELECT date_format(Fecha, '%m') AS Mes, SUM(Monto) AS Monto_Total20
				FROM gasto
				WHERE YEAR(Fecha) = 2020
				GROUP BY Mes) g20
		ON (g19.Mes = g20.mes)) gt
ON (vt.mes = gt.mes)
ORDER BY DIF DESC;

-- 14 (MAL)
DROP TABLE IF EXISTS porcentaje;
CREATE TABLE IF NOT EXISTS porcentaje (
	IdEmpleado		INT,
    IdSucursal		INT,
    Apellido_Nombre	VARCHAR(150),
    Sucursal		VARCHAR(150),
    Anio			INT,
    Mes				INT,
    Porcentaje		INT
);

LOAD DATA
LOCAL INFILE 'C:/Users/sebastian/OneDrive/Escritorio/Data Science/Curso/M3/Files CP M3/p/Comisiones-Cordoba-Quiroz.csv'
INTO TABLE porcentaje
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


SELECT *
FROM cliente
WHERE IdCliente IN
	(SELECT DISTINCT IdCliente
    FROM venta);

use henry;

SELECT idAlumno, fechaIngreso
FROM alumno
WHERE fechaIngreso = (SELECT MIN(fechaIngreso) AS fecha
                        FROM alumno);
                        
use henry_m3;
ALTER VIEW cliente_venta AS
SELECT *
FROM cliente
WHERE IdCliente IN
	(SELECT DISTINCT IdCliente
    FROM venta)
LIMIT 10;

SELECT v.Fecha, v.IdCanal
FROM venta v
JOIN cliente_venta cv ON (v.IdCliente = cv.IdCliente);

SELECT	v.IdSucursal * 100000000 + c.IdFecha
FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
WHERE v.Outlier = 1;



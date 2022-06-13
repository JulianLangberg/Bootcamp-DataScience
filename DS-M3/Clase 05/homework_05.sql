use henry_m3;
-- Creamos la tabla que auditará a los usuarios que realizan cambios
DROP TABLE IF EXISTS `fact_venta_auditoria`;
CREATE TABLE IF NOT EXISTS `fact_venta_auditoria` (
	`Fecha`				DATE,
	`Fecha_Entrega`		DATE,
  	`IdCanal` 			INTEGER,
  	`IdCliente` 		INTEGER,
  	`IdEmpleado` 		INTEGER,
  	`IdProducto` 		INTEGER,
    `usuario` 			VARCHAR(20),
    `fechaModificacion` 	DATETIME
);
CREATE TRIGGER fact_venta_auditoria AFTER INSERT on fact_venta
FOR EACH ROW
INSERT INTO fact_venta_auditoria (Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, usuario, fechaModificacion)
VALUES (NEW.fecha, NEW.Fecha_Entrega, NEW.IdCanal, NEW.IdCliente, NEW.IdEmpleado, NEW.IdProducto, CURRENT_USER, now());

-- SELECT CURRENT_USER, now();
-- TRUNCATE TABLE fact_venta;

INSERT INTO fact_venta
SELECT IdVenta,Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
from venta
LIMIT 30;

-- Creamos la tabla que llevara una cuenta de los registros.
DROP TABLE IF EXISTS `fact_venta_registros`;
CREATE TABLE IF NOT EXISTS `fact_venta_registros` (
  	id 	INT NOT NULL AUTO_INCREMENT,
	cantidadRegistros INT,
	usuario VARCHAR (20),
	fecha DATETIME,
	PRIMARY KEY (id)
);

DROP TRIGGER fact_venta_registros;
CREATE TRIGGER fact_venta_registros AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_registros (cantidadRegistros, usuario, fecha)
VALUES ((SELECT COUNT(*) FROM fact_venta), CURRENT_USER, NOW());

-- Creamos una tabla donde podremos almacenar la cantidad de registros por día
DROP TABLE registros_tablas;
CREATE TABLE registros_tablas (
id INT NOT NULL AUTO_INCREMENT,
tabla VARCHAR(30),
fecha DATETIME,
cantidadRegistros INT,
PRIMARY KEY (id)
);

INSERT INTO registros_tablas (tabla, fecha, cantidadRegistros)
SELECT 'venta', NOw(), count(*)
from venta;

INSERT INTO registros_tablas (tabla, fecha, cantidadRegistros)
SELECT 'gasto', NOw(), count(*)
from gasto;

-- Creamos una tabla para auditar cambios
DROP TABLE IF EXISTS `fact_venta_cambios`;
CREATE TABLE IF NOT EXISTS `fact_venta_cambios` (
  	`Fecha` 			DATE,
  	`IdCliente` 		INTEGER,
  	`IdProducto` 		INTEGER,
    `Precio` 			DECIMAL(15,3),
    `Cantidad` 			INTEGER,
    `usuario` 			VARCHAR(20),
    `fechaModificacion` 	DATETIME
);

DROP TRIGGER control_actualizacion;
CREATE TRIGGER control_actualizacion AFTER UPDATE ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_cambios
VALUES(OLD.Fecha, OLD.IdCliente, OLD.IdProducto, OLD.Precio, OLD.Cantidad, current_user, NOW());

UPDATE fact_venta
SET Precio = 2915
WHERE IdVenta = 7;

 
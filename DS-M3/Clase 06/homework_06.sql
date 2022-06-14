USE henry_m3;

DROP PROCEDURE listaProductos;
DELIMITER $$
CREATE PROCEDURE listaProductos (IN fechaVenta DATE)
BEGIN
	SELECT DISTINCT p.Producto
    FROM venta v
    JOIN producto p ON (v.IdProducto = p.IdProducto AND v.Fecha = fechaVenta);
END $$
DELIMITER ;

CALL listaProductos('2018-03-09');

DROP FUNCTION margenBruto;
DELIMITER $$
CREATE FUNCTION margenBruto(precio DECIMAL(15,3), margen DECIMAL(9,2)) RETURNS DECIMAL (15,3)
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE margenBruto DECIMAL(15,3);
    SET margenBruto = precio * margen;
    RETURN margenBruto;
END $$
DELIMITER ;

SELECT margenBruto(110.5, 1.2);

SELECT c.Fecha,
		pr.Nombre as Proveedor,
        p.Producto,
        c.Precio as PrecioCompra,
        margenBruto(c.Precio, 1.2) as Margen
FROM compra c
JOIN producto p ON(c.IdProducto = p.IdProducto)
JOIN proveedor pr ON(c.IdProveedor=pr.IdProveedor);

-- 3. Obtner un listado de productos de IMPRESION y utilizarlo para cálcular el valor nominal de un margen bruto del 20% de cada uno de los productos.

SELECT p.IdProducto,
	   p.Producto,
       p.Precio,
	   margenBruto(p.Precio, 1.2) as Margen
FROM producto p
JOIN tipo_producto tp ON(p.IdTipoProducto = tp.IdTipoProducto AND TipoProducto = 'Impresión');

-- 4. Crear un procedimiento que permita listar los productos vendidos desde fact_venta a partir de un "Tipo" que determine el usuario.
DROP PROCEDURE listaCategoria;
DELIMITER $$
CREATE PROCEDURE listaCategoria(IN categoria VARCHAR (30))
BEGIN
	SELECT  v.Fecha,
			v.Fecha_Entrega,
            v.IdCliente,
            v.IdSucursal,
            p.Producto,
            v.Precio,
            v.Cantidad
	FROM venta v
    JOIN producto p ON (v.IdProducto = p.IdProducto AND v.Outlier=1)
    JOIN tipo_producto tp ON (p.IdTipoProducto = tp.IdTipoProducto
    AND TipoProducto collate utf8mb4_spanish_ci = categoria);
END $$
DELIMITER ;
CALL listaCategoria('Limpieza');

-- 7. Crear una variable que se pase como valor para realizar una filtro sobre Rango_etario en una consulta génerica a dim_cliente.
SELECT DISTINCT Rango_Etario FROM cliente;
SET @grupo_etario = '4_De 51 a 60 años';
SELECT *
FROM cliente
WHERE Rango_Etario collate utf8mb4_spanish_ci = @grupo_etario;

-- 5 y 6 (Recuerden ver el tema de los triggers para que no se cuelgue)
DROP PROCEDURE cargarFact_venta;

DELIMITER $$
CREATE PROCEDURE cargarFact_venta()
BEGIN
	TRUNCATE table fact_venta;

    INSERT INTO fact_venta (IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad)
    SELECT	IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
    FROM 	venta
    WHERE  	Outlier = 1;
END $$
DELIMITER ;

CALL cargarFact_venta();


SELECT 	c.Rango_Etario, 
		sum(v.Precio*v.Cantidad) 	AS Total_Ventas
FROM fact_venta v
	INNER JOIN dim_cliente c
		ON (v.IdCliente = c.IdCliente
			and c.Rango_Etario collate utf8mb4_spanish_ci = '2_De 31 a 40 años')
GROUP BY c.Rango_Etario;
    
DROP PROCEDURE ventasGrupoEtario; 

DELIMITER $$
CREATE PROCEDURE ventasGrupoEtario(IN grupo VARCHAR(25))
BEGIN
	SELECT 	c.Rango_Etario, 
			sum(v.Precio*v.Cantidad) 	AS Total_Ventas
	FROM fact_venta v
		INNER JOIN dim_cliente c
			ON (v.IdCliente = c.IdCliente
				and c.Rango_Etario collate utf8mb4_spanish_ci like Concat('%', grupo, '%'))
	GROUP BY c.Rango_Etario;
END $$
DELIMITER ;

SELECT DISTINCT Rango_Etario FROM dim_cliente;

CALL ventasGrupoEtario('31%40');

    
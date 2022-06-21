## ejercicio 7

select p.IdTipoProducto, 
		sum(v.Precio * v.Cantidad) AS SumaVentas
    FROM venta v 
    Join producto p 
    ON (v.IdProducto = p.IdProducto
	AND YEAR(v.Fecha) = 2020)
    group by IdTipoProducto;
    
    
   # compras IdTipoProducto  
    select p.IdTipoProducto, 
			sum(c.Precio * c.Cantidad) AS SumaCompras 
    from compra c 
    JOIN producto p 
    ON (c.IdProducto = p.IdProducto
	AND YEAR(c.Fecha) = 2020)
    group by IdTipoProducto;
    
    # ventas IdTipoProducto
    select p.IdTipoProducto, 
			sum(v.Precio * v.Cantidad) AS SumaVentas
    FROM venta v Join producto p 
    ON (v.IdProducto = p.IdProducto
			AND YEAR(v.Fecha) = 2020)
	GROUP BY p.IdTipoProducto;
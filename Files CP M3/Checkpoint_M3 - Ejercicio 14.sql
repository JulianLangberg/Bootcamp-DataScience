## 1)
Select	cl.Rango_Etario,
		   tp.TipoProducto,
        sum(v.Precio * v.Cantidad) as Venta
from 	venta v Join cliente cl
		On (v.IdCliente = cl.IdCliente)
	Join producto p
		On (v.IdProducto = p.IdProducto)
	Join tipo_producto tp
		On (p.IdTipoProducto = tp.IdTipoProducto)
	Join canal_venta cp
		On (cp.IdCanal = v.IdCanal)
	Join sucursal s
		On (s.IdSucursal = v.IdSucursal)
	Join localidad lo
		On (s.IdLocalidad = lo.IdLocalidad)
	Join provincia pr
		On (lo.IdProvincia = pr.IdProvincia)
Where 	Year(v.Fecha) = 2020
		   And Month(v.Fecha) >= 6
		   And cp.Canal = 'OnLine'
         And pr.Provincia = 'Buenos Aires'
         And TipoProducto In ('Estucheria','Informatica','Impresión','Audio')
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc;

## opcion 2

Select	cl.Rango_Etario,
		tp.TipoProducto,
        sum(v.Precio * v.Cantidad) as Venta
from 	venta v Join cliente cl
		On (v.IdCliente = cl.IdCliente
			And Year(v.Fecha) = 2020
            And Month(v.Fecha) >= 6)
	Join producto p
		On (v.IdProducto = p.IdProducto)
	Join tipo_producto tp
		On (p.IdTipoProducto = tp.IdTipoProducto
			And TipoProducto In ('Estucheria','Informatica','Impresión','Audio'))
	Join canal_venta cp
		On (cp.IdCanal = v.IdCanal
			And cp.Canal = 'OnLine')
	Join sucursal s
		On (s.IdSucursal = v.IdSucursal)
	Join localidad lo
		On (s.IdLocalidad = lo.IdLocalidad)
	Join provincia pr
		On (lo.IdProvincia = pr.IdProvincia
			And pr.Provincia = 'Buenos Aires')
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc;
        
## opcin 3
Select	cl.Rango_Etario,
		   tp.TipoProducto,
        sum(v.Precio * v.Cantidad) as Venta
from 	venta v Join cliente cl
		On (v.IdCliente = cl.IdCliente
			And Year(v.Fecha) = 2020
         And Month(v.Fecha) >= 6)
	Join producto p
		On (v.IdProducto = p.IdProducto)
	Join tipo_producto tp
		On (p.IdTipoProducto = tp.IdTipoProducto
			And TipoProducto In ('Estucheria','Informatica','Impresión','Audio'))
	Join canal_venta cp
		On (cp.IdCanal = v.IdCanal
			And cp.Canal = 'OnLine')
	Join sucursal s
		On (s.IdSucursal = v.IdSucursal)
	Join localidad lo
		On (cl.IdLocalidad = lo.IdLocalidad)
	Join provincia pr
		On (lo.IdProvincia = pr.IdProvincia
			And pr.Provincia = 'Buenos Aires')
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc;        

# 16) ¿Cuál es el código de empleado del empleado que mayor comisión obtuvo en diciembre del año 2020?
ALTER TABLE comisiones_cordoba_total
ADD `IdEmpleado` int NOT NULL;
Update comisiones_cordoba_total SET `IdEmpleado`=  CodigoEmpleado + (IdSucursal*1000000);


select v.IdEmpleado, (v.Precio*v.Cantidad) as Ventas, (v.Precio*v.Cantidad)*comision.Porcentaje/100 as Comision from venta v
Join (SELECT c.IdEmpleado, c.Porcentaje FROM comisiones_cordoba_total c
	where Anio = 2020 and Mes = 12) as comision
	on (v.IdEmpleado = comision.IdEmpleado)
where DATE_FORMAT( Fecha,'%Y%m')= 202012
Group by v.IdEmpleado
order by Comision DESC
;
#limit 1;


# 17) ¿Cuál es la sucursal que menos comisión pagó en el año 2020?
select v.IdSucursal, v.IdEmpleado, (v.Precio*v.Cantidad) as Ventas, (v.Precio*v.Cantidad)*comision.Porcentaje/100 as Comision from venta v
Join (SELECT c.IdEmpleado, c.Porcentaje FROM comisiones_cordoba_total c
	where Anio = 2020) as comision
	on (v.IdEmpleado = comision.IdEmpleado)
where DATE_FORMAT( Fecha,'%Y%m')= 202012
Group by v.IdEmpleado, v.IdSucursal
order by Comision DESC;


### borrado

select v.IdSucursal, v.IdEmpleado, MONTH(Fecha),(v.Precio*v.Cantidad) as Ventas, comision.Porcentaje 
from venta v 
JOIN (SELECT IdSucursal, IdEmpleado,Mes, Porcentaje FROM henry_checkpoint_m3.comisiones_cordoba_total
where Anio = 2020) as comision
ON (v.IdSucursal = comision.IdSucursal)
where YEAR(Fecha)= 2020
Group by v.IdEmpleado, v.IdSucursal
order by IdSucursal,IdEmpleado,MONTH(Fecha);

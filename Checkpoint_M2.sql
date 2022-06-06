# 6) ¿Cuál es el canal id del Producto cuyo nombre es EPSON COPYFAX 2000 ?
use checkpoint_m2;
select IDProducto from producto where Concepto = 'EPSON COPYFAX 2000';

#7) ¿Cuál es el canal de ventas con menor cantidad de ventas registradas?

select  v.IdCanal,c.Canal, sum(v.Cantidad*v.precio) as Cantidad_Ventas from venta v, canal_venta c
where c.IdCanal=v.IdCanal
group by IdCanal
order by Cantidad_Ventas ASC;
#Limit 1;

# 8) Cual fue el mes con mayor venta de la sucursal 13 para el año 2015 ?
# Pista para agrupar por mes podes usar el DATE_FORMAT( date,'%Y%m') --> YYYYMM o DATE_FORMAT( date,'%m') --> MM
#
select v.IdSucursal,DATE_FORMAT(v.Fecha,'%Y') as AÑO, DATE_FORMAT(v.Fecha,'%m') as MES, sum(v.Precio * v.Cantidad) as Ventas_Totales
from venta v
where DATE_FORMAT(v.Fecha,'%y') = 15 AND v.IdSucursal = 13
group by DATE_FORMAT(v.Fecha,'%m')
order by Ventas_Totales DESC;

## 9) Se define el tiempo de entrega como el tiempo en días transcurrido entre que se realiza la compra y se efectua la entrega.
# Par analizar mejoras en el servicio, la dirección desea saber:
# cuál es el año con el promedio más alto de este tiempo de entrega. (Fecha = Fecha de venta; Fecha_Entrega = Fecha de entrega)
#avg(timestampdiff(day,v.Fecha,v.Fecha_Entrega))
select DATE_FORMAT(v.Fecha,'%Y'), avg(timestampdiff(day,v.Fecha,v.Fecha_Entrega)) as Tiempo_Entrega from venta v
group by DATE_FORMAT(v.Fecha,'%Y')
order by Tiempo_Entrega DESC;

### 10) La dirección desea saber que tipo de producto tiene la mayor venta en 2020 (Tabla 'producto', campo Tipo = Tipo de producto)
select distinct Tipo from producto;

select p.Tipo, sum(v.Precio * v.Cantidad) Cant_Ventas from producto p, venta v
where p.IDProducto = v.IdProducto AND DATE_FORMAT(v.Fecha,'%Y') = 2020
group by p.Tipo
order by Cant_Ventas DESC;

### 11) ¿Cuál es el año y mes con la mayor cantidad de productos vendidos?
## Informar la respuesta con 4 digitos para el año y 2 para el mes
## Por ejemplo 201506 seria Junio 2015
## Pista para agrupar por mes podes usar el   DATE_FORMAT( date,'%Y%m') --> YYYYMM o  DATE_FORMAT( date,'%m') --> MM
 
select DATE_FORMAT(v.Fecha,'%Y%m') as YYYYMM, count(v.Cantidad) as Cant_Productos_vendidos
from venta v
group by DATE_FORMAT(v.Fecha,'%Y%m')
order by Cant_Productos_vendidos DESC;

## 12) ¿Cuantos productos tienen la palabra DVD en alguna parte de su nombre/concepto? 
SELECT Concepto FROM producto
WHERE Concepto LIKE '%DVD%';

## 13) ¿Cual de estos tipos de producto, tiene la menor diferencia de precio entre sus minimos y maximos?
#   1- GABINETES	  
#   2- GAMING	  
#   3- IMPRESIÓN	

select Tipo,max(precio), min(precio), max(precio)-min(Precio) from producto
where Tipo = 'GABINETES';

select Tipo,max(precio), min(precio), max(precio)-min(Precio) from producto
where Tipo = 'GAMING';

select Tipo,max(precio), min(precio), max(precio)-min(Precio) from producto
where  Tipo = 'IMPRESIÓN';

## 14) Teniendo en cuenta que Fecha es la fecha real de compra, y Fecha_Entrega es la fecha real que se entrego el producto. ¿Cuantas ventas NO se entregaron el mismo mes en que fueron compradas?
## Ejemplo
## Venta |Fecha      | Fecha_Entrega
##  1    |2018-03-09 | 2018-03-25 --> Se entrego el mismo mes que fue hecha la venta
##  2    |2020-06-29 | 2020-07-01 --> No se entrego el mismo mes que la venta

select v.IdVenta, COUNT(CASE WHEN(month(v.Fecha_Entrega)-month(v.Fecha)) != 0 THEN 1 END) as Entrega_otro_mes from venta v;


select sum(timestampdiff(month,v.Fecha,v.Fecha_Entrega)) as Entrega_otro_mes from venta v;

## 15) Cual es el Id del empleado que mayor cantidad de productos vendio en toda la historia de las ventas?
select v.IdEmpleado, count(v.Cantidad) as Cant_Productos_vendidos
from venta v
group by v.IdEmpleado
order by Cant_Productos_vendidos DESC;



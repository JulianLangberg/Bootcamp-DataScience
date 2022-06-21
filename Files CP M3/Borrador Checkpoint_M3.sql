## 6) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = Venta - Gasto)
## ¿Cuál es la sucursal con mayor ganancia neta en 2020? *

SELECT YEAR(v.Fecha), v.IdSucursal, SUM(v.Precio * v.Cantidad) as Venta, 
SUM(g.Monto) as Gasto, (SUM(v.Precio * v.Cantidad) - sum(g.Monto)) as Ganancia
from venta v, gasto g
where  v.IdSucursal = g.IdSucursal AND YEAR(v.Fecha) = '2020'
GROUP BY Year(v.Fecha),v.IdSucursal,g.IdSucursal
order by Venta DESC;

SELECT YEAR(v.Fecha), v.IdSucursal, s.Sucursal, SUM(v.Precio * v.Cantidad) as Venta, 
SUM(g.Monto) as Gasto, (SUM(v.Precio * v.Cantidad) - sum(g.Monto)) as Ganancia
from venta v
Join gasto g on (v.IdSucursal = g.IdSucursal)
Join sucursal s on (v.IdSucursal = s.IdSucursal)
where YEAR(v.Fecha) = '2020'
GROUP BY Year(v.Fecha),v.IdSucursal,g.IdSucursal
order by Ganancia DESC;


##7) La ganancia neta por producto es las ventas menos las compras (Ganancia = Venta - Compra) 
## ¿Cuál es el tipo de producto con mayor ganancia neta en 2020? *

SELECT YEAR(v.Fecha),t.TipoProducto, t.IdTipoProducto, SUM(v.Precio * v.Cantidad) as Venta, 
SUM(p.Precio) as Compra, (SUM(v.Precio * v.Cantidad) - sum(p.Precio)) as Ganancia_Neta_Producto
from venta v
Join producto p on (p.IdProducto = v.IdProducto)
Join tipo_producto t on (p.IdTipoProducto = t.IdTipoProducto)
where YEAR(v.Fecha) = '2020'
GROUP BY Year(v.Fecha),v.IdProducto, p.IdTipoProducto
order by Ganancia_Neta_Producto DESC;

##7) La ganancia neta por producto es las ventas menos las compras (Ganancia = Venta - Compra) 
## ¿Cuál es el tipo de producto con mayor ganancia neta en 2020? *


## 8) Del total de clientes que realizaron compras en 2020 ¿Qué porcentaje lo hizo sólo en una única sucursal? *
select IdCliente, Cant_Suc 
from (select IdCliente, count(IdSucursal) as Cant_Suc
from venta
where year(Fecha) = '2020'
group by IdCliente) as venta
where Cant_Suc = 1;
 # 591 clientes que solo compraron en una sucursal
 #2415 clientes que compraron en 2020
 
 # 9) Del total de clientes que realizaron compras en 2020 ¿Qué porcentaje no había realizado compras en 2019? *
select count(venta2020.IdCliente)
from (select DISTINCT v1.IdCliente
		from venta v1
		where year(Fecha) = '2020') as venta2020
Left join (select DISTINCT v2.IdCliente
			from venta v2
			where year(Fecha) = '2019') as venta2019
on venta2020.IdCliente = venta2019.IdCliente
where venta2019.IdCliente IS NULL;
 #2415 compraron en 2020
#985 compraron en 2020 pero no en 2019
select DISTINCT v1.IdCliente
from venta v1
where year(Fecha) = '2020';

# 10) Del total de clientes que realizaron compras en 2019 ¿Qué porcentaje lo hizo también en 2020? *

select count(venta2020.IdCliente)
from (select DISTINCT v1.IdCliente
		from venta v1
		where year(Fecha) = '2020') as venta2020
inner join (select DISTINCT v2.IdCliente
			from venta v2
			where year(Fecha) = '2019') as venta2019
on venta2020.IdCliente = venta2019.IdCliente;

#1430 idClientes hicieron compras tanto en 2019 como 2020.

# 11) ¿Qué cantidad de clientes realizó compras sólo por el canal OnLine entre 2019 y 2020? *

select count(venta1.IdCliente), venta1.IdCanal
from (select distinct IdCliente, IdCanal from venta
		where IdCanal = '2') as venta1
left join (select distinct IdCliente, IdCanal, YEAR(fecha) from venta
		where IdCanal != 2) as venta2
        on venta1.IdCliente = venta2.IdCliente
where venta2.IdCliente IS NULL;
 
Select distinct IdCliente, IdCanal, YEAR(fecha) from venta
order by IdCliente;


        

select  count(distinct IdCliente), IdCanal, YEAR(fecha) from venta
where YEAR(Fecha) = 2020;
        
#564 compraron solo online
# 2659 compraron en 2019 y 2020
# 2415 comprarn en 2020


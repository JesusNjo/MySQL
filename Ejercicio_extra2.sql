use jardineria;

SELECT * from cliente;
SELECT * from detalle_pedido;
SELECT * from empleado;
SELECT * from gama_producto;
SELECT * from oficina;
SELECT * from pago;
SELECT * from pedido;
SELECT * from producto;

-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina,ciudad from oficina;
-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad,telefono from oficina where pais like 'España';
-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1,apellido2,codigo_jefe from empleado where codigo_jefe = 7;
-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto,nombre,concat(apellido1, ' ',apellido2)as apellidos, email from empleado where codigo_jefe is null;
SELECT puesto,nombre,concat(apellido1,' ',apellido2)as apellidos, email from empleado where puesto like 'Director general';
-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT nombre,concat(apellido1,' ',apellido2)as apellidos, puesto from empleado where puesto not like 'Representante Ventas';
-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT nombre_cliente from cliente where pais like 'spain';
-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT estado from pedido group by estado;
/*8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago
en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
repetidos. Resuelva la consulta:
o Utilizando la función YEAR de MySQL.
o Utilizando la función DATE_FORMAT de MySQL.
o Sin utilizar ninguna de las funciones anteriores.*/
SELECT codigo_cliente,fecha_pago from pago where YEAR(fecha_pago) = 2008;
SELECT codigo_cliente,fecha_pago from pago where DATE_FORMAT(fecha_pago, '%Y') = 2008;
SELECT codigo_cliente,fecha_pago from pago where fecha_pago like '%2008%';
/*9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y 
fecha de entrega de los pedidos que no han sido entregados a tiempo.*/
SELECT codigo_pedido,codigo_cliente,fecha_esperada,fecha_entrega,datediff(fecha_entrega,fecha_esperada) as 'dias de diferencia' from pedido where fecha_esperada<fecha_entrega;
/*10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
esperada.
o Utilizando la función ADDDATE de MySQL.
o Utilizando la función DATEDIFF de MySQL.*/
SELECT codigo_pedido,codigo_cliente,fecha_esperada,fecha_entrega,datediff(fecha_entrega,fecha_esperada) as 'dias de diferencia' from pedido where datediff(fecha_entrega,fecha_esperada)>= 2;
SELECT codigo_pedido,codigo_cliente,fecha_esperada,fecha_entrega from pedido where fecha_entrega> adddate(fecha_esperada, interval 2 day);
-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT estado,fecha_esperada from pedido where estado like 'rechazado' and DATE_FORMAT(fecha_esperada, '%Y') = 2009;
SELECT * from pedido where estado like 'Rechazado' and YEAR(fecha_esperada) = '2009' order by codigo_cliente asc;
-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT *,date_format(fecha_entrega, '%M') as mes from pedido where month(fecha_entrega) =01;
/* 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008
 mediante Paypal. Ordene el resultado de mayor a menor.*/
 SELECT * from pago where forma_pago like 'Paypal' and YEAR(fecha_pago) = 2008 order by total asc;
 /*14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
cuenta que no deben aparecer formas de pago repetidas.*/
SELECT forma_pago from pago group by forma_pago;
/*15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de
venta, mostrando en primer lugar los de mayor precio.*/
SELECT * from producto where gama like 'ornamentales' and cantidad_en_stock >100 order by precio_venta desc;
/*16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
representante de ventas tenga el código de empleado 11 o 30.*/
SELECT * from cliente where ciudad like 'madrid' and codigo_empleado_rep_ventas = 11 or codigo_empleado_rep_ventas = 30;


-- Consultas multitabla (Composición interna) Las consultas se deben resolver con INNER JOIN.

-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT c.nombre_cliente as Nombre_cliente, concat(e.nombre, ' ',e.apellido1)as Nombre_vendedor from cliente c inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado;
-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT c.nombre_cliente,e.nombre,p.id_transaccion from cliente c inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado inner join pago p where p.codigo_cliente = c.codigo_cliente;
/*3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de
sus representantes de ventas.*/
SELECT c.nombre_cliente,e.nombre as nombre_empleado from cliente c inner join empleado e on e.codigo_empleado=c.codigo_empleado_rep_ventas inner join pago p where c.codigo_cliente not in(SELECT codigo_cliente from pago) group by c.codigo_cliente;

/*4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.*/

SELECT c.nombre_cliente,e.nombre as nombre_empleado, o.ciudad from cliente c inner join empleado e on e.codigo_empleado = c.codigo_empleado_rep_ventas inner join oficina o on o.codigo_oficina = e.codigo_oficina where c.codigo_cliente in(select codigo_cliente from pago);

/*5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el representante.*/

SELECT c.nombre_cliente,e.nombre as nombre_empleado,o.ciudad from cliente c inner join empleado e on e.codigo_empleado = c.codigo_empleado_rep_ventas inner join oficina o on e.codigo_oficina = o.codigo_oficina where c.codigo_cliente not in(select codigo_cliente from pago);

-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

SELECT o.linea_direccion1,o.linea_direccion2,c.nombre_cliente from cliente c inner join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado inner join oficina o on e.codigo_oficina = o.codigo_oficina where c.ciudad = 'Fuenlabrada';

/*7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad
de la oficina a la que pertenece el representante.*/

SELECT c.nombre_cliente,e.nombre as empleado, o.ciudad from cliente c join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado inner join oficina o on o.codigo_oficina = e.codigo_oficina;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

SELECT e.nombre as empleado,j.nombre as jefe from empleado e inner join empleado j on e.codigo_empleado = j.codigo_jefe;

-- 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

SELECT c.nombre_cliente, p.fecha_esperada,p.fecha_entrega,datediff(fecha_entrega,fecha_esperada) as diasDif from cliente c inner join pedido p on c.codigo_cliente = p.codigo_cliente where fecha_entrega > fecha_esperada;

-- 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

SELECT c.nombre_cliente, group_concat(distinct p.gama) as compras from cliente c inner join pedido pe on c.codigo_cliente = pe.codigo_cliente join detalle_pedido d on c.codigo_cliente = pe.codigo_cliente join producto p on d.codigo_producto = p.codigo_producto group by c.nombre_cliente;

/*Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.*/
SELECT * from cliente;
SELECT * from detalle_pedido;
SELECT * from empleado;
SELECT * from gama_producto;
SELECT * from oficina;
SELECT * from pago;
SELECT * from pedido;
SELECT * from producto;
SELECT * from producto,pedido,pago,oficina,gama_producto,empleado,detalle_pedido,cliente;
SELECT * from producto,cliente,detalle_pedido,empleado,gama_producto,oficina,pago,pedido;
-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

SELECT c.* from cliente c left join pago p on c.codigo_cliente = p.codigo_cliente where p.codigo_cliente is null;

-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

SELECT c.nombre_cliente from pedido p right join cliente c on c.codigo_cliente = p.codigo_cliente where p.codigo_pedido is null;

 
 -- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

SELECT c.* from cliente c left join pago p on c.codigo_cliente = p.codigo_cliente left join pedido pe on c.codigo_cliente = pe.codigo_cliente where p.codigo_cliente is null and pe.codigo_pedido is null;

-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

SELECT e.* from empleado e left join oficina o on e.codigo_oficina = o.codigo_oficina where e.codigo_oficina is null;

-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

SELECT e.* from empleado e left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas where c.codigo_empleado_rep_ventas is null;

/*6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los
que no tienen un cliente asociado.*/

SELECT e.* from empleado e left join oficina o on e.codigo_oficina = o.codigo_oficina left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas where e.codigo_oficina is null and c.codigo_empleado_rep_ventas is null;

-- 7. Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT p.* from producto p left join detalle_pedido d on p.codigo_producto = d.codigo_producto left join pedido x on d.codigo_pedido = x.codigo_pedido where x.codigo_pedido is null;

/*8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
representantes de ventas de algún cliente que haya realizado la compra de algún producto
de la gama Frutales.*/

SELECT o.codigo_oficina from oficina o join empleado e on o.codigo_oficina = e.codigo_oficina join cliente c on c.codigo_empleado_rep_ventas != e.codigo_empleado join pedido p on c.codigo_cliente = p.codigo_cliente join detalle_pedido dp on p.codigo_pedido = dp.codigo_pedido join producto pr on pr.codigo_producto = dp.codigo_producto where pr.gama like 'frutales';
SELECT o.codigo_oficina from oficina o where o.codigo_oficina not in (SELECT e.codigo_oficina from empleado e where e.codigo_empleado in (SELECT c.codigo_empleado_rep_ventas from cliente c join pedido p on c.codigo_cliente = p.codigo_cliente join detalle_pedido dp on p.codigo_pedido = dp.codigo_pedido join producto pr on pr.codigo_producto = dp.codigo_producto where pr.gama like 'Frutales'));
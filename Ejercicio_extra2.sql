use jardineria;

SELECT * from cliente;
SELECT * from detalle_pedido;
SELECT * from empleado;
SELECT * from gama_producto;
SELECT * from oficina;
SELECT * from pago;
SELECT * from pedido;
SELECT * from producto;

SELECT codigo_oficina,ciudad from oficina;-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT ciudad,telefono from oficina where pais like 'España';-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT nombre,apellido1,apellido2,email from empleado where codigo_jefe = 7;-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT puesto,nombre,apellido1,apellido2,email from empleado where puesto = 'Director general';-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT nombre,apellido1,apellido2,puesto from empleado where puesto != 'Representante ventas';-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT e.nombre as nombre_empleado,c.nombre_cliente from empleado e inner join cliente c on e.codigo_empleado = c.codigo_cliente where c.pais like 'Spain' group by e.codigo_empleado;-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
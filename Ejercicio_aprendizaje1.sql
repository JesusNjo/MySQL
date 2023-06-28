SELECT * FROM personal.empleados;


use personal;
SELECT * FROM empleados; -- Obtener los datos completos de los empleados. 
SELECT * FROM departamentos; -- Obtener los datos completos de los departamentos.
SELECT nombre_depto from departamentos; -- Listar el nombre de los departamentos.
SELECT nombre,sal_emp as salario from empleados; -- Obtener el nombre y salario de todos los empleados.
SELECT comision_emp as comisiones from empleados;-- Listar todas las comisiones.
SELECT cargo_emp as secretarias from empleados where cargo_emp = 'Secretaria';-- Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT nombre,cargo_emp as vendedores FROM empleados where cargo_emp like 'vendedor' order by nombre asc; -- Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT nombre,cargo_emp,sal_emp from empleados order by sal_emp desc;-- Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT nombre_jefe_depto,ciudad from departamentos where ciudad like 'ciudad real'; -- Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad de “Ciudad Real”
SELECT nombre as Nombre,cargo_emp as Cargo from empleados;-- Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
SELECT nombre,sal_emp,comision_emp from empleados where id_depto = 2000 order by comision_emp desc;-- Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT nombre,(sal_emp + comision_emp+500) as saldoTotal from empleados where id_depto = 3000 order by nombre asc;-- Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del empleado y el total a pagar, en orden alfabético.
SELECT nombre from empleados where nombre like 'j%'; -- Muestra los empleados cuyo nombre empiece con la letra J.
SELECT sal_emp,comision_emp,(sal_emp+comision_emp) as salarioTotal,nombre from empleados where comision_emp > 1000;-- Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que tienen comisión superior a 1000.
SELECT sal_emp,comision_emp,(sal_emp+comision_emp) as salarioTotal,nombre from empleados where comision_emp = 0; -- Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT sal_emp,comision_emp from empleados where sal_emp<comision_emp;-- Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT comision_emp from empleados where comision_emp < (sal_emp*0.30); -- Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT * from empleados where nombre not like 'MA%';-- Hallar los empleados cuyo nombre no contiene la cadena “MA”

SELECT * from empleados where cargo_emp like 'vendedor' or cargo_emp like 'investigador' or cargo_emp like 'mecanico' order by cargo_emp asc;-- Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o ‘Mantenimiento.
select nombre_depto from departamentos where nombre_depto not in ("Ventas","Investigación","Mantenimiento");

SELECT * from empleados where cargo_emp NOT like 'vendedor' AND cargo_emp NOT like 'investigador' AND cargo_emp NOT like 'mecanico' order by cargo_emp asc;-- Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento.
SELECT max(sal_emp) from empleados;-- Mostrar el  salario más alto de la empresa.
SELECT * FROM empleados WHERE sal_emp = (SELECT MAX(sal_emp) from empleados);
SELECT * FROM empleados ORDER BY nombre DESC LIMIT 1; -- Mostrar el nombre del último empleado de la lista por orden alfabético.

SELECT max(sal_emp) as salarioMax,min(sal_emp) as salarioMin, max(sal_emp) - min(sal_emp) as diferencia from empleados; -- Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT d.nombre_depto, round(AVG(e.sal_emp)) as salarioPromedio from departamentos d JOIN empleados e ON d.id_depto = e.id_depto group by d.nombre_depto; -- Hallar el salario promedio por departamento.
SELECT COUNT(id_depto),cargo_emp from empleados group by cargo_emp having count(id_depto) >3;-- Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
SELECT COUNT(id_depto),cargo_emp from empleados group by cargo_emp having count(id_depto) =null;-- Hallar los departamentos que no tienen empleados
SELECT e.nombre,d.nombre_jefe_depto from empleados e inner join departamentos d on e.id_depto = d.id_depto; -- Mostrar la lista de empleados, con su respectivo departamento y el jefe de cada departamento.
select nombre, empleados.id_depto,nombre_jefe_depto from empleados inner join departamentos on empleados.id_depto = departamentos.id_depto;

SELECT nombre,sal_emp,id_depto from empleados e where e.sal_emp >= (select avg(sal_emp) from empleados) order by e.id_depto;-- Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
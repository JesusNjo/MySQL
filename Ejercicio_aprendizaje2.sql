SELECT * FROM tienda.producto;
SELECT * FROM tienda.fabricante;

SELECT nombre FROM producto;-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre,precio from producto;-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT * FROM producto;-- 3. Lista todas las columnas de la tabla producto.
SELECT nombre,round(precio) from producto;-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT codigo_fabricante from producto;-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT DISTINCT codigo_fabricante FROM producto;-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT codigo_fabricante from producto group by codigo_fabricante;
SELECT nombre from fabricante order by nombre asc;-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre,precio from producto order by nombre asc, precio desc;-- 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT * from fabricante limit 5; -- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT nombre,precio from producto order by precio asc limit 1; -- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre,precio from producto order by precio desc limit 1; -- 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre,precio from producto where precio <= 120;-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT * from producto where precio between 60 and 200; -- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * from producto where codigo_fabricante in (1,3,5);-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * from producto where nombre like '%Portátil%';-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT p.codigo,p.nombre,f.codigo,f.nombre from producto p inner join fabricante f;-- 16. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT p.nombre as Nombre_Produc,p.precio as Precio_Produc, f.nombre as Nombre_Fabric from producto p join fabricante f order by f.nombre asc;-- 17. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre as Nombre_Produc,p.precio as Precio_Produc, f.nombre as Nombre_Fabric from producto p join fabricante f on p.codigo_fabricante = f.codigo order by p.precio asc limit 1;-- 18. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT * from producto p join fabricante f on p.codigo_fabricante = f.codigo where f.nombre like 'Lenovo';-- 19. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT * from producto p join fabricante f on p.codigo_fabricante = f.codigo where f.nombre like 'Crucial'and p.precio >200;-- 20. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT * from producto p join fabricante f on p.codigo_fabricante = f.codigo where f.nombre in('ASUS','Hewlett-Packard'); -- 21. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
SELECT p.nombre as Nombre_Produc,p.precio as Precio_Produc, f.nombre as Nombre_Fabric from producto p join fabricante f on p.codigo_fabricante = f.codigo where p.precio >180 order by p.precio desc, p.nombre asc;-- 22. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT * from fabricante f left join producto p on f.codigo = p.codigo_fabricante;-- 23. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
-- SELECT * FROM fabricante WHERE codigo NOT IN (SELECT DISTINCT codigo_fabricante FROM producto);
SELECT * from fabricante f left join producto p on f.codigo = p.codigo_fabricante where p.codigo_fabricante is null; -- 24. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT * from producto where codigo_fabricante in(select codigo from fabricante where nombre like 'Lenovo');-- 25. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * from producto p inner join fabricante f on p.codigo_fabricante = f.codigo where f.nombre like 'Lenovo' order by p.precio desc limit 1; -- 26. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT p.nombre,max(p.precio),f.nombre from producto p inner join fabricante f on p.codigo_fabricante = f.codigo where f.nombre like 'Lenovo';
SELECT * from producto p where codigo_fabricante in(select codigo from fabricante where nombre like 'ASUS') and p.precio > (SELECT avg(precio) from producto);-- 27. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT f.nombre from fabricante f left join producto p on f.codigo = p.codigo_fabricante where f.nombre not in(SELECT f.nombre from fabricante f left join producto p on f.codigo = p.codigo_fabricante where p.codigo_fabricante is null);-- 28. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT f.nombre from fabricante f left join producto p on f.codigo = p.codigo_fabricante where p.codigo_fabricante is null;

SELECT f.nombre from fabricante f left join producto p on f.codigo = p.codigo_fabricante where f.nombre in(SELECT f.nombre from fabricante f left join producto p on f.codigo = p.codigo_fabricante where p.codigo_fabricante is null);-- 29 Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT COUNT(*),f.nombre from fabricante f join producto p on f.codigo = p.codigo_fabricante group by f.nombre having COUNT(*) = (SELECT COUNT(*) from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo')) AND f.nombre != 'LENOVO';-- 30 Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
SELECT * from orders;
SELECT * FROM customers;
SELECT * from categories;
Select * from employees;
select * from orderdetails;
select * from products;
select * from suppliers;

alter table products modify column price int;
INSERT INTO products values(null,null,null,null,null,null);
UPDATE products set productName = 'Colgate' where productid =78;
SELECT * FROM products where productName = 'colgate';




-- WHERE, AND, OR, NOT,LIMIT
SELECT * from products where ProductID = 14;-- NULLS LAST-FIRTS;
UPDATE products SET ProductName = 'Tofu' where ProductId = 14;
SELECT * from products where ProductName = 'Tofu' and ProductID = 14;
SELECT * from customers where CustomerName like '%Tr%' and City like '%México%';
SELECT * FROM customers where CustomerID >=50 and CustomerID <55;
SELECT * from employees where FirstName like '%Nancy' or FirstName like '%Anne';
SELECT * from products where (price <20 or CategoryID = 6) and SupplierID = 7;
SELECT * from employees where (FirstName like '%c%' or LastName like's%') and notes like '%California%';
SELECT * from products where not price >40;
SELECT * FROM customers where not Country = 'USA';
select * from customers where not country = 'usa' and not country ='France';
SELECT * FROM customers where customerId = 48;
SELECT * FROM customers where (CustomerID >= 50) and not Country ='Germany'and not Country = 'UK' limit 5;
SELECT * from products where not CategoryID =6 and not SupplierID = 1 and price <= 30 order by rand() limit 3 ;

-- DISTINC !=
SELECT * FROM products where true; 
SELECT * FROM products where true;
SELECT * FROM PRODUCTS WHERE 1; -- TRUE
SELECT * FROM PRODUCTS WHERE 0; -- FALSE
Select * from products where true and false;
select * from products where true and true;
select * from products where false and false;
select * from customers where not country = 'USA';

-- BETWEEN rangos... primer menor - segundo mayor
-- 1 TRUE 0 FALSE

SELECT * FROM products where Price between 20 and 40; -- RETORNA RANGO ENTRE 20 Y 40 EN ESTE CASO DE PRECIO
SELECT * FROM products where price between 10 and 50 and CategoryID = 2; -- RETORNA RANGO ENTRE 10 Y 50 Y QUE LA CATEROGIA SEA DE ID 2
SELECT * FROM products where not price between 10 and 30; -- DEVUELVE TODOS LOS PRODUCTOS FUERAS DEL RANGO DE 10 A 30
SELECT * FROM employees where BirthDate between '1960-0-1' and '1970-0-1'; -- DEVUELVE EL RANGO DE NACIMIENTO ENTRE 1960 Y 1970
-- LIKE % % ____ filtros de textos

SELECT * FROM employees where Lastname like 'fuller'; -- FUNCION QUE TRABAJA COMO EL =
SELECT * FROM employees where Lastname like '%r'; -- INDICA LA ULTIMA LETRA, ARROJARA TODOS LOS DATOS QUE TERMINEN EN r
SELECT * FROM employees where LastName like 's%'; -- INDICA LA PRIMERA LETRA, ARROJARA TODOS LOS DATOS QUE EMPIECEN EN s
SELECT * FROM employees where LastName like '%k%'; -- INDIQUE LA LETRA, ARROJA TODOS LOS DATOS DONDE CONTENGA LA k 
SELECT * FROM employees where LastName not like 'f%'; 

SELECT * FROM employees where LastName like 'f____r'; -- INDICA QUE EL APELLIDO EMPIEZA EN F Y TERMINA EN R CON 4 CARACTERES DENTRO
SELECT * FROM employees where LastName like 'f_____';
SELECT * FROM employees where Lastname like '__ller';
SELECT * from employees where LastName like '_u____';
SELECT * FROM employees where LastName like '_U__%';
SELECT * FROM employees where LastName not like '_u___%';

-- IS NULL OR IS NOT NULL
SELECT * FROM employees where LastName is null; -- RETORNA LOS NULOS
SELECT * FROM employees where LastName is not null; -- RETORNA TODO LO QUE NO ES NULO
SELECT * FROM products where Price is null;

SELECT * FROM products where SupplierID in (select SupplierID from suppliers where SupplierID= 5);

SELECT p.* FROM products p inner join suppliers s where s.SupplierID = p.SupplierID and p.SupplierID = 5;

-- OPERADOR IN, NOT IN

SELECT * FROM products where supplierid in (1,2,3,4); -- ES COMO DARLE 1 O 2 O 3 O 4 PERO RESUMIDO, ACA MUESTRA LOS SUPPLIER ID QUE SEAN 1,2,3,4
SELECT * FROM employees where LastName in ('Fuller','King'); -- BUSCA ENTRE LOS APELLIDOS FULLER OOO KING
SELECT * FROM employees where lastname not in('Fuller','King'); -- BUSCA TODO MENOS LOS APELLIDOS FULLER OO KING

-- FUNCIONES DE AGREGACION
-- SELECT FUNCTION()
SELECT COUNT(firstname) as cantidadNombre from employees; -- ME DEVUELVE LA CANTIDAD DE FIRSTNAME QUE HAY EN LA TABLA
SELECT SUM(PRICE) as precioTotal from products; -- ME DEVUELVE LA SUMA TOTAL DE TODOS LOS PRODUCTOS
SELECT AVG(PRICE) as promedio from products; -- DEVUELVE EL PROMEDIO DE TODOS LOS PRODUCTOS
SELECT round(price) as promedio from products; -- REDONDEA EL PRECIO DE LOS PRODUCTOS A ENTEROS
SELECT ROUND(AVG(PRICE)) as promedioRedondo from products; -- COMBINANDO LOS DOS, REDONDEAMOS EL PROMEDIO DE LOS PRODUCTOS
SELECT ROUND(AVG(PRICE,2)) as promedioCantidadDes from products; -- IGUAL AL ANTERIOR PERO INDICANDO LA CANTIDAD DE DECIMALES QUE QUEREMOS QUE MUESTRE
SELECT MIN(PRICE) as minimo from products; -- DEVUELVE EL VALOR MINIMO DEL PRECIO
SELECT MAX(PRICE) as maximo from products; -- DEVUELVE EL VALOR MAXIMO DEL PRECIO
SELECT max(price) as max, min(price) as min, (max(price)-min(price)) as diferenciaEntreAmbos from products; -- PARA DEVOLVER LA DIFERENCIA ENTRE AMBOS
select productname,max(price) from products where price is not null group by productname order by price desc limit 1; -- DEVUELVE EL PRODUCTO CON EL PRECIO MAS BAJO;
select productname,price from products order by price desc limit 1;
SELECT productname,max(price) from products where ProductName is not null;
SELECT ProductName, MIN(Price) FROM Products WHERE ProductName IS NOT NULL GROUP BY ProductName;
SELECT productName,price as minimo from products where price in(select min(price) from products); -- MANERA OPTIMA

-- GROUP BY Y HAVING

SELECT supplierid,round(AVG(price)) as promedio from products where price is not null group by SupplierID order by promedio desc; 
SELECT categoryID, round(avg(price)) as 'promedio' from products where price is not null group by CategoryID; -- ORDENA Y AGRUPA LOS PRODUCTOS POR TU CATEGORIA
SELECT supplierid,round(avg(price)) as promedio from products group by SupplierID having promedio>40; -- ES IGUAL A WHERE SOLO QUE SE UTILIZA EN GRUPOS Y SE USA DESPUES DEL GROUP
SELECT supplierid,round(avg(price)) as promedio from products where price is not null group by SupplierID having promedio>40; -- SE PUEDE USAR TAMBIEN EL WHERE PARA FILTRAR
SELECT supplierid,round(avg(price)) as promedio from products where price is not null and SupplierID != 4 group by SupplierID having promedio>40; -- SE PUEDE USAR TAMBIEN EL WHERE PARA FILTRAR






create database holamundo;

use holamundo;

create table usuarios(
id int NOT NULL auto_increment,
name varchar(100) not null,
edad int not null,
email varchar(100) not null,
primary key(id)

);


INSERT INTO usuarios(name,edad,email) VALUES('Juan Perez',25,'juanchoP@gmail.com');
INSERT INTO usuarios(name,edad,email) VALUES('Ricardo Manzano',14,'rcManz@hotmail.com');
INSERT INTO usuarios(name,edad,email) VALUES('Francisco Naranjo',29,'naranjoFjx@gmail.com');
INSERT INTO usuarios(name,edad,email) VALUES('Fernando Montilla',35,'xShadowFer@gmail.com');

UPDATE usuarios SET edad = 14 where id = 2;


delete from usuarios where id = 5;

SELECT * FROM usuarios;
SELECT * FROM usuarios limit 2; -- INDICA EL LIMITE DE FILAS QUE NOS VA A IMPRIMIR, EN ESTE CASO MOSTRARA SOLO DOS FILAS, LA 1 Y LA 2
SELECT * FROM usuarios where edad >30; -- NOS DEVUELVE SOLO LOS VALORES CON EDAD MAYOR A 30, DADA LA CONDICION >30 QUE LE DIMOS
SELECT * FROM usuarios where edad >=29; -- NOS DARA VALORES IGUAL O MAYORES A 29
SELECT * FROM usuarios where edad >20 and email = 'naranjofjx@gmail.com'; -- NOS DEVOLVERA UN VALOR SI EXISTE UN USUARIO MAYOR A 20 Y CON ESE CORREO, EL CUAL SI EXISTE
SELECT * FROM usuarios where edad >20 or email = 'rcManz@hotmail.com'; -- VA A TRAER A TODOS LOS USUARIOS MAYORES A 20 Y ADEMAS TENGA MAS DE 20 O NO TRAERA EL USUARIO CON EL CORREO INDICADO
SELECT * FROM usuarios where email != 'juanchoP@gmail.com'; -- DEVOLVERA TODOS LOS QUE NO TENGAN ESE CORREO
SELECT * FROM usuarios where edad between 15 and 30; -- SOLO DEVOLVERA LOS QUE ESTEN EN RANGO DE EDAD DE 15 A 30 (Es lo mismo que edad >=15 && edad<=30)
SELECT * FROM usuarios where email like '%gmail%'; -- VA A BUSCAR TODOS LOS CORREOS QUE TENGAN LA PALABRA GMAIL
SELECT * FROM usuarios where email like '%.com'; -- INDICA TODOS LOS DATOS QUE TERMINEN EN .COM, solo imprimira esos
SELECT * FROM usuarios where email like 'x%'; -- SOLO MOSTRARA LOS CORREOS QUE INICIEN CON LO INDICADO, EN ESTE CASO X
SELECT * FROM usuarios order by edad asc; -- SIRVE PARA ORDENAR LOS USUARIOS DE FORMA ASCENDENTE EN ESTE CASO POR LA EDAD
SELECT * FROM usuarios order by edad desc; -- SIRVE PARA ORDENAR LOS USUARIOS DE FORMA DESCENDENTE EN ESTE CASO POR LA EDAD
SELECT max(edad) as mayor from usuarios; -- SIRVE PARA BUSCAR EL VALOR MAXIMO INDICADO, EN ESTE CASO EDAD (MAYOR ES UN NOMBRE QUE LE ASIGNAMOS NOSOTROS)
SELECT min(edad) as menor from usuarios; -- SIRVE PARA BUSCAR EL VALOR MININO INDICADO, EN ESTE CASO EDAD (MENOR ES UN NOMBRE QUE LE ASIGNAMOS NOSOTROS)

SELECT id, name from usuarios; -- MOSTRARÁ EL ID Y EL NOMBRE DE LA TABLA SELECCIONADA
SELECT id,name as nombre from usuarios; -- CAMBIARA EL NOMBRE DE LA COLUMNA NAME como NOMBRE (SE PUEDE CAMBIAR DE CUALQUIER MANERA)
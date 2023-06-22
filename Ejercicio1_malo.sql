/*Abrir el script de la base de datos llamada “nba.sql” y ejecutarlo para crear todas las tablas e
insertar datos en las mismas. A continuación, generar el modelo de entidad relación. Deberá
obtener un diagrama de entidad relación igual al que se muestra a continuación: A continuación, se deben realizar 
las siguientes consultas sobre la base de datos:
1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
ordenados por nombre alfabéticamente.
3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
4. Mostrar el nombre de los equipos del este (East).
5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
10. Mostrar el número de puntos de cada jugador en toda su carrera.
11. Mostrar el número de jugadores de cada equipo.

12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
diferencia de puntos.
16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
equipo_ganador), en caso de empate sera null.*/

create database nba;
use nba;

create table jugadores(
id int not null auto_increment,
nombre varchar(100) not null,
equipo varchar(100) not null,
primary key(id)
);


INSERT INTO jugadores(nombre,equipo) VALUES('Lebron James','Los Angeles');
INSERT INTO jugadores(nombre,equipo) VALUES('Micael Jordan','Chicago Bulls');
INSERT INTO jugadores(nombre,equipo) VALUES('Stephen Curry','Golden State Warriors');
INSERT INTO jugadores(nombre,equipo) VALUES('Luka Doncic','Milwaukee Bucks');
INSERT INTO jugadores(nombre,equipo,peso) VALUES('Andrew Penks','Miami Heats',250);
INSERT INTO jugadores(nombre,equipo,peso,posicion,lugar,ciudad,puntoTemp4,puntoTemp5) VALUES('Naythan Crucks','Raptors',220,'Pivot','East','Minesotta',40,80),
('Paul Gasol','Raptors',180,'Alero','North','Mineaplis',50,40),
('Phipllips Men','Raptors',224,'Base','North','Kansas',80,12);


ALTER TABLE jugadores ADD peso int not null;
ALTER TABLE jugadores ADD puntoTemp4 int not null;
ALTER TABLE jugadores ADD puntoTemp5 int not null;
ALTER TABLE jugadores ADD posicion varchar(100) not null;
ALTER TABLE jugadores ADD lugar varchar(100) not null;
ALTER TABLE jugadores ADD ciudad varchar(100) not null;
ALTER TABLE jugadores MODIFY COLUMN peso double;

UPDATE jugadores SET peso = 180 where id = 1;
UPDATE jugadores SET peso = 250 where id = 2;
UPDATE jugadores SET peso = 220 where id = 3;
UPDATE jugadores SET peso = 170 where id = 4;

UPDATE jugadores SET posicion = 'Base' where id = 1;
UPDATE jugadores SET posicion = 'Escolta' where id = 2;
UPDATE jugadores SET posicion = 'Pivot' where id = 3;
UPDATE jugadores SET posicion = 'Pivot' where id = 4;
UPDATE jugadores SET posicion = 'Alero' where id = 5;

UPDATE jugadores SET lugar = 'East' where id = 1;
UPDATE jugadores SET lugar = 'South' where id = 2;
UPDATE jugadores SET lugar = 'North' where id = 3;
UPDATE jugadores SET lugar = 'Noth East' where id = 4;
UPDATE jugadores SET lugar = 'South' where id = 5;

UPDATE jugadores SET ciudad = 'Chicago' where id = 1;
UPDATE jugadores SET ciudad = 'Misisipi' where id = 2;
UPDATE jugadores SET ciudad = 'Texas' where id = 3;
UPDATE jugadores SET ciudad = 'Carolina' where id = 4;
UPDATE jugadores SET ciudad = 'Miami' where id = 5;

UPDATE jugadores SET puntoTemp4 = 80 where id = 1;
UPDATE jugadores SET puntoTemp5 = 70 where id = 1;

UPDATE jugadores SET puntoTemp4 = 80 where id = 2;
UPDATE jugadores SET puntoTemp5 = 60 where id = 2;

UPDATE jugadores SET puntoTemp4 = 90 where id = 3;
UPDATE jugadores SET puntoTemp5 = 40 where id = 3;

UPDATE jugadores SET puntoTemp4 = 50 where id = 4;
UPDATE jugadores SET puntoTemp5 = 20 where id = 4;

UPDATE jugadores SET puntoTemp4 = 40 where id = 5;
UPDATE jugadores SET puntoTemp5 = 56 where id = 5;

select * from jugadores;

SELECT * FROM jugadores order by nombre asc; -- PUNTO 1
SELECT * FROM jugadores where posicion = 'pivot' and peso > 200; -- PUNTO 2
SELECT * FROM jugadores order by equipo asc; -- PUNTO 3
SELECT * FROM jugadores WHERE lugar like '%East'; -- PUNTO 4
SELECT * FROM jugadores where ciudad like 'c%'; -- PUNTO 5
SELECT * FROM jugadores ORDER BY nombre ASC, equipo ASC; -- PUNTO 6
SELECT * FROM jugadores where equipo = 'Raptors'; -- PUNTO 7
SELECT puntoTemp4 + puntoTemp5 as suma_dePaul from jugadores where nombre = 'Paul Gasol'; -- PUNTO 8
SELECT puntoTemp4 + puntoTemp5 AS suma_puntos FROM jugadores WHERE nombre = 'Paul Gasol'; -- PUNTO 9
SELECT puntoTemp4 + puntoTemp5 as suma_totales FROM jugadores;-- PUNTO 10
SELECT equipo, COUNT(*) AS num_jugadores FROM jugadores GROUP BY equipo; -- PUNTO 11 
Select nombre,max(puntoTemp4 + puntoTemp5 ) as sumas from jugadores; -- PUNTO 12
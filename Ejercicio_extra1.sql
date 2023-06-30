use nba;

SELECT * from jugadores;
SELECT * from equipos;
SELECT * from estadisticas;
SELECT * from partidos;

SELECT nombre from jugadores order by nombre asc;-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT * from jugadores where posicion like 'C' AND peso >200 order by nombre asc;-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, ordenados por nombre alfabéticamente.
SELECT nombre from equipos order by nombre asc;-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT nombre,conferencia from equipos where conferencia like 'East';-- 4. Mostrar el nombre de los equipos del este (East).
SELECT nombre,ciudad from equipos where ciudad like 'c%';-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
SELECT nombre,Nombre_equipo from jugadores order by Nombre_equipo asc;-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT nombre,Nombre_equipo from jugadores where Nombre_equipo like 'Raptors';-- 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT j.nombre,e.puntos_por_partido as PPP from jugadores j inner join estadisticas e on e.jugador = j.codigo where j.nombre like 'Pau Gasol';-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT puntos_por_partido as PPP from estadisticas where jugador = (select codigo from jugadores where nombre like 'Pau Gasol');

SELECT j.Nombre,e.Puntos_por_partido,temporada from jugadores j inner join estadisticas e on j.codigo = e.jugador where temporada = '04/05' and j.nombre like 'Pau Gasol';-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT puntos_por_partido as PPP from estadisticas where jugador = (select codigo from jugadores where nombre like 'Pau Gasol' and temporada = '04/05');
SELECT nombre, round(SUM(Puntos_por_partido)) FROM estadisticas INNER JOIN jugadores ON estadisticas.jugador = jugadores.codigo GROUP BY nombre; -- 10. Mostrar el número de puntos de cada jugador en toda su carrera.
SELECT nombre_equipo,COUNT(nombre_equipo) as 'cantidad' from jugadores group by nombre_equipo;-- 11. Mostrar el número de jugadores de cada equipo.
SELECT j.nombre,SUM(e.puntos_por_partido) as MaximoPP from jugadores j inner join estadisticas e on j.codigo = e.jugador group by nombre order by MaximoPP desc limit 1; -- 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT jugadores.nombre AS 'Jugador',(SELECT ROUND(SUM(Puntos_por_partido)) FROM estadisticas WHERE jugador = codigo) AS 'Puntos Totales' FROM jugadores ORDER BY (SELECT ROUND(SUM(Puntos_por_partido)) FROM estadisticas WHERE jugador = codigo) DESC Limit 1;
SELECT j.nombre,j.nombre_equipo, e.conferencia,e.division,j.altura from jugadores j,equipos e where j.altura =(SELECT max(altura) as alturaMax from jugadores) group by nombre; -- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT AVG(puntos_local) AS mediaPuntosLocal, avg(puntos_visitante) as mediaPuntosVisitante, avg(puntos_local+puntos_visitante) as PuntajeTotal FROM partidos where equipo_local in (SELECT Nombre from equipos where division = 'Pacific'); -- 14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT e.equipo_local, e.equipo_visitante, abs(e.puntos_local-e.puntos_visitante) as dif from partidos e where abs(e.puntos_local-e.puntos_visitante) = (Select max(abs(e.puntos_local-e.puntos_visitante)) from partidos e); -- 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
SELECT p.equipo_local, AVG(p.puntos_local) AS 'Media de puntos' FROM partidos AS p INNER JOIN equipos AS e ON p.equipo_local = e.nombre WHERE e.division = 'Pacific' GROUP BY p.equipo_local;  -- 16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT e.equipo_local,e.equipo_visitante,e.puntos_local,e.puntos_visitante, (e.puntos_local+e.puntos_visitante) as Total from partidos e order by codigo;-- 17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
SELECT p.codigo,p.equipo_local,p.equipo_visitante,puntos_local,puntos_visitante, CASE WHEN (p.puntos_local>p.puntos_visitante) THEN equipo_local when (p.puntos_local<p.puntos_visitante) THEN equipo_visitante ELSE null end as equipoGanador from partidos p; -- 18 Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.



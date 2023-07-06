/*Llegó el momento de poner a prueba nuestros conocimientos de bases de datos, para ello nos
han propuesto el siguiente desafío:
Tenemos que adivinar la clave y posición de una caja fuerte. El cerrojo consta de 4 candados,
cada candado tiene de clave, un número que puede ser de más de 1 cifra y una posición que
puede ir desde 1 a 4.
Nosotros tenemos los 4 candados en la mano (Candado A, Candado B, Candado C y Candado D)
debemos averiguar la posición de cada candado y la clave del mismo.*/

use nba;

/*CANDADO A
Posición: El candado A está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s:
Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo.
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave: La clave del candado A estará con formada por la/s siguientes consulta/s a la base de
datos:
Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea
centro o esté comprendida en otras posiciones.*/
select * from jugadores;
select * from equipos;
select * from estadisticas;
select * from partidos;
SELECT sum(j.peso) as pesoTotal from jugadores j inner join equipos e on j.nombre_equipo = e.nombre where e.conferencia like 'East' and posicion like '%C%'; -- CLAVE A 14043
SELECT count(Asistencias_por_partido) as asisMax from estadisticas where asistencias_por_partido in(SELECT max(asistencias_por_partido) as asis from estadisticas); -- POSICION 2

/*CANDADO B
Posición: El candado B está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s:
Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de
jugadores que tiene el equipo Heat.
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base de
datos:
La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.*/

SELECT count(*) as clave from partidos where temporada like '%99%'; -- CLAVE B 3480
SELECT count(*) from estadisticas where asistencias_por_partido > (select count(*) from jugadores where nombre_equipo like 'Heat'); -- POSICION B 3


/*CANDADO C
Posición: El candado C está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s:
La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman
parte de equipos de la conferencia oeste.
Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a
195, y a eso le vamos a sumar 0.9945.
Este resultado nos dará la posición del candado (1, 2, 3 o 4)
Clave: La clave del candado B estará con formada por la/s siguientes consulta/s a la base de
datos:
Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de
sumar: el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de
tapones por partido. Además, este resultado debe ser, donde la división sea central.*/

SELECT round(count(*) / (select count(*) from jugadores where peso >= 195) + 0.9945) as resulx from jugadores where procedencia like '%michigan%' and nombre_equipo in(SELECT nombre from equipos where conferencia = 'west'); -- POSICION C 
SELECT (SELECT COUNT(*) FROM jugadores j JOIN equipos e ON j.Nombre_equipo = e.Nombre WHERE procedencia LIKE "%Michigan%" AND e.conferencia = "West") / (SELECT COUNT(*) FROM jugadores WHERE (peso >= 195)) + 0.9945 AS Posicion;

SELECT floor((avg(puntos_por_partido)+ count(asistencias_por_partido)+ sum(tapones_por_partido))) as resultado from estadisticas e join jugadores j on e.jugador = j.codigo join equipos eq on j.nombre_equipo = eq.nombre where eq.division = 'central'; -- CLAVE 631

/*CANDADO D
Posición: El candado D está ubicado en la posición calculada a partir del número obtenido en la/s
siguiente/s consulta/s:
Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. Este
resultado debe ser redondeado. Nota: el resultado debe estar redondeado
Este resultado nos dará la posición del candado (1, 2, 3 o 4)

Clave: La clave del candado D estará con formada por la/s siguientes consulta/s a la base de
datos:
Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido
de todos los jugadores de procedencia argentina.*/

SELECT j.nombre,round(e.tapones_por_partido) from estadisticas e join jugadores j on e.jugador = j.codigo where j.nombre like 'Corey Maggette' and e.temporada like '00/01'; -- POSICION D 4;
SELECT floor(sum(puntos_por_partido)) as sumPP from estadisticas e join jugadores j on e.jugador = j.codigo where j.procedencia like 'Argentina'; -- CLAVE D 191

USE henry;
# 1. ¿Cuantas carreas tiene Henry?
SELECT count(idCarrera) AS cantidad_carreras
FROM carrera;

# 2. ¿Cuantos alumnos hay en total?
SELECT count(*) AS cantidad_alumnos
FROM alumno;

# 3. ¿Cuantos alumnos tiene cada cohorte?
SELECT idCohorte, count(*) AS cantidad_alumnos
FROM alumno
GROUP BY idCohorte;

# 4. Confecciona un listado de los alumnos ordenado por los últimos alumnos que ingresaron, con nombre y apellido en un solo campo.
SELECT concat(a.nombre, ' ', a.apellido) AS nombre_apellido, fechaIngreso
FROM alumno a
ORDER BY fechaIngreso DESC;

# 5. ¿Cual es el nombre del primer alumno que ingreso a Henry?
SELECT concat(a.nombre, ' ', a.apellido) AS nombre_apellido, fechaIngreso
FROM alumno a
ORDER BY fechaIngreso
LIMIT 1;

# 6. ¿En que fecha ingreso?
SELECT date_format(fechaIngreso, '%d/%m/%Y') as fecha_ingreso
FROM alumno a
ORDER BY fechaIngreso
LIMIT 1;

# 7. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?
SELECT concat(a.nombre, ' ', a.apellido) AS nombre_apellido
FROM alumno a
ORDER BY fechaIngreso DESC
LIMIT 1;

# 8. La función YEAR le permite extraer el año de un campo date, utilice esta función y especifique cuantos alumnos ingresarona a Henry por año.
SELECT year(fechaIngreso) as año_ingreso, count(*) as cantidad
FROM alumno a
GROUP BY year(fechaIngreso);

# 9. ¿Cuantos alumnos ingresaron por semana a henry?, indique también el año. WEEKOFYEAR()
SELECT year(fechaIngreso) as año_ingreso, weekofyear(fechaIngreso) AS semana, count(*) as cantidad
FROM alumno a
GROUP BY YEAR(fechaIngreso), WEEKOFYEAR(fechaIngreso)
ORDER BY 1,2;

# 10. ¿En que años ingresaron más de 20 alumnos?
SELECT year(fechaIngreso) as año_ingreso, count(*) as cantidad
FROM alumno
GROUP BY year(fechaIngreso)
HAVING count(*) > 20
ORDER BY 1;

# 11. Investigue las funciones TIMESTAMPDIFF() y CURDATE().
# ¿Podría utilizarlas para saber cual es la edad de los instructores?.
# ¿Como podrías verificar si la función cálcula años completos? Utiliza DATE_ADD().
SELECT concat(nombre, ' ', apellido) as nombre_apellido,
timestampdiff(year, fechaNacimiento, curdate()) as edad,
date_add(fechaNacimiento, interval(timestampdiff(year, fechaNacimiento, curdate())) year) as verificador
FROM instructor;

# 12. Calcula:
# - La edad de cada alumno.
# - La edad promedio de los alumnos de henry.
# - La edad promedio de los alumnos de cada cohorte.
SELECT concat(nombre, ' ', apellido) as nombre_apellido,
timestampdiff(year, fechaNacimiento, curdate()) as edad
from alumno
ORDER BY 2 DESC;

#Corregir alumno con fecha de nacimiento errónea
SELECT *
FROM alumno
WHERE fechaNacimiento < '1900-01-01';

UPDATE alumno
SET fechaNacimiento = '2002-01-02'
WHERE idAlumno = 127;

SELECT avg(timestampdiff(year, fechaNacimiento, curdate())) as promedio_edad
from alumno;

SELECT idCohorte, avg(timestampdiff(year, fechaNacimiento, curdate())) as promedio_edad
from alumno
GROUP BY idCohorte;

#13. Elabora un listado de los alumnos que superan la edad promedio de Henry.
SELECT concat(nombre, ' ', apellido) as nombre_apellido,
timestampdiff(year, fechaNacimiento, curdate()) as edad
from alumno
WHERE timestampdiff(year, fechaNacimiento, curdate()) > (
	SELECT avg(timestampdiff(year, fechaNacimiento, curdate()))
	from alumno);



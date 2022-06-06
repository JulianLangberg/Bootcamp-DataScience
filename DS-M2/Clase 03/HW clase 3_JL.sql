use henry;

select distinct count(nombre) as cantidad_carreras from carrera; 

select count(idAlumno) as Cant_Alumnos from alumno;

select idCohorte, count(idAlumno) as Cant_Alumnos from alumno
group by idCohorte;

select concat(a.nombre," ",a.apellido) as Nombre, a.fechaIngreso 
from alumno a
order by a.fechaIngreso DESC
limit 1;

select date_format(fechaIngreso,


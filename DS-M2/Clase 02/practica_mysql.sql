USE henry;
INSERT INTO carrera (nombre)
VALUES ('Data Science');
SELECT * FROM henry.carrera;
# Inserto en la tabla instructor
INSERT INTO instructor (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIncorporacion)
VALUES ('A1001', 'Rodrigo', 'Jimenez', '1982-05-04', '2022-01-01');
SELECT * FROM instructor;

INSERT INTO cohorte (codigo, idCarrera, idInstructor, fechaInicio, fechaFinalizacion)
VALUES('01', 1, 1, '2022-03-01', '2022-07-01');

SELECT * FROM cohorte;
INSERT INTO alumno (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, idCohorte)
VALUES ('I001', 'Ana', 'Cortez', '1998-05-05', curdate(), 1),
		('I002', 'Juan', 'Carabata', '1995-04-02', curdate(), 1),
        ('I003', 'Alberto', 'Saenz', '2000-08-14', curdate(), 1);

INSERT INTO alumno (cedulaIdentidad, nombre, apellido, fechaNacimiento, idCohorte)
VALUES ('I004', 'Jimena', 'Garcia', '1996-05-05', 1);

UPDATE alumno
set nombre = 'Juan Carlos'
WHERE idAlumno = 2;

UPDATE alumno
SET fechaIngreso = curdate()
WHERE idAlumno = 4;

DELETE FROM alumno
WHERE idAlumno = 7;

SELECT * from alumno;

SELECT a.idAlumno, a.nombre AS nom, a.apellido AS ape, a.fechaNacimiento
FROM alumno a
WHERE idAlumno > 2;

SELECT a.idAlumno, a.idAlumno * 1.21 AS con_iva, concat(a.nombre,  ' ', a.apellido) AS nom_apellido, a.fechaNacimiento
FROM alumno a
WHERE idAlumno > 2;

SELECT a.idAlumno, a.nombre, a.apellido, a.fechaNacimiento
FROM alumno a
WHERE idAlumno > 2
AND a.nombre LIKE 'J%';

SELECT a.idAlumno, a.nombre, a.apellido, a.fechaNacimiento
FROM alumno a
WHERE idAlumno > 2
AND a.nombre LIKE 'J%';

SELECT *
FROM alumno a
WHERE fechaNacimiento BETWEEN '1971-01-01' AND '1998-01-01';
-- WHERE a.nombre IN ('Ana','Alberto');

SELECT a.nombre, a.apellido, a.cedulaIdentidad, a.idCohorte, c.fechaInicio, c.fechaFinalizacion
FROM alumno a
JOIN cohorte c ON (a.idCohorte = c.idCohorte);




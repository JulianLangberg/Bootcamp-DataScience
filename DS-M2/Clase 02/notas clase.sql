USE henry;
INSERT INTO carrera (nombre)
values ('Data Science');
select * from henry.carrera;

-- inserto en la tabla instructor
INSERT INTO instructor (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIncorporacion)
VALUES ('A1001','Julian', 'Langberg', '1992/09/25', '2023/01/01');

select * from instructor;

INSERT into henry.cohorte (codigo, idCarrera, idInstructor, fechaInicio, fechaFinalizacion) 
values ('01',1,1,'2022-03-01','2022-07-01');
select * from cohorte;

INSERT INTO 

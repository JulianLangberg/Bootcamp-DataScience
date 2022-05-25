use henry;
INSERT INTO carrera (nombre)
VALUES ("Full Stack Developer"),("Data Science");

INSERT INTO instructor (cedulaIdentidad,nombre,apellido,fechaNacimiento,fechaIncorporacion)
VALUES ("25456879","Antonio","Barrios","1981-07-09","2019-11-09"),
("25456879",'Antonio','Barrios','1981-07-09','2019-11-08'),
("28456321",'Lucia','Fernandez'	,'1992-05-25','2019-11-08'),
("27198354", 'Leo',	'Paris'	,'1985-06-20','2021-08-15'),
("36987520",'Agustín','Casagne','1988-08-17','2021-08-15'),
("33456215",'Franco','Caseros','1995-05-01','2021-08-15'),
("30521369",'Dario','Ramirez','1989-07-20','2021-12-01') ,
("28856789",'Agustina','Medina'	,'1991-03-08','2021-12-01'),
("33128987",'Jorge','Perez','1988-02-19','2021-12-01');


INSERT INTO cohorte (codigo, idCarrera, idInstructor, fechaInicio, fechaFinalizacion)
VALUES (1235,'FT-1235',1,1,'2020-2-1','2020-6-30'),
(1236,'FT-1236',1,2,'2020-4-5','2020-8-31'),
(1237,'FT-1237',1,1,'2021-7-5','2021-11-30'),
(1238,'FT-1238',1,2,'2021-9-6','2022-1-31'),
(1239,'FT-1239',1,3,'2022-1-10',null),
(1240,'FT-1240',1,4,'2022-2-7',null),
(1241,'FT-1241',1,5,'2022-3-7',null),
(1242,'DS-1242',2,6,'2022-3-28',null),
(1243,'FT-1243',1,1,'2022-4-4',null),
(1244,'DS-1244',2,8,'2022-5-2',null),
(1245,'FT-1245',1,2,'2022-5-2',null),
(1246,'DS-1246',2,7,'2022-7-4',null);

/*Delete from cohorte where idCohorte >1234;
DELETE FROM cohorte WHERE idCohorte = 1245;
DELETE FROM cohorte WHERE idCohorte = 1246;
UPDATE cohorte
SET nombre = 'Carlos' 
WHERE cedulaIdentidad = 35879145;

select * from cohorte
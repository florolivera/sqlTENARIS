--    Subconsultas como expresión
-- una subconsulta puede reemplazar una expresion. Dicha consulta debe devolver un valor escalar 
--(o una lista de valores de un campo)
--la sintaxis para hacer consultas seria
-- SELECT CAMPOS
-- FROM TABLA
-- WHERE CAMPO OPERADOR(SUBCONSULTA);

--SELECT CAMPO OPERADOR(SUBCONSULTA)
--FROM TABLA

--Por ejemplo si quisieramos saber el precio de determinado libro y la diferencia con el libro
-- mas costoso

SELECT Titulo, Precio,
(precio - (SELECT MAX(Precio) from libreria)) as diferencia
from libreria
where Titulo='Boulevard'; 

--    Subconsultas con in
--lo que retorna una subconsulta con "in" o "not in" es una lista. 
--Luego de obtener los resultados, la consulta exterior los usa.
--La sintaxis básica es la siguiente:
--where EXPRESION in (SUBCONSULTA);

--titulos donde el autor sea john green
select Titulo, Autor
from libreria
where Precio in
   (select Precio
     from libreria
     where autor='John Green');
--titulos donde el autor no sea john green 
select Titulo
from libreria
where Precio not in
   (select precio
     from libreria
     where autor='John Green');

--    Crear tabla a partir de otra (select - into)
--Podemos crear una tabla e insertar datos en ella en una sentencia 
--consultando otra o varias tablas con la sintaxis:

--select CAMPOSNUEVATABLA
--into NUEVATABLA
--from TABLA
--where CONDICION;

--lo que esta en titulos en la tabla libreria pasaria a libreria4
--solamente los campos que cumplan con la condicion, y en lugar de llamarse
--titulo pasaria a llamarse titulos esa columna
SELECT  distinct titulo as titulos
into libreria4
from libreria
where precio>1000;

SELECT * FROM libreria4

--    go
-- "go" es un comando que determina el fin de una sentencia 
--sirve para separar lotes por ejemplo
--visualmente quedaria como: 

--create table....
 --go
 --create rule...
 --go

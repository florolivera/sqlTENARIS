
-- 11) Campo con atributo Identity
--Identity sirve para darle un valor unico de identificacion a las filas 
--por defecto inicia en 1 y va incrementando a medida que se sumen elementos
CREATE TABLE usuarios(
codigo int identity,
mail varchar(54),
contrasena varchar(10),
primary key (contrasena)
);

--12)Otras características del atributo Identity
--tambien en lugar de que comience en 1 e incremente de a 1, podemos modificarlo para que comience en 100 e 
--incremente de a dos
CREATE TABLE tablas(
codigo int identity(100, 2),
nombre varchar(40)
);

--13)	Truncate table	
--Elimina todos los registros de la tabla pero a diferencia del drop mantiene la estructura de la misma 
truncate table tablas; 

--14)	Otros tipos de datos en SQL Server		
--texto:
--varchar(x): caracteres de longitud variable del 1-8000
--char(x):caracteres de longitud FIJA del 1-8000 
--text: datos binarios de longitud variable, no es necesario aclarar su longitud y puede tener hasta 2000000 caracteres
--nvarchar(x):datos unicode puede almacenar hasta 4000 
--nchar(x): tambien datos unicode, similar al char pero almacena hasta 4000 caracteres
--ntext: igual a el tipo de dato text pero puede almacenar hasta 10000000000000

--numerico
--int: valores enteros (rango -200000000000 hasta 200000000000)
--subtipos: smallint: hasta 5 digitos desde -32000 hasta 32000
--tinyint:hasta 255
--bigint: desde -9000000000000000000 hasta 9000000000000000)
--decimal o numeric(cantdigitos,cantdecimales): hasta 38 digitos
--float y real:desde 1.79E+308 hasta 1.79E+38
--real
--valores monetarios: money: hasta 19 digitos y solo 4 de ellos pueden ir luego del separador decimal
--Ejemplo
--900000000000000.5670
--smallmoney: entre -200000.3648 y 200000.3647

--Fecha y hora:
--datetime: almacena fechas desde 01 de enero de 1753 hasta 31 de diciembre de 9999
--smalldatetime: almacena fechas desde 1 de enero de 1900 hasta 6 de junio de 2079
--separadores: "/" "-" "."
--sintaxis para declarar el formato: 
set date format -- y el formato que elijamos 
--formatos para fechas: 
--mdy: 4/15/96
--myd: 4/96/15
--dmy: 15/4/1996
--dym: 15/96/4
--ydm: 96/15/4
--ydm: 1996/15/4
--ingreso fecha sin hora:
--si ingresamos la fecha sin aclarar la hora, por defecto apareceria como 00:00:00
--ingreso hora sin fecha:
--si ingresamos la hora sin aclarar la fecha, por defecto apareceria como 1900-01-01
--La fecha deberiamos declararla de la siguiente manera 
CREATE TABLE empleados(
nombre varchar(20) not null,
documento char(8),
fechaIngreso datetime, 
);
insert into empleados (nombre, documento, fechaIngreso) values ('florencia', '45668709', '12-01-1980');
SELECT * FROM empleados

--16)	Valores por defecto (default)			
--es un valor que aparece cuando no ingresamos nada en determinado campo
--por ejemplo, cuando no aclaramos que un elemento es "not null" por defecto nos aparecerá "null" si no especificamos nada
--pero tambien podriamos declarar un determinado valor por defecto en caso de que no querramos que aparezca "NULL"
--podriamos querer que en una columna "edad" cuando no se ingrese una edad especifica, por defecto en ese espacio
-- figure "18"
CREATE TABLE alumnos(
nombre varchar(20),
apellido varchar(29),
lejago char(3),
edad int not null default '18',
);
INSERT INTO alumnos (nombre, apellido, lejago, edad) VALUES ('florencia', 'olivera', '345', '20');
INSERT INTO alumnos (nombre, apellido, lejago) VALUES ('juan', 'perez', '360');
INSERT INTO alumnos (nombre, apellido, lejago, edad) VALUES ('martina', 'lopez', '349', '19');
SELECT * FROM alumnos;

--17)	Columnas calculadas (operadores aritméticos y de concatenación)	
--I. operadores relacionales o de comparacion: =, <>, >, <, >=, <=
--II. operadores logicos: or, and, xir, Eqv, lmp, ls, not
--III. aritmeticos: * (multiplicacion), / (division), % (resto), + (sumar), - (restar)
--IV. concatenacion: + 
--con los operadores aritmeticos podemos sacar determinados resultados con elementos de la tabla
--por ejemplo si quisieramos sumar +3 a cada una de las edades
SELECT nombre, lejago, edad, edad+3 from alumnos;
--concatenacion, ejemplo:
SELECT edad+'-'+lejago FROM alumnos;

--18)	Alias
--sirve para ver determinada columna con otro nombre
--por ejemplo podriamos cambiar nombre por alumno
SELECT nombre as alumno, lejago, edad FROM alumnos;

--VISTA

--Una vista vendria a ser una tabla virtual que 
--almacena una consulta, para que podamos utilizarla posteriormente.
--Los datos a los que podemos acceder a traves de la vista
--no están almacenados en la base de datos como un objeto
--La tabla a la cual le hacemos la consulta pasa a ser una TABLA BASE

--PERMITEN:
--I.ocultar informacion
--II.simplificar la administracion de los permisos de usuario
--III.mejorar rendimiento
 
--la sintaxis para crear una vista seria
--create view NOMBREVISTA as
--SENTENCIASSELECT
--from TABLA;

--otra sintaxis pordria ser

--el contenido al igual que con cualquier tabla se muestra con un 
--select
--create view NOMBREVISTA (NOMBRESDEENCABEZADOS)
--as
--SENTENCIASSELECT
--from TABLA;
create view vista_libreria1 as  
select(titulo+' '+autor) as productos,
precio as valor
from libreria

SELECT * FROM vista_libreria1


--VISTAS (informacion)
--para poder acceder a la informacion de una vista pueden
--usarse estos procedimientos:

--"sp_help" (sin parametros) nos retorna todos los objetos de la
--base de datos incluyendo las vistas. 
--En la columnta "Object_type".
--en el caso de que enviemos el parametro correspondiente
--que serian el nombre de una vista nos retorna la fecha
--de creacion, propietario, los campos entre otros datos. 
exec sp_help

--"sp_helptext"+(nombre de vista) nosmuestra el texto que la define, 
--excepto si ha sido encriptado.
exec sp_helptext vista_libreria1

--"sp_depends"+(nombre de un objeto) obtenemos:
--1.nombre, tipo, campos, etc de los objetos de los cuales depende
--el objeto que especificamos
--2.nombre y tipo de objetos que dependen del objeto mencionado
exec sp_depends vista_libreria1;
--tambien, en lugar de una vista podemos mencionar una tabla
--en ese caso aparecerian los objetos que dependen de la tabla, 
--vistas, restricciones etc
exec sp_depends libreria;

--tambien se puede consultar la tabla del sistema "sysobjects"
--la cual nos retorna el nombre y varios datos de todos los objetos
--de la base de datos actual.
--si en la columna "xtype" aparece "V" es porque es una vista
select*from sysobjects;

--para ver todas las vistas que creamos
select*from sysobjects
where xtype='V'

--PROCEDIMIENTOS ALMACENADOS
--sql ofrece dos alternativas para asegurar la integridad de datos
--1)DECLARATIVA: mediante el uso de rules, defaults y constraints
--2)PROCEDIMENTAL: mediante la implementacion de procedimientos almacenados
--y desencadenadores(triggers)

--un procedimiento almacenado es un conjunto de instrucciones
--a las que se le asigna un nombre y se almacena en el servidor.
--Permiten encapsular y almacenar tareas repetitivas 
--1)del sistema: estan almacenados en la db "master" y llevan el prefijo
--"sp_". Permiten recuperar informacion de las tablas del sistema y 
--pueden ejecutarse en cualquier base de datos
--2)locales: los crea el usuario
--3)temporales: pueden ser locales, cuyos nombres comienzan con un signo
--numeral (#), o globales, los cuales los nombres asignados comienzan
--con 2 signos numeral (##). Los procedimientos almacenados temporales 
--locales estan disponibles en la sesion de un solo usuario y se eliminan
--automaticamente al finalizar la sesion. Los globales estan disponibles
--en las sesiones de todos los usuarios
--4)extendidos: se implementan como bibliotecas de vinculos dinamicos
--se ejecutan fuera del entorno SQL server. 
--Generalmente, en su nombre asignado llevan "xp_" al principio 


--PROCEDIMIENTOS ALMACENADOS (crear-ejecutar)
--los procedimientos se crean en la base de datos seleccionada, exceptuando los procedimientos temporales,
--ya que se crean sobre la base de datos tempdb

--en los procedimientos no podemos agregar cualquier tipo de instruccion, podriamos agregar objetos como 
--indices y tablas, pero no un default, procedure, rule, trigger o view. En los objetos sí podemos realizar
--inserciones, actualizaciones eliminaciones, entre otros

--en el caso de crear una tabla en un procedimiento, solamente existe dentro de él y desaparece cuando el procedimiento
--finaliza, lo mismo sucede con las variables

--SINTAXIS
--create procedure NOMBREPROCEDIMIENTO
--as INSTRUCCIONES

--diferenciamos procedimientos almacenados del sistema de los locales asignandole el prefijo "sp_" cuando se le de su nombre

--EJEMPLO 
create proc pa_libros_ofertas
as
select * from libreria
where Precio<=2000;
--ejecutamos
exec pa_libros_ofertas

--procedure == proc
--execute == exec


--PROCEDIMIENTOS ALMACENADOS (parametros almacenados)
--los procedimientos pueden recibir y retornar información, para esto se emplean
--parametros de entrada y salida

--los parametros son los que posibilita pasarle informacion a un procedimiento. Para
--que admita parametros se deben declarar variables como parametros en el momento que estamos
--creando el procedimiento 

--SINTAXIS 
--create proc NOMBREPROCEDIMIENTO
--@NOMBREPARAMETRO tipo=valor por defecto
--as sentencias

--podemos declarar mas de un procedimiento, separando a cada uno con comas

--cuando estamos ejecutando el procedimiento debemos darle sus respectivos valores a los 
--parametros. En caso de que hayamos asignado previamente valores por defecto podriamos omitir el paso anterior. 
--los parametros deben ponerse en orden o llamando a cada uno de los parametros @PARAMETRO=VALOR

create proc pa_libros_autor
@autor varchar(30)
as 
select Titulo, Autor, Editorial, Precio
from libreria
where autor=@autor;

exec pa_libros_autor'John Green'

exec pa_libros_autor @autor='John Green'


--PROCEDIMIENTOS ALMACENADOS (parametros salida)
--para que los los procedimientos devuelvan informacion se emplean
--parametros de salida

--SINTAXIS
--create proc NOMBREPROCEDIMIENTO
--@PARAMETROENTRADA tipo=VALOR POR DEFECTO 
--@PARAMETROSALIDA tipo=VALOR POR DEFECTO output
--as
--select @PARAMETROSALIDA=SENTENCIAS

--por ejemplo si creamos un procedimiento en el cual enviamos dos numeros
create procedure pa_promedio 
@n1 decimal(4,2),
@n2 decimal(4,2),
@resultado decimal(4,2) output 
as
select @resultado=(@n1+@n2)/2

declare @variable decimal(4,2)
exec pa_promedio 5, 6, @variable output
select @variable;

--parametro variable sirve para guardar el resultado que nos da el parametro de salida


--PROCEDIMIENTOS ALMACENADOS (return)
--return sale de una consulta o procedimiento y todas las instrucciones posteriores
--no son ejecutadas

--return puede retornar un entero 
--usualmente esta herramienta la controlamos mediante un if


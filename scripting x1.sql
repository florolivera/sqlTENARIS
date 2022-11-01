--1)Crear una tabla (create table - sp_tables - sp_columns - drop table)	

-- I. crear base de datos (tambien puedo llamar a una base de datos ya creada) 
CREATE DATABASE Repositorio
--II.crear tabla con sus determinadas columnas y tipo de dato
CREATE TABLE libreria(
Titulo varchar(30),
Autor varchar(40),
Editorial varchar(40),
Precio float,
);
--III.para saber cuantas tablas tiene la base de datos
exec sp_tables @table_owner='dbo'
--IV.las columnas de la tabla
exec sp_columns libreria
--V.Eliminar tabla por completo
drop table libreria


--2)Insertar y recuperar registros de una tabla (insert into - select)

--I. Insertar elementos en la tabla
INSERT INTO libreria (Titulo, Autor, Editorial, Precio) VALUES ('Bajo la misma estrella', 'John Green', 'Planeta', 2500.80);
INSERT INTO libreria (Titulo, Autor, Editorial, Precio) VALUES ('Ciudades de papel', 'John Green', 'Planeta', 2300.30);
INSERT INTO libreria (Titulo, Autor, Editorial, Precio) VALUES ('After', 'Anna Tod', 'Planeta', 700.00);
INSERT INTO libreria (Titulo, Autor, Precio) VALUES ('Rayuela', 'Julio Cortazar', 2000.75);
INSERT INTO libreria (Titulo, Autor, Editorial, Precio) VALUES ('Boulevard', 'Flor M. Salvador', 'Wattpad', 1500.50);

--II. Ver todos los elementos de la tabla
SELECT * FROM libreria
--ver solamente las columnas de titulos y autores
SELECT Titulo, Autor FROM Libreria
--eliminar un titulo
DELETE FROM Libreria where Titulo='Rayuela';

--3)Tipos de datos básicos
--varchar(x): Almacena cadenas de caracteres con una longitud
--variable, su longitud maxima se aclara entre parentesis
--Ejemplo: 
--Titulo varchar(30)

--Integer: Declara valores numericos enteros entre -2000000000 a 2000000000 aprox
--podriamos utilizarlo para cantidades, edades
--Ejemplo:
--45

--float: Al igual que el tipo de dato INT almacena valores numericos
--pero con decimales separados por un punto
--podria ser utilizado para precio o peso
--Ejemplo:
--45.6

--6)Recuperar algunos registros (where)
--Sirve para indicar de donde son los elementos que buscamos, indicando
--Las columnas que queremos visualizar
select Titulo, Autor from Libreria where Editorial='Planeta'  

--7) Borrar registros (delete)
--eliminar tanto la tabla completa como determinado elemento
DELETE from Libreria;
DELETE from Libreria where Autor='John Green';

--8) Actualizar registros (update)
-- Modificar elementos de la tabla
--Todos los elementos de la columna Editorial
UPDATE Libreria set Editorial='Planeta';
--Un elemento especifico 
UPDATE Libreria set Editorial='Planeta' where Titulo='Boulevard';


--9)Valores null (is null)
--Se aclara "not null" cuando el espacio de la columna no puede
--quedar nulo o vacio, en caso de poner null o no poner nada 
--cuando el espacio no tiene ningun elemento aparece "null"
CREATE TABLE clientes(
usuario varchar(30) not null,
DNI char(8) null,
compra float,
);
INSERT INTO clientes (usuario) values ('itsflorr');

--10)Clave primaria
--primary key se utiliza para asegurarnos que no pueda haber
--dos elementos iguales
create table Compra(
  Marca varchar(30),
  primary key (Marca)
 );

-- AGRUPAR REGISTROS (group by)
-- Con esta funcion ademas de contar la cantidad de registro podemos hacer que
--aparezcan los campos determinados
select editorial, count(*)
  from libreria
  group by editorial;

-- SELECCIONAR GRUPOS (having)
-- having tiene la misma funcion que where para seleccionar elementos en base a determinadas condiciones
-- como lo podria ser editorial<>'Planeta', en este caso tambien las podemos utilizar con las
--funciones anteriormente nombradas como min, max, avg y count
 select editorial, count(*) from libreria
  where precio is not null
  group by editorial
  having editorial<>'Planeta';

  select editorial, count(*) from libreria
  group by editorial
  having count(*)>2;

-- Registros duplicados (distinct)
--sirve para contar elementos sin null y sin tener en cuenta los elementos duplicados ya que los elimina
 select distinct Autor
  from libreria
  order by Autor;

--  Cláusula top
-- nos sirve para mostrar los primeros x elementos de una tabla 
 select top 3 titulo,autor 
  from libreria
  order by autor;

--  Clave primaria compuesta
--  cumple la misma funcion que la clave primaria simple pero en este caso podria agregar
--  mas de un elemento 

CREATE TABLE planilla(
nombre varchar(20),
dni char(8),
legajo char(3),
primary key(dni, legajo)
);


-- Restricción default
--la restriccion default la utilizamos para que en caso de que el elemento de una tabla este vacio
--aparezca un valor o cadena de caracteres por defecto


--Unión
--"union" combina el resultado de dos o más instrucciones "select" en un único retorno. 
select autor, editorial from libreria;


--Agregar y eliminar campos ( alter table - add - drop)
--ALTER TABLE sirve para modificar la estructura de una tabla, 
--podemos utilizarla para agregar, modificar y eliminar campos de una tabla
--ADD lo utilizamos para agregar campos en una tabla 
--DROP eliminar campos

alter table planilla
  add edad int;

alter table planilla
drop column edad;

--Alterar campos (alter table - alter)
--ALTER sirve para modificar campos de una tabla 

alter table planilla
alter column edad char(2);


--    Tablas temporales
--las tablas temporales son visibles solamente en la sesion actual, se eliminan automaticamente
--al acabar la sesion o la funcion o procedimiento en el cual fueron definidas, tambien se pueden eliminar con 'drop table'
--estas tablas pueden ser locales o globales

--SINTAXIS
--create table #NOMBRE(
--campo definicion,
-- ....
--)

--select*from #NOMBRE
--insert into #NOMBRE 

--no puede ser indexada, ni tener restricciones y tampoco puede ser referenciada para una vista

--la diferencia con las globales es que al declararlas en lugar de un # se agregan dos (##)

--en lugar de sysobjects la sintaxis correcta seria
--select*from tempdb...sysobjects;

create table #INVENTARIO(
codigo int identity,
producto varchar(30),
codArticulo char(3),
primary key(codArticulo)
);
SELECT*FROM #INVENTARIO


--    Funciones

--determinasticas: siempre retornan el mismo resultado si se las invoca enviando el mismo valor de entrada. Todas las funciones de agregado y string
--son determinasticas, exceptuando a "charindex" y "pantidex"

--no determinasticas: pueden retornar distintos resultados cada vez que se invocan con el mismo valor de entrada. Los siguientes son 
--algunas de las funciones no determinasticas: getdate, datename, textpr, rand. Todas las funciones de configuracion, cursor
--metadata, seguridad y estadisticas del sistema son no determinasticas

--TAMBIEN EL USUARIO PUEDE CREAR SUS PROPIAS FUNCIONES
--los parametros de entrada pueden ser de cualquier tipo, excepto timestamp, cursor y table

--las funciones definidas por el usuario no permiten parametros de salida

--no todas las sentencias sql son validas dentro de una funcion. NO es posible emplear aquellas funciones no determinasticas
--ni sentencias de modificacion o actualizacion de asignacion de tablas o vistas. Si podemos emplear sentencias de asignacion
-- control de flujo y eliminacion de variables locales

--sql server admite 3 tipos de funciones definidas por el usuarios clasificadas segun el valor retornado:
--I. escalares: retornan un valor escalar
--II. de tabla de varias instrucciones: retornan una tabla
--III. de tabla en linea: retornan una tabla 
--    Funciones escalares (crear y llamar): 
--SINTAXIS

--create function NOMBRE 
--(@parametro tipo=valor por defecto)
--returns tipo 
--begin
--instucciones
--return valor
--end;

--EJEMPLO 
create function f_promedio
(@nro1 decimal(4,2),
@nro2 decimal(4,2)
)
returns decimal (6,2)
as
begin 
declare @resultado decimal (6,2)
set @resultado=(@nro1 + @nro2)/2
return @resultado
end;

create function f_sumar
(@numero1 decimal(3),
@numero2 decimal(5)
)
returns decimal(8)
as 
begin 
declare @sumando decimal(8)
set @sumando=(@numero1+@numero2)
return @sumando
end;


--    Funciones de tabla de varias instrucciones
--SINTAXIS
-- create function NOMBREFUNCION
-- (@PARAMETRO TIPO)
-- returns @NOMBRETABLARETORNO table-- nombre de la tabla
 --formato de la tabla
-- (CAMPO1 TIPO,
--  CAMPO2 TIPO,
--  CAMPO3 TIPO
-- )
-- as
-- begin
--   insert @NOMBRETABLARETORNO
--    select CAMPOS
--     from TABLA
--     where campo OPERADOR @PARAMETRO
--   RETURN
-- end


--TRIGGER
--sintaxis

--create trigger NOMBRE DISPARADOR
--on NOMBRETABLA
--for EVENTO-insert, update, delete-
--as
--sentencias.. 

--un trigger es un disparador o desencadenador. Vendria a ser un tipo de procedimiento almacenado que se
--ejecuta cuando se intenta modificar los datos de una tabla 

--se asocia a un evento tal como insercion o actualizacion o borrado sobre una tabla
-- *no pueden ser  invocados directamente al intentar modificar datos de una tabla para la que
--se ha definido un disparador ya que el disparador se ejecuta automaticamente 
--*no reciben ni retornan parametros
--*son apropiados para mantener la integridad de los datos, no para obtener resultados de consultas
--*un disparador se crea solamente en la base de datos actual pero puede hacer referencia a objetos de otra base de datos 
--*se pueden crear varios triggers para cada evento, es decir para cada tipo de modificacion que se intente hacer sobre
--una tabla 

--DISPARADOR DE INSERCION (insert trigger)
--podemos crear un disparador para que se ejecute siempre que una instruccion "insert" ingrese datos a una tabla 

--SINTAXIS
--create trigger NOMBRE DISPARADOR
--on NOMBRE TABLA
--for INSERT
--as
--sentencias..

--EJEMPLO
--create trigger dis_ventas_insertar
--on ventas
--as
--declare @stock int
--select @stock=stock from libros
--				join inserted 
--				on inserted.codigolibro=libros.codigo
--				where libros.codigo=inserted.codigolibro
--if(@stock>=(select cantidad from inserted))
--update libros set stock=stock-inserted.cantidad
--from libros
--join inserted 
--on inserted.codigolibro=libros.codigo
--where codigo=inserted.codigolibro
--else
--begin 
--raiserror inserted.codigolibro=libros.codigo
--where codigo=inserted.codigolibro
--else
--begin 
--raiserror('hay menos libros en stock de los solicitados para la venta',16,1)
--rollback transaction 
--end


--DISPARADOR DE ACTUALIZACION (update trigger)
--SINTAXIS
--create trigger NOMBRE DISPARADOR
--on NOMBRETABLA
--for update
--as
--sentencias 

--EJEMPLO
--si quisieramos crear un disparador para que no dejen modificar los datos de la tabla LIBROS 

--create trigger DIS_LIBROS_ACTUALIZAR
--on libros
--for update 
--raiserror ('los datos de la tabla libros no pueden modificarse', 10, 1)
--rollback transaction 

--o si quisieramos crear uno que evite que se modifique un campo especifico 

--create trigger dis_libros_actualizar_precio
--on libros 
--for update
--as
--if update(precio)
--begin
--raiserror('el precio de un libro no puede modificarse', 10, 1)
--rollback transaction
--end

create trigger dis_libros_precio 
on libreria 
for update
as
if update(Precio)
begin 
raiserror('no se puede modificar el precio de los libros', 10, 1)
rollback transaction 
end

update libreria set Precio=800 where Titulo='ciudades de papel'
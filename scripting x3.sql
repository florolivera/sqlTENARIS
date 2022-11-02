-- FUNCIONES
--I. Funciones para el manejo de cadenas

--substring(cadena, inicio, longitud):
--devuelve una parte de la cadena que especificamos en el primer argumento. Desde la posicion que indicamos
--en el segundo argumento hasta la longitud que indicamos en el tercer argumento
--EJEMPLO:
SELECT substring ('buenos dias', 8, 4);

--str (numero, longitud, cantidadDecimales): 
--convierte numeros a caracteres, en el primer parametro indicamos el numero con sus respectivos decimales, 
--en el segundo parametro indicamos la longitud que querramos que tenga el numero y en el tercero la cantidad
--de decimales.
--EJEMPLO:
SELECT STR (123.456, 5, 1);
--el segundo y tercer argumento no son obligatorios, por lo que en caso de no especificarlos la longitud 
--por defecto es de 10 y decimales 0
--EJEMPLO
SELECT str(123.456);
--y en caso que el segundo parametro sea menor a la parte entera del numero ingresado retornara **
--EJEMPLO 
SELECT str(123.456, 2, 3);

--stuff(cadena1, inicio, cantidad, cadena2):
--en el primer parametro ponemos la cadena principal, en el ultimo parametro la cadena que se va a superponer, en el segundo 
--parametro pondriamos desde donde queremos que inicie el reemplazo y en el tercero la cantidad de letras que queremos que 
--ocupen. 
--EJEMPLO
SELECT STUFF('abcde', 3, 2, 'opqrs');

--len(cadena):
--retorna la longitud total de la cadena que ponemos en el parametro 
--EJEMPLO 
SELECT LEN('Hola');

--char(x):
--retorna un caracter en codigo ASCII del numero entero que ponemos en el parametro 
--EJEMPLO 
SELECT CHAR(65);

--left(cadena, longitud):
--de la cadena que indicamos en el primer parametro nos retorna la longitud hasta donde indicamos
--en el segundo parametro contando desde la izquierda
--EJEMPLO 
SELECT LEFT('buenas tardes', 8);

--right(cadena, longitud): 
--exactamente igual a la funcion left pero contando desde la derecha
--EJEMPLO 
SELECT RIGHT('buenas tardes', 8);

--lower(cadena):
--retorna la cadena ingresada en minuscula
SELECT LOWER('HOLA MUNDO');

--upper(cadena):
--retorna la cadena ingresada en mayuscula 
--EJEMPLO 
SELECT UPPER('hola mundo');

--ltrim(cadena):
--elimina los espacios desde la izquierda
--EJEMPLO 
SELECT LTRIM('     hola    ');

--replace(cadena, cadena de reemplazo, cadena a reemplazar):
--en el primer parametro indicamos la cadena, en el segundo la cadena o caracter que queramos que se reemplace
--y en el ultimo parametro el caracter o cadena por el que queremos que se reemplace
SELECT REPLACE('www.google.com', 'w', 'x');

--reverse(cadena):
--la cadena que indicamos en el parametro la retorna alrevez 
--EJEMPLO 
SELECT REVERSE('sql');

--patindex(patron, cadena):
--devuelve la posicion del patron que indicamos en el primer parametro.
--EJEMPLO 
SELECT PATINDEX('%luis%','jorge luis borges');
SELECT PATINDEX('%or%', 'jorge luis borges');
--en caso de no encontrar el patron retornara 0
SELECT PATINDEX('%ts%', 'jorge luis borges');


--charidex(subcadena, cadena, inicio):
--cumple la misma funcion de la funcion patindex, con la diferencia que en el ultimo parametro debemos indicar desde donde queremos que 
SELECT CHARINDEX('or', 'jorge luis borges', 4);

--replicate(cadena, cantidad):
--la cadena que indicamos en el primer parametro se repite tantas veces como indiquemos en el segundo parametro 
SELECT REPLICATE('HOLA MUNDO, ',4);

--space(cantidad):
--retorna una cadena de espacios de la longitud que indiquemos en el parametro 
SELECT 'ABC'+SPACE(5)+'DEF'

--II. Funciones matematicas

--abs(x): 
--devuelve el valor absoluto del numero que ingresemos 
SELECT ABS(-50);

--ceiling(x): 
--redondea para arriba
SELECT CEILING(7.54);

--floor(x): 
--redondea para abajo
SELECT FLOOR(7.54);

--%: 
--retorna el resto de la division entre dos numeros
SELECT 9%3;
SELECT 10%3;

--power(x,y): 
--retorna x elevado a la y
SELECT POWER(2, 4);

--round(numero, longitud): 
--si el numero de longitud es positivo redondea los decimales y si es negativo redondea los enteros (en la longitud determinamos
--desde que numero redondeamos)
SELECT ROUND(123.456, -2);
SELECT ROUND(123.456, 2);

--sign(x):
--si el numero ingresado en el parametro retorna..
--es positivo: 1
--es negativo: -1
--es cero: 0
SELECT SIGN(3);
SELECT SIGN(-3);
SELECT SIGN(0);

--square(x):
--retorna el numero indicado en el parametro al cuadrado
SELECT SQUARE(2);

--sqrt(x):
--devuelve la raiz cuadrada del numero indicado en el parametro
SELECT SQRT(4);

--III. Funciones para el uso de fechas y horas

--getdate():
--retorna fecha y hora actual
SELECT GETDATE();

--datepart(parte fecha, fecha):
--retorna la parte de la fecha que indiquemos
--PARTES DE FECHA:
--year, quarter, month, day, week, hour, minute, second, milisecond
SELECT DATEPART(month, getdate());

--datename(parte fecha, fecha): 
--retorna el nombre en la parte de la fecha
SELECT DATENAME(day, getdate());

--dateadd(parte fecha, incremento, fecha):
--incrementa en la parte de la fecha que indiquemos en el segundo parametro de la fecha que indiquemos en el tercer parametro
SELECT DATEADD(day, 5, GETDATE());

--datediff(parte fecha, fecha1, fecha2):
--calcula el intervalo de tiempo entre las fechas ingresadas segun la parte de la fecha que indiquemos 
SELECT DATEDIFF(DAY, 2005/10/28, 2006/10/29);

--day(fecha):
--dia de la fecha espacificada
SELECT DAY(GETDATE());
--month(fecha):
--mes de la fecha especificada
SELECT MONTH(GETDATE());
--year(fecha):
--año de la fecha especificada
SELECT YEAR(GETDATE());

--ORDENAR REGISTROS (order by)
--utilizamos "order by" para ordenar el resultado de un SELECT
--para que los registros se muestren ordenados por algun campo. 
SELECT * FROM libreria order by Titulo;
SELECT * FROM libreria order by Precio;

--OTROS OPERADORES RELACIONALES (is null)
--para mostrar elementos que contengan un null (is null) o que no contengan (is not null)
SELECT *FROM libreria where editorial is not null;

--BETWEEN
--para retornar valores entre dos numeros, por ejemplo entre x y x precio
SELECT*FROM libreria WHERE Precio between 1500 and 2400;

--OTROS OPERADORES RELACIONALES (in)
--en vez de utilizar "or" podriamos reemplazarlo por un "in"
SELECT*FROM libreria WHERE Autor='John Green' or Autor='Flor M. Salvador';
SELECT*FROM libreria WHERE Autor in ('John Green', 'Flor M. Salvador');
--ambos cumplen la misma funcion 

--BUSQUEDA PATRONES (like-not like)
--podemos utilizarlo para por ejemplo retornar todos los libros de x autor
--o todos los autores que comiencen con J
SELECT*FROM libreria where autor like '%John Green%';
SELECT*FROM libreria where autor like 'J%';

--CONTAR REGISTROS(count)
--sirve para saber cuantos registros hay sin la necesidad de contarlos 
--count(*): retorna la cantidad de registros del campo especificado incluyendo los nulos
--count(precio): retorna la cantidad de registros registros menos los nulos del campo que determinamos en el parentesis
--count(distinct editorial): retorna la cantidad de registros cuyo valor en el campo que especificamos no es nulo ni tiene en cuenta
--los repetidos
SELECT count(*) FROM libreria;
SELECT count(Precio) FROM libreria;
SELECT count(Autor) FROM libreria;

--FUNCIONES AGRUPAMIENTO (count-sum-min-max-avg)
--esta funcion sirve para agrupar los elementos de un campo y realizar determinada operacion, como seria por ejemplo
--una suma
--sum: suma
--min: valor minimo
--max: valor maximo
--avg: promedio

--libro con menor precio 
SELECT MIN(Precio) FROM libreria;
--libro con mayor precio
SELECT MAX(Precio) FROM libreria;
--promedio del precio de los libros
SELECT AVG(Precio) FROM libreria;
--suma de todos los precios
SELECT SUM(Precio) FROM libreria;

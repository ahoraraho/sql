

--1)valores por defecto- default
--crear tabla libros con campos con valor por default
--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros

create table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30) not null default 'Desconocido',
editorial varchar(20),
precio decimal(5,2),
cantidad tinyint default 0
);

--ingresar registros a la tabla libros

insert into libros (titulo,editorial,precio)
values('Java en diez','Paidos',30.567);
insert into libros (titulo,editorial)
values('Aprenda Php','Siglo XX');

select * from libros;



--visualizar la estructura de la tabla/ver columna COLUMN_DEF

sp_columns libros;

--Dar el valor por defecto

insert into libros(titulo,autor,precio,cantidad)
values('El gato con botas',default,default,100);

select * from libros;

--insertar todo con default valores

insert into libros default values;

select * from libros

--2)Columnas calculadas-operadores aritmeticos-de concatenacion
--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros

create table libros(
codigo int identity primary key,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
cantidad tinyint default 0,
);

--ingresamos registros

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','B0rges','Emece',25);
insert into libros
values('java en diez','Mario m','SigloXX',50.40,100);
insert into libros(titulo,autor,editorial,precio,cantidad)
values('Alicia en el pais','Lewis Carrrol','Emece',15,50);

--ver el monto total de cada libro-columna calculada precio*cantidad

select titulo,precio,cantidad,precio*cantidad from libros;

--ver el precio de cada libro con 10% de descuento-columna calculada descuento

select titulo,precio,precio-(precio*0.1) from libros

--actualizar precio con 10% de descuento-columna calculada

update libros set precio=precio-(precio*0.1);

select * from libros;

--Columnas concatenadas

select titulo+'-'+autor+'-'+editorial from libros;


--3Uso de Alias para nombres de columna trabajar con la tabla agenda

--NombreCampo as Alias
--eliminar tabla agenda si ezxiste

if object_id('agenda') is not null
drop table agenda;

--crear tabla agenda

create table agenda(
nombre varchar(30),
domicilio varchar(30),
telefono varchar(11)
);

--ingresar registros a agenda

insert into agenda
values('Perez','Avellaneda 400','424377’');
insert into agenda
values('Marta','Sucre 3400','4555577');
insert into agenda
values('Carlos','Sarmiento 900',null);

--mostrar informacion con columna con alias-una sola expresion sin espacios

select nombre as NombreyApellido,domicilio,telefono from agenda;

--mostrar información con columna con alias-una sola expresión con espacios en blanco entre palabras

select nombre as 'Nombre y Apellido',domicilio,telefono from agenda;

----mostrar informacion con columna con alias-una sola expresion con espacios''sin as

select nombre 'Nombre y Apellido',domicilio,telefono from agenda;


--4)Funciones cadena,

--funciones para elmanejo de cadenas - str() convirte a cadena

select str(123.456,7,3);
select str(-123.456,7,3);
select str(123.956);
select str(123.856,3);
select str(123.856,2,3); --imprime ** por el segundo argumento menor

--funcion stuff rellenar por remplazo

select stuff('abcde',3,2,'opqrs');

--Funcion longitud

select len('hola');

--Funcion Ascii

select char(65);

--Funcion extrae cadena izquierda,derecha,minuscula,mayuscula,eliminar espacios,reemplazar, reversa...

select left('buenos dias',8);
select right('Buenos dias',8);
select lower('HOLA');
select upper('Hola Peru');
select ltrim(' hola ');
select rtrim(' hola ');
select replace('xxx.sqlserverya.com','x','w');
select replace('hola','o','i');

--Funcion patindex(patron,cadena) retorna posición de ocurrencia si encuentra, sino retorna 0.

select patindex('%Luis%','Jorge Luis Borges');
select patindex('%or%','Jorge Luis Borges');
select patindex('%o%','Jorge Luis Borges');

--Funciones buscar subcadena en cadena

select charindex('or','Jorge Luis borges',5);
select charindex('or','Jorge Luis borges');

--Funciones replicar, espacios
select replicate('hola',5);
select 'hola'+space(3)+'que tal';

--5)Aplicando funciones a la tabla libros
--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros

create table libros(
codigo int identity primary key,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
cantidad tinyint default 0
);

--ingresar registros

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','Borges','Emece',25);
insert into libros
values('java en 10...','Mario m','Siglo X',50.46,100);
insert into libros(titulo,autor,editorial,precio,cantidad)
values('Alicia enel pais','Carrol Lewis','Emece',15,50);

--aplicando funciones subdadena

select substring(titulo,1,12) as 'Titulos de Libro' from libros;
select left(titulo,12) as 'Titulos de Libro' from libros;
select titulo,str(precio,6,1) from libros;
select titulo,str(precio) from libros; --redondear a entero
select titulo,autor,upper(editorial) from libros;


--6)Funciones matemáticas:valor absoluto,redondeos,resto(%),potencia,raíz cuadrada

select abs(-20); --recibe un valor numerico y retorna un valor apsoluto
select ceiling(12.35) as 'redondea hacia arriba'; /*redondea hacia arriba*/
select floor(12.35); /*redondea hacia abajo*/
select 10%3; /*resto*/
select power(2,3); --potencia dos al cubo
select round(123.456,1);/*redonde desde primer decimal por ser positivo*/
select round(123.456,2);/*redondea desde primer valor entero*/
select sqrt(8); /*raíz cuadrada*/



--7)Aplicando funciones matematicas a la tabla libros de una librería
--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros
create table libros(
codigo int identity primary key,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
cantidad tinyint default 0,
);

--ingresar registros

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','Borges','Emece',25);

insert into libros
values('java en 10...','Mario m','Siglo X',50.46,100);
insert into libros(titulo,autor,editorial,precio,cantidad)
values('Alicia enel pais','Carrol Lewis','Emece',15,50);

--Mostrar precios redondeados hacia abajo/arrriba
select * from libros

select titulo,autor,precio,
floor(precio) as PrecioAbajo,
ceiling(precio) as PrecioArriba
from libros;


--8)Funciones Fechahora: getdate(), datepart(partedefecha,fecha)

select getdate(); --retorna fecha y hora actuales
select datepart(month,getdate()); --retorna nro. de mes
select datepart(day,getdate()); --retorna dia actual
select datepart(hour,getdate()); --retorna hora actual

--Funciones fechahora: datename(partedefecha,fecha)

select datename(month,getdate()); --retorna nombre de mes
select datename(day,getdate()); --retorna nombre dia actual
select datename(hour,getdate()); --retorna nombre hora actual

--agregar cantidad a fecha

select dateadd(day,5,'1980/11/02'); --agrega cinco días
select dateadd(month,3,'1980/11/02'); --agrega tres meses
select dateadd(hour,5,'1980/11/02');
select dateadd(minute,5,'1980/11/02');

--calcula intervalo de dias por diferencia

select datediff(day,'2005/10/28','2005/11/29');
select datediff(year,'2003/05/18','2022/09/27');

--retorna dia-mes-año

select day(getdate());
select month(getdate());
select year(getdate());

--9)Aplicando funciones fechahora a la tabla libros

--eliminando la tabla libros si existe

if object_id('libros') is not null
drop table libros;

--creando la tabla libros

create table libros(
titulo varchar(100) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20) default 'primera',
edicion datetime,
precio decimal(6,2),
cantidad int
);

truncate table libros
--ingresar registros

insert into libros
values('El Aleph','Borges','Primera','12-01-1980',99.5,123);
insert into libros
values('java en 10...','Mario m','Siglo X','05-05-2000',50.65,55);
insert into libros(titulo,autor,editorial,edicion,precio,cantidad)
values('Alicia enel pais','Carrol Lewis','Emece','2000/08/09',45.58,100);

--consultas de seleccion usando funciones fechahora

select titulo,datepart(year,edicion) from libros;
select titulo,datename(month,edicion) from libros;
select titulo,datediff(year,edicion,getdate()) from libros;
select titulo from libros where datepart(day,edicion) = 9;

--10)ordenar registros- order by
--Sintaxis: select * from NOMBRETABLA order by NOMBRECAMPO[o Nro.Campo];
--Por default el ordenamiento es ascendente(asc), pero puede indicarse descendente(desc)
--sepuede ordenar por varios campos y en sentidos distintos
--Order by no se aplica a campos text, ntext, image
--Aplicando order by a la tabla libros de BD libreria
--Eliminando la tabla libros para luego crearla

if object_id('libros') is not null
drop table libros;

--crear tabla libros

create table libros(
codigo int identity,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2),
primary key (codigo)
);

--Ingresando registros a la tabla libros

insert into libros(titulo,autor,editorial,precio)
values('El Aleph','Borges','Emece',15.44);
insert into libros(titulo,autor,editorial,precio)
values('Antologia','Borges','Emece',35.44);
insert into libros(titulo,autor,editorial,precio)
values('Java en diez...','Molina','Sigl',55.33);
insert into libros(titulo,autor,editorial,precio)
values('Alicia en el pais','Carroll','Paidos',20.22);
insert into libros(titulo,autor,editorial,precio)
values('Aprenda Php','Molinas','Planeta',14.67);
insert into libros(titulo,autor,editorial,precio)
values('Aprenda C++','Ceballos',null,17.77);
insert into libros(titulo,autor,editorial,precio)
values('Assembler','Rosello',null,18.56);

--Recuperar ordenados por titulo,...,etc

select * from libros order by titulo;
select titulo,autor,precio from libros order by 3;
select * from libros order by editorial desc;
select * from libros order by titulo,editorial;
select * from libros order by titulo asc,editorial desc;
select titulo,autor from libros order by precio;
select titulo,autor,editorial,precio-(precio*0.1) as 'PRECIO CON DESCUENTO'
from libros
order by 4;

--11)Aplicando operadores logicos(and,or,not) con relacionales(=,<>,<,<,<=,>=,is null, is not null)

select * from libros where (autor='Borges') and (precio<20);
select * from libros where (autor='Borges') or (editorial='Planeta');
select * from libros where not editorial='Planeta';
select * from libros where (autor='Borges') or(editorial='Paidos' and precio<20); --observar resultado con la siguiente
select * from libros where (autor='Borges' or editorial='Paidos') and (precio<20);
select * from libros where editorial is null; -- observar resultado con la siguiente
select * from libros where editorial is not null;

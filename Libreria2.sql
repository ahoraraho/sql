--1)operador relacional: "Between" trabaja con intervalos de valores, no tiene en cuenta valores null
--Trabajando con la BD Libreria2
--eliminar tabla libros si existe


if object_id('libros') is not null drop table libros;

--creando la tabla libros

create table libros(
codigo int identity,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
editorial varchar(20),
precio decimal(6,2)
);

--ingresando registros a la tabla libros

insert into libros values
('El C++','Ceballos','Emece',14.80),
('Php','Molina','Paidos',null),
('Java en diez','Fernandez','Carroll',19.80)

insert into libros(titulo,autor,precio) values
('Python','Borges',35),
('Bases de Datos','Jammes Martin',40)

insert into libros(titulo,autor,editorial,precio) values
('Java','Pedro Borges C','Emece',45.80),
('Aprenda Php','Molina','Sopena',55.50)

--consultar registros con precio entre 19 y 40

select * from libros where precio between 19 and 40;

--consultar registros con precio que no esté entre 20 y 40

select * from libros where precio not between 20 and 40;

--2)operador relacional "in" determina si un valor de un campo está en una lista
--"not in" determina los fuera de lista/los valores null no se cuentan
--usar de preferencia condiciones positivas "in"/evitar las negativas "not in"
--consultando libros de los autores Molina,Borges

select * from libros where autor in ('Borges','Molina');

--consultando libros de autores diferentes a Molina,Borges

select * from libros where autor not in ('Borges','Molina');

--3)operador relacional "like", "not like" y la busqueda de patrones, si está o no esta
--compara exclusivamente cadenas p.ej. "%Borges%"-- % comodín que remplaza varios caracteres

select * from libros where autor like '%Borges%';	--todos los que tengan Borges
select * from libros where titulo like 'P%';		--todos los que comiencen con P
select * from libros where titulo not like 'P%';	--todos los que NO comiencen con P
select * from libros where autor like '%Borge_';	--Comodin guion reemplaza un caracter

--ver libros de editorial que comience con P,S--[ ] comodin que remplaza cualquier char de listado
--like '[a-dg-i]%' busca cadenas que inicien con: a,b,c,d,g,h,i

select titulo,autor,editorial from libros where editorial like '[P-S]%';

--like '[^PS]%' comodin ^ reemplaza cualquier char NO presente entre corchetes
select titulo,autor,editorial from libros where editorial like '[^PS]%';

--like se usa con datos char,nchar,varchar,nvarchar,datetime
--like con otros tipos Sql Server convierte si es posible a carácter y ejecuta la instrucción
--ver libros con precio entre 10.00 y 19.99

select titulo,autor,editorial, precio from libros where precio like '1_.__%';

--4)Contar registros "count()"

select count(*) from libros;
select count(*) from libros where editorial='Emece';

--contar libros con precio diferente de null

select count(precio) from libros;

--5)Funciones de agrupamiento que operan sobre conjuntos de registros: count,sum,min,max,avg
--todas retornan null si no cumplen con la condición Where...excepto count que retorna cero
--totas las funciones de agregados excepto count(*) excluyen los valores nulos
select * from libros

select sum(precio) as suma from libros;
select max(precio) as maximo from libros;
select min(precio) as minimo from libros;
select avg(precio) as 'valor medio' from libros where titulo like '%PHP%';

--6)Agrupar registros: "group by" genera resúmenes para un campo de agrupamiento

select editorial,count(*) as cantidadLibros from libros group by editorial;		--determina cantidad de libros
select editorial,count(precio) as 'Nro libros con precio no nulo' from libros group by editorial;	--Nro libros con precio no nulo
select editorial,sum(precio) as 'total de dinero' from libros group by editorial;	--total de dinero
select editorial,max(precio) as Mayor,min(precio) as Menor from libros group by editorial;

select editorial,avg(precio) from libros group by editorial;
select editorial,count(*) from libros where precio<30 group by editorial;
select editorial,count(*) from libros where precio<30 group by all editorial;

select * from libros
--7)seleccionar grupos: "having" permite seleccionar o rechazar un grupo de registros
--ver libros agrupados por editorial con un valor mayor igual a dos

select editorial,count(*) from libros group by editorial having count(*)>=2;
select editorial,avg(precio) from libros group by editorial having avg(precio)>15;
select editorial,count(*) from libros where precio is not null group by editorial having editorial <> 'Emece';

--ver el precio maximo entre un rango espesifico
select editorial,max(precio) as 'Mayor' from libros group by editorial
having max(precio)<100 and max(precio)>20 order by editorial;

--8)Modificador de group by (with rollup): genera valores resumen de salida de grupos
--rollup es un modificador para group by que agrega filas extras para resumen de subgrupos
--tabla visitantes

if object_id('visitantes') is not null drop table visitantes;

--crear tabla visitantes

create table visitantes(
nombre varchar(30),
edad tinyint,
sexo char(1),
domicilio varchar(30),
ciudad varchar(20),
telefono varchar(11),
montocompra decimal(6,2) not null
);

--Ingreso de registros

insert into visitantes values
('Rosa',25,'f',null,'Arequipa',null,45.50),
('Maria',30,'f','Av Pizarro 130','Arequipa','424377',22.50),
('Carlos',40,'m','Av Los Inkas 200','Cuzco','7744555',25.50),
('Teresa',23,'f',default,'Tacna','443322',115.50),
('Pedro',45,'m','Av. Jesus 123','Arequipa','336677',35.50),
('Sheyla',32,'f','Av ejercito 500','Moquegua','11223344',85.50),
('Sonia',24,'f','Jiron bolognesi 399','Tacna','447799',95.50),
('Roxana',20,'f',null,'Tacna',null,245.50),
('Luz',50,'f','Av Pizarro 122','Arequipa','335511',55.50),
('Pablo',44,'m','Av Goyeneche 600','Arequipa',null,15.50)

--ver cantidad de visitantes por ciudad y el total

select ciudad,count(*) as Cantidad from visitantes group by ciudad with rollup;
select ciudad,sexo,count(*) as Cantidad from visitantes group by ciudad,sexo with rollup;
select ciudad,sexo,count(*) as Cantidad,sum(montocompra) as Total
from visitantes group by ciudad,sexo with rollup;

--9)Modificador de group by (with cube): genera filas de resumen de subgrupos para las combinaciones posibles
--tabla empleados

if object_id('empleados') is not null drop table empleados;

--crear tabla empleados

create table empleados(
documento varchar(8) not null,
nombre varchar(30),
sexo char(1),
estadocivil char(1),
seccion varchar(20),
primary key (documento)
);

--Ingresar registros

insert into empleados values
('29324746','Pedro','m','c','Sistemas'),
('29324749','Bety','f','c','Administracion'),
('29324766','carlos','m','s','Administracion'),
('29324846','Dante','m','s','Sistemas'),
('29314746','Rosa','f','c','Sistemas'),
('29924746','Fernando','m','s','Sistemas'),
('29724746','Gaby','f','c','Sistemas'),
('29624746','Heber','m','c','Administracion'),
('29524746','Roxana','f','c','Administracion'),
('20324746','Pablo','m','v','Administracion'),
('23324746','Luisa','f','v','Administracion'),
('22324746','Mary','f','s','Administracion'),
('21324746','Alberto','m','c','Sistemas'),
('28324746','Orlando','m','s','Sistemas'),
('27324746','Paty','f','c','Sistemas'),
('26324746','Sonia','f','c','Administracion'),
('25324746','Jose','m','c','Sistemas'),
('24324746','Raul','m','c','Sistemas')

--ver registros agrupados ... con rollup

select sexo,estadocivil,seccion,count(*) from empleados
group by sexo,estadocivil,seccion with rollup;

--ver registros agrupados ... con cube

select sexo,estadocivil,seccion,count(*) from empleados
group by sexo,estadocivil,seccion with cube;

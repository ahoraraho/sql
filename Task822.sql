--eliminar la tabla libros
Drop Table dbo.libros;  
--crear la tabla libros
Create Table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30),
editorial varchar(15),
precio decimal(6,2)
); 

--crear un �ndice agrupado �nico para el campo c�digo
Create unique clustered index I_libros_codigo on libros(c�digo)
--crear un �ndice no agrupado para el campo titulo
Create nonclustered index I_libros_titulo on libros(titulo);
--ver los �ndices de la tabla libros
Sp_helpindex libros;
--crear una restricion primary key al campo c�digo, para que cree un �ndice no agrupado
Alter table libros add constraint PK_libros_codigo primary key nonclustered (c�digo);
--ver los �ndices de la tabla libros observe la columna constraint_type
Sp_helpindex libros;
--crear un �ndice compuesto por los campos autor y editorial
Create index I_libros_autoreditorial on libros (autor,editorial);
--ver los �ndices de la tabla libros
Sp_helpindex libros;
--consultar la tabla sysindexes del sistema
Select name from sysindexes;
Select name from sysindexes where name like �I_%�;
--2)Regenerar �ndices (drop_existing):permite regenerar un �ndice con ello evitamos eliminarlo y volverlo a crear, tambi�n nos 
--permite midificar caracter�sticas del �ndice como tipo, campo, �nico, aplicar la sintaxis: cr�ate TIPOINDICE index
--NOMBREINDICE on TABLA(CAMPO) with drop existing;
--eliminar la tabla libros
Drop Table dbo.libros;
--crear la tabla libros
Create Table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30),
editorial varchar(15),
precio decimal(6,2)
)
;
--crear un �ndice no agrupado para el campo titulo
Create nonclustered index I_libros_titutlo on libros(titulo);
--ver informaci�n de los �ndices de la tabla libros
Sp_helpindex libros;
--regenerar el �ndice agregando el campo autor
Create index I_libros_titulo on libros (titulo,autor) with drop_existing;
--ver informaci�n de los �ndices de la tabla libros
Exec Sp_helpindex libros;
--regenerar el �ndice anterior convirti�ndolo en agrupado
Create clustered index I_libros_titulo on libros(titulo,autor) with drop_existing;
--ver informaci�n de los �ndices de la tabla libros
Exec Sp_helpindex libros;
--regenerar el �ndice al retirar el campo autor del �ndice
Create clustered index I_libros_titulo on libros(titulo) with drop_existing;
--ver informaci�n de los �ndices de la tabla libros
Exec Sp_helpindex libros;
--3)Eliminar �ndices (drop index): sintaxis: drop index NOMBRETABLA.NOMBREINDICE
Drop index libros.I_libros_titulo;
--eliminaci�n condicional de un �ndice�
--If exists (select name from sysindexes where name=�NOMBREINDICE�) drop index NOMBRETABLA.NOMBREINDICE;
If exists (select * from sysindexes where name='I_libros_titulo') drop index libros.I_libros_titulo;
--4)Trabajar con varias tablas-Combinaci�n Interna (inner Join o join): join es una operaci�n que relaciona dos o mas tablas para
--obtener un resultado, combinando datos de las tablas seg�n campos comunes, sintaxis: select CAMPOS from TABLA1 join
--TABLA2 on CONDICIONDECOMBINACION; p.ej Una librer�a tiene dos tablas, libros y editoriales, relacionadas por
--codigoeditorial,ejecutar:
--eliminar la tabla libros y la tabla editoriales
Drop Table dbo.libros;
Drop Table dbo.editorial;
--crear la tabla libros
Create Table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30) default 'Desconocido',
codigoeditorial tinyint not null,
precio decimal(6,2)
)
;
--agregando datos
insert into libros values 
('c++','Ceballos',1,35),
('php','Molina',1,30),
('java','Cuba',2,40),
('python','martin',4,25)
--crear la tabla editoriales, aplicar primary key (c�digo)
Create Table editorial(
codigo tinyint identity,
nombre varchar(20)
)
;
--agregando datos
insert into editorial values 
('Alfa'),
('Omega'),
('Deltha')
--mostrar datos de la tabla libros y observar que en el campo codigoeditorial solo aparece un n�mero, pero no el nombre, es por
--ello necesario realizar un join o combinaci�n por este campo de relaci�n.
Select * from libros;
--join para mostrar titulode libro,autor de libro y nombre de editorial
Select titulo,autor,nombre from libros join editoriales on codigoeditorial=editoriales.codigo;
--ver c�digo de libro,titulo,autor,nombre editorial y precio con join y usando alias para las tablas, pues ambas tablas tienen el
--campo llamado c�digo y para diferenciarlo usamos el alias l o e de cada tabla
Select l.codigo,titulo,autor,nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo;
--otra consulta combinada con la editorial delta
Select l.codigo,titutlo,autor,nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo where e.nombre=�Alfa�;
--otra consulta con join
Select titutlo,autor,nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo order by titulo ;
--Combinaci�n externa izquierda (left join): select CAMPOS from TABLAIZQUIERDA left join TABLADERECHA on CONDICION;
Select titulo,nombre from libros as l left join editoriales as e on codigoeditorial=e.codigo;
Select titulo,nombre from editoriales as e left join libros as l on e.codigo=codigoeditoriales;
--combinaci�n externa derecha(right join): select CAMPOS from TABLAIZQUIERDA right join TABLADERECHA on CONDICION;
Select titulo,nombre from libros as l right join editoriales as e on codigoeditorial=e.codigo;
Select titulo,nombre from editoriales as e right join libros as l on e.codigo=codigoeditoriales;
--combinaci�n externa completa(full join)
Select titulo,nombre from libros as l full join editoriales as e on codigoeditorial=e.codigo;
--combinaciones cruzadas(cross join)muestra todas las combinaciones: select CAMPOS from TABLA1 cross join TABLA2;
--aplicarla si se tiene la tabla comidas(c�digo,nombre,precio) y la tabla postres(c�digo,nombre,precio); ingresarle tres comidas y
--dos postres, crear la consulta de combinaci�n cross join que muestr nombre de comida, nombre de postre y precio total.
Select c.nombre as 'Plato Principal', p.nombre as 'Poster', c.precio+p.precio as 'Total' from comidas as c cross join postres as p;
--Autocombinacion: combinar una tabla consigo misma o una copia de ella. Crear la tabla comidas y ejecutar la autocombinaci�n
--tabla comidas
Create Table comidas(
codigo int identity primary key,
nombres varchar(30),
precio decimal(4,2),
tipo char(6)
)
;
--combinacion
Select c1.nombre as 'Plato Principal' , c2.nombre as 'Postre' , c1.precio+c2.precio as Total from comidas as c1 cross join comidas
as c2;
Select c1.nombre as 'Plato Principal' , c2.nombre as 'Postre' , c1.precio+c2.precio as Total from comidas as c1 cross join comidas
as c2 where c1.tipo='Plato' and c2.tipo='postre';
--Combinaciones con update y delete; usar las tablas libros y editoriales del ejercicio4
--ver datos actuales�
Select titulo,autor,e.nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo;
--Aumentar en un 15% los precios de los libros de la editorial Alfa
Update libros set precio=precio+(precio*0.15) from libros join editoriales as e on codigoeditorial=e.codigo where nombre=�Alfa�;
--Ver resultado de la actualizaci�n
Select titulo,autor,e.nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo;
--Eliminar libros de la editorial Omega
Delete libros from libros join editoriales on codigoeditorial=editoriales.codigo where editoriales.nombre=�Omega�;
--Ver resultado de la eliminaci�n
Select titulo,autor,e.nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo;
--5)Clave Foranea(Foreign key):Aquel campo que no es clave primaria en una tabla y sirve para enlazar sus valores con otra tabla en
--la cual es clave primaria se denomina clave for�nea, externa o ajena. Las claves primarias y la for�nea de enlace deben ser del
--mismo tipo, es decir esta clave for�nea nos permite hacer join con otra tabla en la cual es clave primaria. Act�a en inserciones,
--actualizaciones, eliminaciones. Una tabla puede tener varias restricciones foring key. Se aplica la siguiente sintaxis: alter table
--NOMBRETABLA1 add constraint NOMBRERESTRICCION foreing key (CAMPOCLAVEFORANEA) references
--NOMBRETABLA2(CAMPOCLAVEPRIMARIA); Aplicar a la librer�a, tablas libros, editoriales:
--Eliminar las tablas
Drop Table libreria;
Drop Table libros;
Drop Table editoriales;
--Crear las tablas
Create table libros(
codigo int not null,
titulo varchar(40),
autor varchar(30),
codigoeditorial tinyint
);
Create table editoriales(
codigo tinyint not null,
nombre varchar(20),
Primary key (codigo)
);
--Ingresar datos a tabla editoriales
insert into editoriales values 
(1,'Alfa'),
(2,'Omega'),
(3,'Deltha')
--Ingresar datos a tabla libros
insert into libros values 
(1,'c++','Ceballos',1,35),
(2,'php','Molina',1,30),
(3,'java','Cuba',2,40),
(4,'python','Martin',3,25)
;
--Agregar la restricci�n foreing key a tabla libros:
Alter table libros add constraint FK_libros_codigoeditorial foreign key (codigoeditorial) references editoriales(codigo);
--Ingresar dos nuevos libros a tabla libros
--Crear una consulta titulo,autor,nombre de editorial,precio
--Integridad referencial eliminaci�n, actualizaci�n en cascada con foreing key sintaxis:alter table TABLA1 add constraint
--NOMBRERESTRICCION foreign key (CAMPOCLAVEFORANEA) references TABLA2(CAMPOCLAVEPRIMARIA) on delete
--OPCION on update OPCION;
--Tomando la librer�a y sus tablas libros y editoriales; crear una restricci�n foreing key para evitar que se ingresen en la tabla libros
--un c�digo de editorial inexistente en la tabla editoriales con la opci�n on cascade para actualizaciones y eliminaciones:
Alter table libros add constraint FK_libros_codigoeditorial foreign key (codigoeditorial) references editoriales(c�digo) on update
cascade on delete cascade;
--ver todos los registros combinados de libros y editoriales
  select * from libros join editoriales as e on codigoeditorial=e.codigo where nombreeditorial=e.nombre;
--actualizar en editoriales c�digo de 1 a 10
Update editoriales set c�digo=10 where c�digo=1;
--ver efectos de actualizaci�n en cascade
Select titulo,autor, e.codigo, nombre from libros as l join editoriales as e on codigoeditoria=e.codigo;
--eliminar una editorial en cascade por c�digo
Delete from editoriales where c�digo=2;
--ver efectos de eliminacion en cascade
Select titulo,autor, e.codigo, nombre from libros as l join editoriales as e on codigoeditoria=e.codigo;
--ver informaci�n de restricciones en especial de foreing key, ejecute el procedimiento almacenado sp_helpconstraint
sp_helpconstraint editoriales;
--Agregar y eliminar campos en una tabla, modificando por tanto su estructura:









--Agregar sintaxis: 
alter table NOMBRETABLA add NOMBRENUEVOCAMPO DEFINICION;
--Eliminar campos sintaxis: 
alter table NOMBRETABLA drop column NOMBRECAMPO;
--Agregar el campo cantidad a la tabla libros anterior
Alter table libros add cantidad tinyint;
--verifique la estructura de la tabla con sp_columns libros;
sp_columns libros;
--eliminar el campo cantidad
Alter table libros drop column cantidad;
--ver la nueva estructura de la tabla
--6)Subconsultas(subquery) es una sentencia select anidada en otra sentencia select, insert, update,, delete; se aplica cuando una
--, consulta es muy compleja, entonces se la divide en varios pasos l�gicos; ejecute las subconsultas:
Select titulo, precio, precio - (select max(precio) form libros) as Diferencia from libros where titulo=�Php�;
Update libros set precio=55 where precio=(select max(precio) from libros);
--ver los libros
Delete from libros where precio=(select min(precio) from libros);
--ver los libros
--7)Crear una tabla a partir de otra, sintaxis: select CAMPOSNUEVATABLA into NUEVATABLA from TABLA where CONDICION;
--crear tabla autores a partir de libros
Select distinta autor as nombres into autores from libros;
--Ver contenido de la nueva tabla
Select * from autores;
--ver estructura de la nueva tabla
--8)Vistas(view): Una vista es una alternativa para ver datos de varias tablas, una vista es una tabla virtual que almacena una
--consulta, las tablas consultadas en una vista se llaman tablas base, sintaxis: cr�ate view NOMBREVISTA as SENTENCIASSELECT from TABLA;
--crear una vista a partir de una consulta
Create view vista_libros as Select titulo,autor, e.codigo, nombre from libros as l join editoriales as e on codigoeditoria=e.codigo;
--ver la informaci�n de la vista
Select * from vista_libros;
--ver informaci�n de la vista
Sp_help vista_libros;
Sp_helptext vista_libros;
--eliminar una vista, sintaxis: drop view NOMBREVISTA

--elimine la vista creada








--9)Lenguaje de control de flujo(case): compara dos o m�s valores y devuelve un resultado, aplicar la sintaxis:
case VALORACOMPARAR when VALOR1 then RESULTADO1 when VALOR2 then RESULTADO2 �. Else RESULTADOn end
--elimine la tabla alumnos y vuelva a crearla e ingrese datos
Drop Table alumnos;
create table alumnos(
nombre varchar(40),
nota tinyint
)
;
--aplicar case en una consulta
Select nombre,nota, condici�n=
Case nota
When 0 then 'Repite'
When 1 then 'Repite'
When 2 then 'Repite'
When 3 then 'Repite'
When 4 then 'Repite'
When 5 then 'Repite'
When 6 then 'Repite'
When 7 then 'Repite'
When 8 then 'Repite'
When 9 then 'Repite'
When 10 then 'Recupera'
When 11 then 'Recupera'
When 12 then 'Recupera'
When 13 then 'Promovido Aprobado'
When 14 then 'Promovido Aprobado'
When 15 then 'Promovido Aprobado'
When 16 then 'Promovido Aprobado'
When 17 then 'Promovido Aprobado'
When 18 then 'Promovido Aprobado'
When 19 then 'Promovido Aprobado'
When 20 then 'Promovido Aprobado'
End
From alumnos;
--otra forma abreviada
Select nombre,nota, condici�n=
Case
When nota<10 then 'Repite'
When nota>=10 and nota<=12 then 'Recupera'
When nota>12 then 'Promovido aprobado'
Else 'Mala nota'
End
From alumnos;
--Agregar el campo condici�n varchar(20) a la tabla alumnos
alter table alumnos add condicion varchar(20);
--Actualizar el campo condici�n
Update alumnos set condici�n=
Case
When nota<10 then 'Repite'
When nota>=10 and nota<=12 then 'Recupera'
When nota>12 then 'Promovido aprobado'
Else 'Mala nota'
End;
--ver los datos de la tabla
--10)Procedimientos almacenados (create procedure): se crean en la base de datos seleccionada, contienen varias instrucciones;
--pueden hacer referencia a tablas, vistas, funciones definidas por el usuario, otros procedimientos, etc. Aplicar la sintaxis: cr�ate
--procedure NOMBREPROCEDIMIENTO as INSTRUCCIONES;
--crear el procedimiento almacenado pa_crear_alumnos2, que contenga las instrucciones: eliminar tabla alumnos2, crear tabla
--alumnos, ingreso de dos registros
Create procedure pa_crear_alumnos2
As
If object_id('alumnos') is not null

Drop table alumnos2

create table alumnos(
nombre varchar(30),
nota tinyint
)
Insert into alumnos values('Rosa',9)
Insert into alumnos values('Pedro',17);
--fin del procedimiento�ejecutar el procedimiento
Exec pa_crear_alumnos2;
--ver si se cre� la tabla alumnos2 listando datos
select * from alumnos2
--ver informaci�n del procedimiento
Sp_help pa_crear_alumnos2;
--11)Disparadores(triggers): llamado tambi�n desencadenador, es un tipo de procedimiento almacenado que se ejecuta cuando se
--intenta modificar los datos de una tabla o vista, estos se definen para la tabla o vista, se crean para conservar la integridad
--referencial y la coherencia entre los datos de las diferentes tablas; estos se ejecutan despu�s de ejecutarse una instrucci�n insert,
--update,delete; sintaxis: cr�ate triggre NOMBREDISPARADOR on NOMBRETABLA for EVENTO � insert,update,delete- as SENTENCIAS;
--crear un disparador para las tablas de la librer�a; eliminar la tabla libros, eliminar la tabla ventas
create trigger disparadorlibreias on libreria for delete as libros as ventas
--crear la tabla libros con primary key (c�digo)
create table libros(
codigo int identity,
titulo varchar(40),
autor varchar(30),
editorial varchar(20),
precio decimal(6,2),
stock int
)
;
--crear la tabla ventas, con primary key (numero), constraint FK_ventas_codigolibro, foreing key (codigolibro) references
--libros(c�digo) on delete no action);
create table ventas(
numero int identity,
fecha datetime,
codigolibro int not null,
precio decimal(6,2),
cantidad int
)
;
--Insertar m�nimo tres registros
Insert into alumnos values
(1,'12/07/2022',01,'12,15',15),
(2,'13/08/2023',02,'11,10',14),
(3,'14/09/2024',03,'10,05',13);
--crear disparadores para actualizar el campo stock
Create trigger DIS_ventas_borrar
On ventas
For delete
As
Update libros set stock=libros.stock+deleted.cantidad
From libros
Join deleted
On deleted.codigolibro=libros.codigo;
--eliminamos un registro
Delete from ventas where numero=2;
--verifique que el registro se elimino
select * from ventas

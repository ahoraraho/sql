/*1)�ndices agrupados y no agrupados (clustered y nonclustered): un �ndice agrupado es similar a una gu�a telef�nica, los registros
con el mismo valor de campo se agrupan juntos, una tabla solo puede tener un �ndice agrupado, su tama�o es 5% del de la tabla.
Un �ndice no agrupado es como el �ndice de un libro, los datos se almacenan en un lugar diferente al �ndice, los punteros indican
el lugar de almacenamiento, se usan para hacer distintos tipos de b�squeda, puede haber hasta 249 �ndices no agrupados; los
campos de tipo text, ntext, image no se pueden indizar. SQL Server crea autom�ticamente �ndices cuando se crea una restricci�n
primary key o unique. Si no se especifica un tipo de �ndice, SQL Server lo crea como no agrupado.
En general los �ndices pueden tener m�s de un campo clave, facilitan la recuperaci�n de datos, permitiendo el acceso directo,
acelerando las b�squedas, consultas y otras operaciones que optimizan el rendimiento general de la base de datos, sintaxis:
create TIPOINDICE index NOMBREINDICE on TABLA(CAMPO); ejecutar:*/

--eliminar la tabla libros

if object_id('libros') is not null
drop table libros;

--crear la tabla libros
CREATE TABLE libros(
codigo varchar(15) not null,
titulo varchar(150) not null, 
autor varchar(100) not null, 
editorial varchar(50) null, 
precio float 
);
--crear un �ndice agrupado �nico para el campo c�digo
create unique clustered index I_libros_codigo on libros(codigo);
--crear un �ndice no agrupado para el campo titulo
create nonclustered index I_libros_titulo on libros(titulo);
--ver los �ndices de la tabla libros
Sp_helpindex libros;
--crear una restricion primary key al campo c�digo, para que cree un �ndice no agrupado
Alter table libros add constraint PK_libros_codigo primary key nonclustered (codigo);
--ver los �ndices de la tabla libros observe la columna constraint_type
Sp_helpindex libros;
--crear un �ndice agrupado �nico para el campo c�digo
create unique clustered index I_libros_codigo on libros(c�digo);
--crear un �ndice no agrupado para el campo titulo
create nonclustered index I_libros_titulo on libros(titulo);
--ver los �ndices de la tabla libros
Sp_helpindex libros;
--crear una restricion primary key al campo c�digo, para que cree un �ndice no agrupado
Alter table libros add constraint PK_libros_codigo primary key nonclustered (c�digo);
--ver los �ndices de la tabla libros observe la columna constraint_type

--crear un �ndice no agrupado para el campo titulo
create nonclustered index I_libros_titutlo on libros(titulo);
--ver informaci�n de los �ndices de la tabla libros
Sp_helpindex libros;
--regenerar el �ndice agregando el campo autor
create index I_libros_titulo on libros (titulo,autor) with drop_existing;
--ver informaci�n de los �ndices de la tabla libros
Exec Sp_helpindex libros;
--regenerar el �ndice anterior convirti�ndolo en agrupado
create clustered index I_libros_titulo on libros(titulo,autor) with drop_existing;
--ver informaci�n de los �ndices de la tabla libros
Exec Sp_helpindex libros;
--regenerar el �ndice al retirar el campo autor del �ndice

create clustered index I_libros_titulo on libros(titulo) with drop_existing;
--ver informaci�n de los �ndices de la tabla libros
Exec Sp_helpindex libros;

/*3)Eliminar �ndices (drop index): sintaxis: drop index NOMBRETABLA.NOMBREINDICE
Drop index libros.I_libros_titulo;*/
--eliminaci�n condicional de un �ndice�
--If exists (select name from sysindexes where name='NOMBREINDICE') drop index NOMBRETABLA.NOMBREINDICE;

If exists (select * from sysindexes where name='I_libros_titulo') drop index libros.I_libros_titulo;

/*4)Trabajar con varias tablas-Combinaci�n Interna (inner Join o join): join es una operaci�n que relaciona dos o mas tablas para
obtener un resultado, combinando datos de las tablas seg�n campos comunes, sintaxis: select CAMPOS from TABLA1 join
TABLA2 on CONDICIONDECOMBINACION; p.ej Una librer�a tiene dos tablas, libros y editoriales, relacionadas por
codigoeditorial,ejecutar:*/
--eliminar la tabla libros y la tabla editoriales
If�
If�
--crear la tabla libros

--crear la tabla editoriales, aplicar primary key (c�digo)

--mostrar datos de la tabla libros y observar que en el campo codigoeditorial solo aparece un n�mero, pero no el nombre, es por
ello necesario realizar un join o combinaci�n por este campo de relaci�n.
Select * from libros;
--join para mostrar titulode libro,autor de libro y nombre de editorial
Select titulo,autor,nombre from libros join editoriales on codigoeditorial=editoriales.codigo;
--ver c�digo de libro,titulo,autor,nombre editorial y precio con join y usando alias para las tablas, pues ambas tablas tienen el
campo llamado c�digo y para diferenciarlo usamos el alias l o e de cada tabla
Select l.codigo,titulo,autor,nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo;
--otra consulta combinada con la editorial delta
Select l.codigo,titutlo,autor,nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo where e.nombre='Alfa';
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
aplicarla si se tiene la tabla comidas(c�digo,nombre,precio) y la tabla postres(c�digo,nombre,precio); ingresarle tres comidas y
dos postres, crear la consulta de combinaci�n cross join que muestr nombre de comida, nombre de postre y precio total.
Select c.nombre as 'Plato Principal', p.nombre as 'Poster', c.precio+p.precio as 'Total' from comidas as c cross join postres as p;
--Autocombinacion: combinar una tabla consigo misma o una copia de ella. Crear la tabla comidas y ejecutar la autocombinaci�n
Select c1.nombre as 'Plato Principal' , c2.nombre as 'Postre' , c1.precio+c2.precio as Total from comidas as c1 cross join comidas
as c2;
Select c1.nombre as 'Plato Principal' , c2.nombre as 'Postre' , c1.precio+c2.precio as Total from comidas as c1 cross join comidas
as c2 where c1.tipo='Plato' and c2.tipo='postre';
--Combinaciones con update y delete; usar las tablas libros y editoriales del ejercicio4
--ver datos actuales�
Select titulo,autor,e.nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo;
--Aumentar en un 15% los precios de los libros de la editorial Alfa
Update libros set precio=precio+(precio*0.15) from libros join editoriales as e on codigoeditorial=e.codigo where nombre='Alfa';
--Ver resultado de la actualizaci�n
Select titulo,autor,e.nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo;
--Eliminar libros de la editorial Omega
Delete libros from libros join editoriales on codigoeditorial=editoriales.codigo where editoriales.nombre='Omega';
--Ver resultado de la eliminaci�n
Select titulo,autor,e.nombre,precio from libros as l join editoriales as e on codigoeditorial=e.codigo;

/*5)Clave Foranea(foreing key):Aquel campo que no es clave primaria en una tabla y sirve para enlazar sus valores con otra tabla en
la cual es clave primaria se denomina clave for�nea, externa o ajena. Las claves primarias y la for�nea de enlace deben ser del
mismo tipo, es decir esta clave for�nea nos permite hacer join con otra tabla en la cual es clave primaria. Act�a en inserciones,
actualizaciones, eliminaciones. Una tabla puede tener varias restricciones foring key. Se aplica la siguiente sintaxis: alter table
NOMBRETABLA1 add constraint NOMBRERESTRICCION foreing key (CAMPOCLAVEFORANEA) references
NOMBRETABLA2(CAMPOCLAVEPRIMARIA); Aplicar a la librer�a, tablas libros, editoriales:*/
--Eliminar las tablas
If�

--Crear las tablas
create table libros(
C�digo int not null,
Titulo varchar(40),
Autor varchar(30),
Codigoeditorial tnyint
);
create table editoriales(
C�digo tinyint not null,
Nombre varchar(20),
Primary key (c�digo)
);
--Ingresar datos a tabla editoriales

--Ingresar datos a tabla libros

--

--Agregar la restricci�n foreing key a tabla libros:
Alter table libros add constraint FK_libros_codigoeditorial foreing key (codigoeditorial) references editoriales(c�digo);
--Ingresar dos nuevos libros a tabla libros

--

--Crear una consulta titulo,autor,nombre de editorial,precio

--Integridad referencial eliminaci�n, actualizaci�n en cascada con foreing key sintaxis:alter table TABLA1 add constraint
NOMBRERESTRICCION foreing key (CAMPOCLAVEFORANEA) references TABLA2(CAMPOCLAVEPRIMARIA) on delete
OPCION on update OPCION;
--Tomando la librer�a y sus tablas libros y editoriales; crear una restricci�n foreing key para evitar que se ingresen en la tabla libros
un c�digo de editorial inexistente en la tabla editoriales con la opci�n on cascade para actualizaciones y eliminaciones:
Alter table libros add constraint FK_libros_codigoeditorial foreing key (codigoeditorial) references editoriales(c�digo) on update
cascade on delete cascade;
--ver todos los registros combinados de libros y editoriales
--actualizar en editoriales c�digo de 1 a 10
Update editoriales set c�digo=10 where c�digo=1;
--ver efectos de actualizaci�n en cascade
Select titulo,autor, e.codigo, nombre from libros as l join editoriales as e on codigoeditoria=e.codigo;
--eliminar una editorial en cascade por c�digo
Delete from editoriales where c�digo=2;
--ver efectos de eliminacion en cascade
Select titulo,autor, e.codigo, nombre from libros as l join editoriales as e on codigoeditoria=e.codigo;
--ver informaci�n de restricciones en especial de foreing key, ejecute el procedimiento almacenado sp_helpconstraint
--Agregar y eliminar campos en una tabla, modificando por tanto su estructura:
--Agregar sintaxis: alter table NOMBRETABLA add NOMBRENUEVOCAMPO DEFINICION;
--Eliminar campos sintaxis: alter table NOMBRETABLA drop column NOMBRECAMPO;
--Agregar el campo cantidad a la tabla libros anterior
Alter table libros addd cantidad tinyint;
--verifique la estructura de la tabla con sp_columns libros;
--eliminar el campo cantidad
Alter table libros drop column cantidad;
--ver la nueva estructura de la tabla

/*6)Subconsultas(subquery) es una sentencia select anidada en otra sentencia select, insert, update,, delete; se aplica cuando una
, consulta es muy compleja, entonces se la divide en varios pasos l�gicos; ejecute las subconsultas:
Select titulo, precio, precio - (select max(precio) form libros) as Diferencia from libros where titulo='Php';
Update libros set precio=55 where precio=(select max(precio) from libros);*/

--ver los libros
Delete from libros where precio=(select min(precio) from libros);
--ver los libros


--7)Crear una tabla a partir de otra, sintaxis: select CAMPOSNUEVATABLA into NUEVATABLA from TABLA where CONDICION;
--crear tabla autores a partir de libros

Select distinta autor as nombres into autores from libros;

--Ver contenido de la nueva tabla

Select * from autores;

--ver estructura de la nueva tabla

SELECT * FROM information_schema.columns WHERE table_name = 'autores'

/*8)Vistas(view): Una vista es una alternativa para ver datos de varias tablas, una vista es una tabla virtual que almacena una
consulta, las tablas consultadas en una vista se llaman tablas base, sintaxis: create view NOMBREVISTA as SENTENCIASSELECT
from TABLA;*/
--crear una vista a partir de una consulta

create view vista_libros as Select titulo,autor, e.codigo, nombre from libros as l join editoriales as e on codigoeditoria=e.codigo;
--ver la informaci�n de la vista
Select * from vista_libros;
--ver informaci�n de la vista
Sp_help vista_libros;
Sp_helptext vista_libros;
--eliminar una vista, sintaxis: drop view NOMBREVISTA

drop view vista_libros


/*9)Lenguaje de control de flujo(case): compara dos o m�s valores y devuelve un resultado, aplicar la sintaxis:
case VALORACOMPARAR when VALOR1 then RESULTADO1 when VALOR2 then RESULTADO2 �. Else RESULTADOn end*/
--elimine la tabla alumnos y vuelva a crearla e ingrese datos


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

--Actualizar el campo condici�n
Update alumnos set condici�n=
Case
When nota<10 then 'Repite'
When nota>=10 and nota<=12 then 'Recupera'
When nota>12 then 'Promovido aprobado'
Else 'Mala nota'
End;
--ver los datos de la tabla


/*10)Procedimientos almacenados (create procedure): se crean en la base de datos seleccionada, contienen varias instrucciones;
pueden hacer referencia a tablas, vistas, funciones definidas por el usuario, otros procedimientos, etc. Aplicar la sintaxis: create
procedure NOMBREPROCEDIMIENTO as INSTRUCCIONES;*/
--crear el procedimiento almacenado pa_crear_alumnos2, que contenga las instrucciones: eliminar tabla alumnos2, crear tabla
--alumnos, ingreso de dos registros

create procedure pa_crear_alumnos2
As
If object_id('alumnos') is not null

Drop table alumnos
create table alumnos(
Nombre varchar(30),
Nota tinyint
)
Insert into alumnos values('Rosa',9)
Insert into alumnos values('Pedro',17);

--fin del procedimiento�ejecutar el procedimiento

Exec pa_crear_alumnos2;

--ver si se cre� la tabla alumnos2 listando datos
--ver informaci�n del procedimiento

Sp_help pa_crear_alumnos2;


/*11)Disparadores(triggers): llamado tambi�n desencadenador, es un tipo de procedimiento almacenado que se ejecuta cuando se
intenta modificar los datos de una tabla o vista, estos se definen para la tabla o vista, se crean para conservar la integridad
referencial y la coherencia entre los datos de las diferentes tablas; estos se ejecutan despu�s de ejecutarse una instrucci�n insert,
update,delete; sintaxis: create triggre NOMBREDISPARADOR on NOMBRETABLA for EVENTO � insert,update,delete- as
SENTENCIAS;*/
--crear un disparador para las tablas de la librer�a; eliminar la tabla libros, eliminar la tabla ventas
If..
..crear la tabla libros con primary key (c�digo)

--crear la tabla ventas, con primary key (numero), constraint FK_ventas_codigolibro, foreing key (codigolibro) references
libros(c�digo) on delete no action);
--Insertar m�nimo tres registros


--crear disparadores para actualizar el campo stock
create trigger DIS_ventas_borrar
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

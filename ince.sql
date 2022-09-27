CREATE DATABASE INCE

USE INCE

CREATE TABLE INSTRUCTOR(
CI_Inst varchar(12) primary key not null,
Nomb_Inst varchar(20) not null,
Grado_Ins_Instructor varchar(20) not null,
Exp_Docente varchar(30) not null,
Titulo_Inst varchar(40) not null,
Instituto_Tit_Inst varchar(30) not null,
Curso_Real_Inst varchar(30) not null,
Direc_Inst varchar(30) not null,
Telf_Inst varchar(20) null
);

CREATE TABLE CURSOS(
Cod_Curso varchar(12) primary key not null,
Cursos_INCE varchar(30) not null,
Desc_Curso varchar(150) null,
Perfil_Ins varchar(30) not null,
Area_Curso varchar(30) not null,
Perfil_Partic varchar(30) not null
);

CREATE TABLE PROGRAMCION (
CI_Inst varchar(12)  not null,
Cod_Curso varchar(12) not null,
Lugar_Curso varchar(30) not null,
Fecha_ini date not null,
Fecha_fin date not null,
Horario_C datetime not null,
Tipo_Part varchar(30) not null,
Cupo_Curso varchar(20) not null,

Foreign key (CI_Inst) References INSTRUCTOR(CI_Inst),
Foreign key (Cod_Curso) References CURSOS(Cod_Curso)
);

CREATE TABLE COSTOS_CURSO(
Cod_Curso varchar(12) not null,
Recur_Curso varchar(12) not null,
Cant_Recur int not null,
Und_recur int not null,
Costo_Und money not null,

Foreign key (Cod_Curso) References CURSOS(Cod_Curso)
);

CREATE TABLE RESUMEN_COSTO(
Cod_Curso varchar(12) not null,
Costo_Total money not null,

Foreign key (Cod_Curso) References CURSOS(Cod_Curso)
);

CREATE TABLE TITULO_OBT_INSTRUC(
CI_Inst varchar(12) not null,
Titulo_Inst varchar(20) not null,
Instituto_Tit_Inst varchar(50) not null,
Fecha_Obt date not null,

Foreign key (CI_Inst) References INSTRUCTOR(CI_Inst)
);

CREATE TABLE CURSO_REAL_INST(
CI_Inst varchar(12) not null,
Curso_Real varchar(20) not null,
Instituto_Cur_Inst varchar(20) not null,
Fecha_Obt date not null

Foreign key (CI_Inst) References INSTRUCTOR(CI_Inst)
);

select * from cursos


--diccionario

select 
	d.object_id,
	a.name [tabla],
	b.name [columna], 
	c.name [tipo], 
	CASE
		WHEN c.name = 'numeric' OR  c.name = 'decimal' OR c.name = 'float'  THEN b.precision
		ELSE null
	END [Precision], 
	b.max_length, 
	CASE 
		WHEN b.is_nullable = 0 THEN 'NO'
		ELSE 'SI'
	END [Permite Nulls],
	CASE 
		WHEN b.is_identity = 0 THEN 'NO'
		ELSE 'SI'
	END [Es Autonumerico],	
	ep.value [Descripcion],
	f.ForeignKey, 
	f.ReferenceTableName, 
	f.ReferenceColumnName 
from sys.tables a   
	inner join sys.columns b on a.object_id= b.object_id 
	inner join sys.systypes c on b.system_type_id= c.xtype 
	inner join sys.objects d on a.object_id= d.object_id 
	LEFT JOIN sys.extended_properties ep ON d.object_id = ep.major_id AND b.column_Id = ep.minor_id
	LEFT JOIN (SELECT 
				f.name AS ForeignKey,
				OBJECT_NAME(f.parent_object_id) AS TableName,
				COL_NAME(fc.parent_object_id,fc.parent_column_id) AS ColumnName,
				OBJECT_NAME (f.referenced_object_id) AS ReferenceTableName,
				COL_NAME(fc.referenced_object_id,fc.referenced_column_id) AS ReferenceColumnName
				FROM sys.foreign_keys AS f
				INNER JOIN sys.foreign_key_columns AS fc ON f.OBJECT_ID = fc.constraint_object_id) 	f ON f.TableName =a.name AND f.ColumnName =b.name
WHERE a.name <> 'sysdiagrams' 
ORDER BY a.name,b.column_Id



sys.tables
sys.columns
sys.systypes
sys.objects
sys.extended_properties}

SELECT 
	--'DATADICTIONARY' AS [REPORT],
	--@@SERVERNAME AS [ServerName],
	---DB_NAME() AS [DatabaseName],
	t.name AS [TableName], 
	schema_name(t.schema_id) AS [SchemaName], 
	c.name AS [ColumnName], 
	st.name AS [DataType], 
	c.max_length AS [MaxLength], 
	CASE 
		WHEN c.is_nullable = 0 THEN 'NO'
		ELSE 'YES'
	END AS [IsNull],
	CASE 
		WHEN c.is_identity = 0 THEN 'NO'
		ELSE 'YES'
	END AS [IsIdentity], 
	isnull(ep.value, '-- add description here') AS [Description]
FROM [sys].[tables] t
INNER JOIN [sys].[columns] c
	ON t.object_id= c.object_id 
INNER JOIN [sys].[systypes] st 
	ON c.system_type_id= st.xusertype 
INNER JOIN [sys].[objects] o 
	ON t.object_id= o.object_id 
LEFT JOIN [sys].[extended_properties] ep 
	ON o.object_id = ep.major_id 
	AND c.column_Id = ep.minor_id
WHERE t.name <> 'sysdiagrams' 
ORDER BY 
	t.name,
	c.column_Id

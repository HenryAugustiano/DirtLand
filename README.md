# DirtLand

We are selling dirt from countries all over the world.

<h3> Instruction to load the database using Docker </h3>
<ol>
<li> remove line 1-5 from orderdb_sql.ddl</li>

```
CREATE DATABASE orders;
go;

USE orders;
go;
```
<li>load the database by using http://localhost/shop/loaddata.jsp </li>
<li>reinsert the deleted line in orderdb_sql.ddl </li>
<li>repeat step 2 again.</li>
</ol>

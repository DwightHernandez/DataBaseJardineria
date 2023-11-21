1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
   
   ```sql
   SELECT 
   c.nombre_cliente AS NombreCliente,
   CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
   FROM cliente c
   JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
   
   
   ```

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
   
   ```sql
   SELECT distinct
   c.nombre_cliente AS NombreCliente,
   CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
   FROM cliente c
   JOIN pago p ON c.codigo_cliente = p.codigo_cliente
   JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
   
   ```
   
   

3. Muestra eI nombre de los clientes que no hayan realizado pagos junto con eI nombre de sus representantes de ventas
   
   ```sql
   SELECT
   c.nombre_cliente AS NombreCliente,
   CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
   FROM cliente c
   LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
   WHERE p.codigo_cliente is NULL;
   ```

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
   
   ```sql
   SELECT
     c.nombre_cliente AS NombreCliente,
     CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas,
     o.ciudad AS Ciudad
   FROM cliente c
   LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
   INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;
   ```



5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
   
   ```sql
   SELECT DISTINCT
     c.nombre_cliente AS NombreCliente,
     CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas,
     o.ciudad AS Ciudad
   FROM cliente c
   LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
   JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE p.codigo_cliente is NULL
   ```

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
   
   ```sql
   SELECT DISTINCT
     c.nombre_cliente AS NombreCliente, c.ciudad AS Ciudad_Cielnte, o.linea_direccion1 AS Direccion_Oficina
   FROM cliente c
   JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
   JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
   WHERE c.ciudad = "Fuenlabrada";
   ```

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

    ```SQL
    SELECT DISTINCT c.nombre_cliente, e.nombre AS nombre_representante, o.ciudad FROM cliente c
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;
    ```

8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

    ```SQL
    SELECT e.nombre AS nombre_empleado, e2.nombre AS nombre_jefe FROM empleado e
    LEFT JOIN empleado e2 ON e.codigo_jefe = e2.codigo_empleado;
    ```

9. Devuelve un listado que muestre el nombre de cada empleado, el nombre de su jefe y el nombre del jefe de sus jefe.

    ```SQL
    SELECT e.nombre AS nombre_empleado, e2.nombre AS nombre_jefe, e3.nombre AS nombre_jefe_mayor
    FROM empleado e
    LEFT JOIN empleado e2 ON e.codigo_jefe = e2.codigo_empleado
    LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;
    ```

10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

    ```SQL
    SELECT DISTINCT nombre_cliente FROM cliente c
    JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
    WHERE fecha_entrega > fecha_esperada;
    ```

11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

    ```SQL
    SELECT c.codigo_cliente, c.nombre_cliente, GROUP_CONCAT(DISTINCT pro.gama SEPARATOR ', ') AS gamas_producto 
    FROM cliente c
    JOIN pedido pe ON pe.codigo_cliente = c.codigo_cliente
    JOIN detalle_pedido dp ON dp.codigo_pedido = pe.codigo_pedido
    JOIN pago pag ON pag.codigo_cliente = c.codigo_cliente
    JOIN producto pro ON dp.codigo_producto = pro.codigo_producto
    GROUP BY c.codigo_cliente
    ORDER BY c.codigo_cliente;
    ```
    
-----------------------------------------------------------------------------

## Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.

 1  Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

```sql
select c.nombre_cliente, p.codigo_cliente from cliente c 
left join pago p on c.codigo_cliente = p.codigo_cliente where p.codigo_cliente is null;
```

 2 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

```sqlcopdb
select c.nombre_cliente, p.codigo_cliente from cliente c
left join pedido p on c.codigo_cliente = p.codigo_cliente where p.codigo_cliente is null;
```

 3 Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

```sql
select c.codigo_cliente, c.nombre_cliente, pa.codigo_cliente , pe.codigo_cliente from cliente c
left join pedido pe on c.codigo_cliente = pe.codigo_cliente
left join pago pa on c.codigo_cliente = pa.codigo_cliente
where pa.codigo_cliente is null and pe.codigo_cliente is null;
```


 4 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

```sql
select concat(e.nombre, ' ', e.apellido1 ,' ' , e.apellido2)  as empleado, 
o.codigo_oficina from empleado e 
left join oficina o on e.codigo_oficina = o.codigo_oficina
where o.codigo_oficina is null;
```

 5 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

```sql
select concat(e.nombre, ' ', e.apellido1 ,' ' , e.apellido2)  as empleado, 
c.codigo_cliente from empleado e 
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas 
where c.codigo_cliente is null ;
```

 6 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

```sql
select concat(e.nombre, ' ', e.apellido1 ,' ' , e.apellido2)  as empleado, 
c.codigo_cliente,e.codigo_oficina, o.ciudad 
from empleado e 
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
left join oficina o on e.codigo_oficina = o.codigo_oficina 
where c.codigo_cliente is null ;
```


 7 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

```sql
select concat(e.nombre, ' ', e.apellido1 ,' ' , e.apellido2)  as empleado,  
c.codigo_cliente , o.codigo_oficina  from empleado e 
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
left join oficina o on e.codigo_oficina = o.codigo_oficina
where o.codigo_oficina is null or c.codigo_cliente is null 
order by e.nombre;
```


 8 Devuelve un listado de los productos que nunca han aparecido en un pedido.

```sql
select p.nombre ,dp.codigo_producto
from producto p 
left join detalle_pedido dp on p.codigo_producto = dp.codigo_producto
where dp.codigo_producto is null;
```


 9 Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.

```sql
select distinct p.nombre , p.descripcion, gp.imagen ,dp.codigo_producto
from producto p
left join detalle_pedido dp on p.codigo_producto = dp.codigo_producto
left join gama_producto gp on p.gama = gp.gama 
where dp.codigo_producto is null;
```


 10 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

```sql
select distinct o.* 
from oficina o
join empleado e on o.codigo_oficina = e.codigo_oficina
join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
join pedido p on c.codigo_cliente = p.codigo_cliente
join detalle_pedido dp on p.codigo_pedido = dp.codigo_pedido
join producto pr on dp.codigo_producto = pr.codigo_producto
where pr.nombre != 'Frutales';
```

 11 Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

```sql
select distinct c.*
from cliente c
join pedido pe on c.codigo_cliente = pe.codigo_cliente
left join pago pa on c.codigo_cliente = pa.codigo_cliente
where pa.codigo_cliente is null;
```

 12 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

```sql
select distinct e1.* , concat(e2.nombre, ' ', e2.apellido1 ,' ' , e2.apellido2) as jefe 
from empleado e1 
left join cliente c on e1.codigo_empleado = c.codigo_empleado_rep_ventas
left join empleado e2 on e1.codigo_jefe = e2.codigo_empleado 
where  c.codigo_empleado_rep_ventas is null
order by e1.nombre;

-----------------------------------------------------------------------

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
```SQL
select codigo_oficina, ciudad from oficina;
```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
```SQL
select ciudad, telefono from oficina where pais = 'españa';
```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
```SQL
select nombre, apellido1, apellido2, email from empleado where codigo_jefe = 7;
```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
```SQL
select puesto, nombre, apellido1, apellido2, email from empleado where codigo_jefe is null;
```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
```SQL
select nombre, apellido1, apellido2, puesto from empleado where puesto <> 'representante de ventas';
```
6. Devuelve un listado con el nombre de los todos los clientes españoles.
```SQL
select nombre_cliente from cliente where pais = 'spain';
```

7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
```SQL
select distinct estado from pedido;
```

8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

```SQL
select distinct codigo_cliente from pago where year(fecha_pago) = 2008;
```

9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
```SQL
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega from pedido where fecha_entrega > fecha_esperada;

```

10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

```SQL
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where fecha_entrega <= ADDDATE(fecha_esperada, -2);
```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
```SQL
select *
from pedido
where estado = 'rechazado' and YEAR(fecha_pedido) = 2009;
```

12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
```SQL
select *
from pedido
where MONTH(fecha_entrega) = 1;
```

13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
```SQL
select *
from pago
where YEAR(fecha_pago) = 2008 and forma_pago = 'Paypal'
order by total DESC;
```

14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
```SQL
select DISTINCT forma_pago
from pago;
```

15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
```SQL
select *
from producto
where gama = 'Ornamentales' and cantidad_en_stock > 100
order by precio_venta DESC;
```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
```SQL
select *
from cliente
where ciudad = 'Madrid' and (codigo_empleado_rep_ventas = 11 or codigo_empleado_rep_ventas = 30);

----------------------------------------------------------------------------
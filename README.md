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
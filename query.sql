
SELECT *
FROM pedido
JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido;

SELECT * 
FROM pedido p, detalle_pedido d
WHERE p.codigo_pedido = d.codigo_pedido;

DESCRIBE cliente;

DESCRIBE producto;
--1
SELECT 
  c.nombre_cliente AS NombreCliente,
  CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;
--2
SELECT
  c.nombre_cliente AS NombreCliente,
  CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;
--3
SELECT
c.nombre_cliente AS NombreCliente,
CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente is NULL;

--4
SELECT
  c.nombre_cliente AS NombreCliente,
  CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas,
  o.ciudad AS Ciudad
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

--5
SELECT DISTINCT
  c.nombre_cliente AS NombreCliente,
  CONCAT(e.nombre, ' ', e.apellido1) AS NombreRepresentanteVentas,
  o.ciudad AS Ciudad
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE p.codigo_cliente is NULL;

--6
SELECT DISTINCT
  c.nombre_cliente AS NombreCliente, c.ciudad AS Ciudad_Cielnte, o.linea_direccion1 AS Direccion_Oficina
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE c.ciudad = "Fuenlabrada";
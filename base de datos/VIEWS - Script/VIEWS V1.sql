--------------------------------------------------------------------

CREATE VIEW vista_productos_detalle AS
SELECT p.id_producto, p.nombre_prod, p.stock, c.nombre_cat, pr.nombre_prov
FROM producto as p
JOIN categoria as c ON c.id_categoria = p.categoria_id
JOIN detalle_proveedor_producto dpp ON dpp.producto_id = p.id_producto
JOIN proveedor pr ON pr.id_proveedor = dpp.proveedor_id;

SELECT * FROM vista_productos_detalle WHERE stock < 50;

--------------------------------------------------------------------

CREATE VIEW vista_resumen_ventas AS
SELECT
    v.id_venta,
    v.fecha_venta,
    c.nombre_cliente,
    SUM(dv.cantidad * dv.precio_unitario) AS total_venta
FROM venta_registro v
JOIN cliente c ON c.id_cliente = v.cliente_id
JOIN detalle_venta dv ON dv.venta_registro_id = v.id_venta
GROUP BY v.id_venta;

SELECT * FROM vista_resumen_ventas WHERE fecha_venta >= '2025-01-01';

--------------------------------------------------------------------

CREATE VIEW vista_auditoria_movimientos AS
SELECT
    m.id_movimiento_inv,
    p.nombre_prod,
    t.nombre_movimiento,
    m.cantidad_desplazada,
    m.fecha_movimiento,
    u.nombre_usu
FROM movimiento_prod m
JOIN producto p ON p.id_producto = m.producto_id
JOIN tipo_movimiento t ON t.id_tipo_movimiento = m.tipo_movimiento_id
JOIN usuario u ON u.id_usuario = m.usuario_id;

SELECT * FROM vista_auditoria_movimientos WHERE nombre_movimiento = "Entrada";

--------------------------------------------------------------------

CREATE OR REPLACE VIEW vista_resumen_total_ventas AS
SELECT 
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre_cliente AS cliente,
    u.nombre_usu AS vendedor,
    SUM(dv.cantidad * dv.precio_unitario) AS total_venta
FROM venta_registro v
JOIN detalle_venta dv ON dv.venta_registro_id = v.id_venta
JOIN cliente c ON c.id_cliente = v.cliente_id
JOIN usuario u ON u.id_usuario = v.usuario_id
GROUP BY v.id_venta, v.fecha_venta, c.id_cliente, u.nombre_usu;

SELECT * FROM vista_resumen_total_ventas WHERE vendedor="Carlos Gómez";

--------------------------------------------------------------------

CREATE OR REPLACE VIEW vista_inventario_actual AS
SELECT 
    p.id_producto,
    p.nombre_prod,
    c.nombre_cat,
    p.stock,
    p.fecha_expiracion,
    pr.nombre_prov,
    dpp.precio_unitario
FROM producto p
JOIN categoria c ON c.id_categoria = p.categoria_id
LEFT JOIN detalle_proveedor_producto dpp ON dpp.producto_id = p.id_producto
LEFT JOIN proveedor pr ON pr.id_proveedor = dpp.proveedor_id;

SELECT * FROM vista_inventario_actual WHERE stock <= 10;


CREATE OR REPLACE VIEW vista_stock_productos AS
SELECT 
    p.id_producto,
    p.nombre_prod,
    c.nombre_cat,
    p.stock,
    CASE 
        WHEN p.stock <= 10 THEN 'Stock Crítico'
        WHEN p.stock BETWEEN 11 AND 50 THEN 'Stock Bajo'
        ELSE 'Stock Suficiente'
    END AS nivel_alerta
FROM producto p
INNER JOIN categoria c ON p.categoria_id = c.id_categoria;


SELECT * FROM vista_stock_productos WHERE nivel_alerta != 'Stock Suficiente';

--------------------------------------------------------------------

CREATE OR REPLACE VIEW vista_alertas_activas AS
SELECT 
    a.id_alerta,
    p.nombre_prod,
    a.tipo_alerta,
    a.descripcion_alerta,
    a.fecha_creacion
FROM alerta_inv a
JOIN producto p ON p.id_producto = a.producto_id;

SELECT * FROM vista_alertas_activas;

--------------------------------------------------------------------

drop view  vista_pedidos_pendientes;

CREATE OR REPLACE VIEW vista_pedidos_pendientes AS
SELECT 
    pc.id_pedido,
    pr.nombre_prov,
    e.nombre_estado AS estado_pedido,
    pc.fecha_pedido,
    DATE_ADD(pc.fecha_pedido, INTERVAL 3 DAY) AS fecha_estimada,
    SUM(dp.cantidad * dp.precio_unitario) AS total_pedido
FROM pedido_compra pc
JOIN proveedor pr ON pr.id_proveedor = pc.proveedor_id
JOIN estado_pedido e ON e.id_estado_pedido = pc.estado_pedido_id
JOIN detalle_pedido dp ON dp.pedido_compra_id = pc.id_pedido
WHERE e.nombre_estado IN ('En camino', 'Pendiente')
GROUP BY pc.id_pedido, pr.nombre_prov, e.nombre_estado;

SELECT * FROM vista_pedidos_pendientes;


CREATE OR REPLACE VIEW vista_pedidos_detalle AS
SELECT 
    pc.id_pedido,
    pr.nombre_prov,
    ep.nombre_estado AS estado_pedido,
    SUM(dp.cantidad) AS total_productos,
    pc.fecha_pedido
FROM pedido_compra pc
INNER JOIN proveedor pr ON pc.proveedor_id = pr.id_proveedor
INNER JOIN estado_pedido ep ON pc.estado_pedido_id = ep.id_estado_pedido
INNER JOIN detalle_pedido dp ON dp.pedido_compra_id = pc.id_pedido
GROUP BY pc.id_pedido, pr.nombre_prov, ep.nombre_estado, pc.fecha_pedido;

SELECT * FROM vista_pedidos_detalle;

--------------------------------------------------------------------

CREATE OR REPLACE VIEW vista_resumen_total_clientes AS
SELECT 
    c.id_cliente,
    c.nombre_cliente as cliente, 
    COUNT(v.id_venta) AS total_ventas,
    SUM(dv.cantidad * dv.precio_unitario) AS total_compras
FROM cliente c
LEFT JOIN venta_registro v ON v.cliente_id = c.id_cliente
LEFT JOIN detalle_venta dv ON dv.venta_registro_id = v.id_venta
GROUP BY c.id_cliente;

SELECT * FROM vista_resumen_total_clientes;

--------------------------------------------------------------------

CREATE OR REPLACE VIEW vista_reportes_con_productos AS
SELECT 
    r.id_reporte_inv,
    r.tipo_reporte,
    fb.descripcion,
    df.valor_filtro AS condicion,
    r.fecha_generacion,
    p.nombre_prod AS producto_relacionado,
    mp.motivo_repor AS motivo,
    mp.cantidad_desplazada AS cantidad
FROM reporte_inv r
JOIN filtro_busqueda fb ON fb.reporte_inv_id = r.id_reporte_inv
JOIN detalle_filtro df ON df.filtro_busqueda_id = fb.id_filtro_busqueda
JOIN producto p 
JOIN movimiento_prod mp ON mp.producto_id = p.id_producto;

SELECT * FROM vista_reportes_con_productos;

CREATE OR REPLACE VIEW vista_reportes_inventario AS
SELECT 
    ri.id_reporte_inv,
    ri.tipo_reporte,
    u.nombre_usu AS generado_por,
    ri.fecha_generacion
FROM reporte_inv ri

LEFT JOIN usuario u ON ri.usuario_id = u.id_usuario;

-- Ejemplo:
SELECT * FROM vista_reportes_inventario WHERE tipo_reporte LIKE '%Stock%';














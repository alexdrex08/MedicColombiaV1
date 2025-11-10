-- integridad de las FK huerfanas
SELECT dv.id_detalle_venta, dv.producto_id
FROM detalle_venta dv
LEFT JOIN producto p ON p.id_producto = dv.producto_id
WHERE p.id_producto IS NULL;

-- indice de rotacion de productos
SELECT p.id_producto, p.nombre_prod,
       SUM(dv.cantidad) AS total_vendido,
       p.stock AS stock_actual,
       CASE WHEN p.stock > 0 THEN (SUM(dv.cantidad) / p.stock) ELSE NULL END AS rotacion_aproximada
FROM producto p
LEFT JOIN detalle_venta dv ON dv.producto_id = p.id_producto
GROUP BY p.id_producto, p.nombre_prod, p.stock
ORDER BY rotacion_aproximada DESC;

-- comprobar perdidos retrasados
SELECT pc.id_pedido, pc.fecha_pedido, DATEDIFF(NOW(), pc.fecha_pedido) AS dias_transcurridos,
       pr.nombre_prov, ep.nombre_estado
FROM pedido_compra pc
JOIN proveedor pr ON pr.id_proveedor = pc.proveedor_id
JOIN estado_pedido ep ON ep.id_estado_pedido = pc.estado_pedido_id
WHERE DATEDIFF(NOW(), pc.fecha_pedido) > 7 AND ep.nombre_estado != 'Recibido'
ORDER BY dias_transcurridos DESC;

-- ultimos X reportes generados + responsable
SELECT ri.id_reporte_inv, ri.fecha_generacion, ri.tipo_reporte, u.nombre_usu AS generado_por
FROM reporte_inv ri
LEFT JOIN usuario u ON u.id_usuario = ri.usuario_id
ORDER BY ri.fecha_generacion DESC
LIMIT 20; -- modificable X






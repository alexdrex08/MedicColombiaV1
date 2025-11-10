DELIMITER //
CREATE PROCEDURE reporte_stock_bajo()
BEGIN
  SELECT p.id_producto, p.nombre_prod, p.stock, c.nombre_categoria
  FROM producto p
  JOIN categoria c ON c.id_categoria = p.categoria_id
  WHERE p.stock < 10;
END //
DELIMITER ;
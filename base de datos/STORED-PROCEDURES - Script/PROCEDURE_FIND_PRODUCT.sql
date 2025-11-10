DELIMITER //
CREATE PROCEDURE buscar_producto(IN termino VARCHAR(100))
BEGIN
  SELECT id_producto, nombre_prod, stock
  FROM producto
  WHERE nombre_prod LIKE CONCAT('%', termino, '%');
END //
DELIMITER ;
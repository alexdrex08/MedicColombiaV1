SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `inventario_medicamentos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `inventario_medicamentos`;

CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `contrasena` VARCHAR(100) NOT NULL,
  `rol_usu` VARCHAR(50) NOT NULL,
  `nombre_usu` VARCHAR(100) NOT NULL,
  `correo_usu` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre_cat` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre_prod` VARCHAR(150) NOT NULL,
  `fecha_expiracion` DATETIME NOT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `categoria_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `lote_producto` BIGINT NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `idx_producto_categoria` (`categoria_id`),
  INDEX `idx_producto_usuario` (`usuario_id`),
  CONSTRAINT `fk_producto_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_prov` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `detalle_proveedor_producto` (
  `producto_id` INT NOT NULL,
  `proveedor_id` INT NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`producto_id`, `proveedor_id`),
  INDEX `idx_detalleprod_prod` (`producto_id`),
  INDEX `idx_detalleprod_prov` (`proveedor_id`),
  CONSTRAINT `fk_detalleprod_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleprod_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tipo_movimiento` (
  `id_tipo_movimiento` INT NOT NULL AUTO_INCREMENT,
  `nombre_movimiento` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tipo_movimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `movimiento_prod` (
  `id_movimiento_inv` BIGINT NOT NULL AUTO_INCREMENT,
  `fecha_movimiento` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cantidad_desplazada` INT NOT NULL,
  `motivo_repor` VARCHAR(255) NOT NULL,
  `picker_checker` INT NULL,
  `producto_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `tipo_movimiento_id` INT NOT NULL,
  PRIMARY KEY (`id_movimiento_inv`),
  INDEX `idx_movprod_producto` (`producto_id`),
  INDEX `idx_movprod_usuario` (`usuario_id`),
  INDEX `idx_movprod_tipo` (`tipo_movimiento_id`),
  CONSTRAINT `fk_movprod_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_movprod_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_movprod_tipo` FOREIGN KEY (`tipo_movimiento_id`) REFERENCES `tipo_movimiento` (`id_tipo_movimiento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `alerta_inv` (
  `id_alerta` INT NOT NULL AUTO_INCREMENT,
  `fecha_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_alerta` VARCHAR(50) NOT NULL,
  `descripcion_alerta` VARCHAR(255) NOT NULL,
  `producto_id` INT NOT NULL,
  PRIMARY KEY (`id_alerta`),
  INDEX `idx_alerta_producto` (`producto_id`),
  CONSTRAINT `fk_alerta_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `reporte_inv` (
  `id_reporte_inv` INT NOT NULL AUTO_INCREMENT,
  `fecha_generacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_reporte` VARCHAR(50) NOT NULL,
  `movimiento_prod_id` BIGINT NULL,
  `alerta_inv_id` INT NULL,
  `usuario_id` INT NOT NULL,
  `url_resultado` VARCHAR(255) NULL,
  PRIMARY KEY (`id_reporte_inv`),
  INDEX `idx_reporte_mov` (`movimiento_prod_id`),
  INDEX `idx_reporte_alerta` (`alerta_inv_id`),
  INDEX `idx_reporte_usuario` (`usuario_id`),
  CONSTRAINT `fk_reporte_movimiento` FOREIGN KEY (`movimiento_prod_id`) REFERENCES `movimiento_prod` (`id_movimiento_inv`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_reporte_alerta` FOREIGN KEY (`alerta_inv_id`) REFERENCES `alerta_inv` (`id_alerta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_reporte_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `metodo_proyeccion` (
  `id_metodo_proyeccion` INT NOT NULL AUTO_INCREMENT,
  `nombre_metodo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_metodo_proyeccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tipo_proyeccion` (
  `id_tipo_proyeccion` INT NOT NULL AUTO_INCREMENT,
  `nombre_proyeccion` VARCHAR(100) NULL,
  PRIMARY KEY (`id_tipo_proyeccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `proyecciones` (
  `id_proyecciones` INT NOT NULL AUTO_INCREMENT,
  `resultado_proyeccion` VARCHAR(255) NOT NULL,
  `referencia_tipo` VARCHAR(50) NOT NULL,
  `fecha_generacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `unidad_medida` VARCHAR(50) NOT NULL,
  `metodo_proyeccion_id` INT NOT NULL,
  `tipo_proyeccion_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_fin` DATETIME NULL,
  PRIMARY KEY (`id_proyecciones`),
  INDEX `idx_proy_metodo` (`metodo_proyeccion_id`),
  INDEX `idx_proy_tipo` (`tipo_proyeccion_id`),
  INDEX `idx_proy_categoria` (`categoria_id`),
  INDEX `idx_proy_producto` (`producto_id`),
  CONSTRAINT `fk_proy_metodo` FOREIGN KEY (`metodo_proyeccion_id`) REFERENCES `metodo_proyeccion` (`id_metodo_proyeccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_proy_tipo` FOREIGN KEY (`tipo_proyeccion_id`) REFERENCES `tipo_proyeccion` (`id_tipo_proyeccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_proy_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_proy_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `estado_pedido` (
  `id_estado_pedido` INT NOT NULL AUTO_INCREMENT,
  `nombre_estado` VARCHAR(100) NOT NULL,
  `descripcion_estado` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_estado_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `pedido_compra` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_pedido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total_pedido` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  `estado_pedido_id` INT NOT NULL,
  `proveedor_id` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `idx_pedido_estado` (`estado_pedido_id`),
  INDEX `idx_pedido_proveedor` (`proveedor_id`),
  CONSTRAINT `fk_pedido_estado` FOREIGN KEY (`estado_pedido_id`) REFERENCES `estado_pedido` (`id_estado_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `detalle_pedido` (
  `id_detalle_pedido` BIGINT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `subtotal` DECIMAL(12,2) NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  `pedido_compra_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  PRIMARY KEY (`id_detalle_pedido`),
  INDEX `idx_detallepedido_pedido` (`pedido_compra_id`),
  INDEX `idx_detallepedido_producto` (`producto_id`),
  CONSTRAINT `fk_detallepedido_pedido` FOREIGN KEY (`pedido_compra_id`) REFERENCES `pedido_compra` (`id_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detallepedido_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre_cliente` VARCHAR(150) NOT NULL,
  `identificacion_cliente` BIGINT NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

use inventario_medicamentos;
DROP TABLE IF exists venta_registro;

CREATE TABLE IF NOT EXISTS `venta_registro` (
  `id_venta` BIGINT NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `total_venta` DECIMAL(12,2) NULL DEFAULT 0.00,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `idx_venta_cliente` (`cliente_id`),
  CONSTRAINT `fk_venta_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE venta_registro DROP FOREIGN KEY fk_venta_usuario;

ALTER TABLE venta_registro MODIFY COLUMN usuario_id INT NULL;

ALTER TABLE venta_registro
ADD CONSTRAINT fk_venta_usuario
FOREIGN KEY (usuario_id)
REFERENCES usuario(id_usuario)
ON DELETE SET NULL
ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS `detalle_venta` (
  `id_detalle_venta` BIGINT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  `producto_id` INT NOT NULL,
  `venta_registro_id` BIGINT NOT NULL,
  PRIMARY KEY (`id_detalle_venta`),
  INDEX `idx_detalleventa_producto` (`producto_id`),
  INDEX `idx_detalleventa_venta` (`venta_registro_id`),
  CONSTRAINT `fk_detalleventa_producto` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleventa_venta` FOREIGN KEY (`venta_registro_id`) REFERENCES `venta_registro` (`id_venta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `filtro_busqueda` (
  `id_filtro_busqueda` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NULL,
  `fecha_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reporte_inv_id` INT NOT NULL,
  PRIMARY KEY (`id_filtro_busqueda`),
  INDEX `idx_filtro_reporte` (`reporte_inv_id`),
  CONSTRAINT `fk_filtro_reporte` FOREIGN KEY (`reporte_inv_id`) REFERENCES `reporte_inv` (`id_reporte_inv`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `detalle_filtro` (
  `id_detalle_filtro` INT NOT NULL AUTO_INCREMENT,
  `tipo_dato` VARCHAR(50) NULL,
  `campo_filtro` VARCHAR(100) NULL,
  `valor_filtro` VARCHAR(255) NULL,
  `filtro_busqueda_id` INT NOT NULL,
  PRIMARY KEY (`id_detalle_filtro`),
  INDEX `idx_detallefiltro_filtro` (`filtro_busqueda_id`),
  CONSTRAINT `fk_detallefiltro_filtro` FOREIGN KEY (`filtro_busqueda_id`) REFERENCES `filtro_busqueda` (`id_filtro_busqueda`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tipo_direccion` (
  `id_tipo_direccion` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(100) NULL,
  PRIMARY KEY (`id_tipo_direccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `barrio_direccion` (
  `id_barrio` INT NOT NULL AUTO_INCREMENT,
  `nombre_barrio` VARCHAR(100) NULL,
  PRIMARY KEY (`id_barrio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `direccion` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(255) NULL,
  `complemento` VARCHAR(255) NULL,
  `tipo_direccion_id` INT NOT NULL,
  `barrio_id` INT NOT NULL,
  `cliente_id` INT NULL,
  `proveedor_id` INT NULL,
  PRIMARY KEY (`id_direccion`),
  INDEX `idx_direccion_tipo` (`tipo_direccion_id`),
  INDEX `idx_direccion_barrio` (`barrio_id`),
  INDEX `idx_direccion_cliente` (`cliente_id`),
  INDEX `idx_direccion_proveedor` (`proveedor_id`),
  CONSTRAINT `fk_direccion_tipo` FOREIGN KEY (`tipo_direccion_id`) REFERENCES `tipo_direccion` (`id_tipo_direccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccion_barrio` FOREIGN KEY (`barrio_id`) REFERENCES `barrio_direccion` (`id_barrio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccion_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccion_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tipo_correo` (
  `id_tipo_correo` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tipo_correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `correo` (
  `id_correo` INT NOT NULL AUTO_INCREMENT,
  `correo_electronico` VARCHAR(150) NOT NULL,
  `tipo_correo_id` INT NOT NULL,
  `cliente_id` INT NULL,
  `proveedor_id` INT NULL,
  PRIMARY KEY (`id_correo`),
  INDEX `idx_correo_tipo` (`tipo_correo_id`),
  INDEX `idx_correo_cliente` (`cliente_id`),
  INDEX `idx_correo_proveedor` (`proveedor_id`),
  CONSTRAINT `fk_correo_tipo` FOREIGN KEY (`tipo_correo_id`) REFERENCES `tipo_correo` (`id_tipo_correo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_correo_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_correo_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tipo_telefono` (
  `id_tipo_telefono` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tipo_telefono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `telefono` (
  `id_telefono` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(100) NULL,
  `tipo_telefono_id` INT NOT NULL,
  `cliente_id` INT NULL,
  `proveedor_id` INT NULL,
  PRIMARY KEY (`id_telefono`),
  INDEX `idx_telefono_tipo` (`tipo_telefono_id`),
  INDEX `idx_telefono_cliente` (`cliente_id`),
  INDEX `idx_telefono_proveedor` (`proveedor_id`),
  CONSTRAINT `fk_telefono_tipo` FOREIGN KEY (`tipo_telefono_id`) REFERENCES `tipo_telefono` (`id_tipo_telefono`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefono_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefono_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tipo_estado` (
  `id_tipo_estado` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tipo_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `estado_usuario` (
  `id_estado_usuario` INT NOT NULL AUTO_INCREMENT,
  `observacion` VARCHAR(255) NULL,
  `fecha_inicio` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_fin` DATETIME NULL,
  `tipo_estado_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id_estado_usuario`),
  INDEX `idx_estadousuario_tipo` (`tipo_estado_id`),
  INDEX `idx_estadousuario_usuario` (`usuario_id`),
  CONSTRAINT `fk_estadousuario_tipo` FOREIGN KEY (`tipo_estado_id`) REFERENCES `tipo_estado` (`id_tipo_estado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_estadousuario_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

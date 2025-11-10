USE `inventario_medicamentos`;

INSERT INTO tipo_movimiento (id_tipo_movimiento, nombre_movimiento) VALUES
(1, 'Entrada'),
(2, 'Salida'),
(3, 'Ajuste');

INSERT INTO tipo_correo (id_tipo_correo, nombre_tipo) VALUES
(1, 'Personal'),
(2, 'Corporativo');

INSERT INTO tipo_telefono (id_tipo_telefono, nombre_tipo) VALUES
(1, 'Móvil'),
(2, 'Fijo');

INSERT INTO tipo_direccion (id_tipo_direccion, nombre_tipo) VALUES
(1, 'Domicilio'),
(2, 'Laboral');

INSERT INTO tipo_estado (id_tipo_estado, nombre_tipo) VALUES
(1, 'Activo'),
(2, 'Inactivo');

INSERT INTO estado_pedido (id_estado_pedido, nombre_estado, descripcion_estado) VALUES
(1, 'pendiente', 'Pedido generado, pendiente'),
(2, 'en_camino', 'Pedido en tránsito hacia la bodega'),
(3, 'recibido', 'Pedido recibido en bodega'),
(4, 'cancelado', 'Pedido cancelado');

INSERT INTO metodo_proyeccion (id_metodo_proyeccion, nombre_metodo) VALUES
(1, 'Promedio móvil'),
(2, 'Regresión lineal'),
(3, 'Descomposición'),
(4, 'Suavizado exponencial'),
(5, 'Heurística');

INSERT INTO tipo_proyeccion (id_tipo_proyeccion, nombre_proyeccion) VALUES
(1, 'Demanda mensual'),
(2, 'Consumo por unidad'),
(3, 'Reposición automática'),
(4, 'Estacionalidad'),
(5, 'Crecimiento esperado');

INSERT INTO usuario (id_usuario, contrasena, rol_usu, nombre_usu, correo_usu) VALUES
(1, MD5('Admin@2025'), 'administrador', 'Carlos Gómez', 'carlos.gomez@asurascol.com'),
(2, MD5('VendeR2025!'), 'vendedor', 'María Vargas', 'maria.vargas@asurascol.com'),
(3, MD5('Bodega#2025'), 'bodeguero', 'Jhonatan Pérez', 'jhonatan.perez@asurascol.com'),
(4, MD5('Analista*2025'), 'analista', 'Laura Rodríguez', 'laura.rodriguez@asurascol.com'),
(5, MD5('Asistente2025'), 'asistente', 'Andrés Moreno', 'andres.moreno@asurascol.com');

INSERT INTO categoria (id_categoria, nombre_cat) VALUES
(1,'Antibióticos'),
(2,'Analgésicos'),
(3,'Antiinflamatorios'),
(4,'Antipiréticos'),
(5,'Antihistamínicos'),
(6,'Antisépticos'),
(7,'Vacunas'),
(8,'Cardiológicos'),
(9,'Endocrinológicos'),
(10,'Gastrointestinales'),
(11,'Dermatológicos'),
(12,'Respiratorios'),
(13,'Urológicos'),
(14,'Neurológicos'),
(15,'Pediátricos'),
(16,'Oftalmológicos'),
(17,'Otorrinolaringológicos'),
(18,'Anticoagulantes'),
(19,'Antidiabéticos'),
(20,'Vitaminas y Suplementos'),
(21,'Inmunológicos'),
(22,'Antimicóticos'),
(23,'Antivirales'),
(24,'Anestésicos'),
(25,'Oncológicos'),
(26,'Renales'),
(27,'Sueros y Soluciones'),
(28,'Material Quirúrgico'),
(29,'Equipos Médicos'),
(30,'Insulinas'),
(31,'Antieméticos'),
(32,'Laxantes'),
(33,'Antitusivos'),
(34,'Antiespasmódicos'),
(35,'Productos de Higiene'),
(36,'Test Diagnóstico'),
(37,'Nutrición Clínica'),
(38,'Antiparasitarios'),
(39,'Productos de Reposición'),
(40,'Otros');

INSERT INTO proveedor (id_proveedor, nombre_prov) VALUES
(1,'Distribuciones Farma S.A.'),
(2,'Laboratorios Nacionales S.A.'),
(3,'Salud y Vida Ltda.'),
(4,'MedicPro Distribuciones'),
(5,'Insumos Médicos del Norte'),
(6,'Central Farmacéutica'),
(7,'Proveedora Hospitalaria'),
(8,'BioQuímica y Cía.'),
(9,'Suministros Clínicos SAS'),
(10,'Global Medical Supplies');

ALTER TABLE producto
ADD CONSTRAINT chk_stock_no_negativo CHECK (stock >= 0);

ALTER TABLE producto
ADD CONSTRAINT chk_fecha_expiracion_valida CHECK (fecha_expiracion > '2000-01-01');

INSERT INTO producto (id_producto, nombre_prod, fecha_expiracion, stock, categoria_id, usuario_id, lote_producto) VALUES
(1,'Amoxicilina 500mg', '2026-06-15 00:00:00', 120, 1, 1, 20250101),
(2,'Amoxicilina 250mg', '2024-09-10 00:00:00', 40, 1, 1, 20250102),
(3,'Ciprofloxacino 500mg', '2025-12-01 00:00:00', 300, 1, 1, 20250201),
(4,'Azitromicina 250mg', '2024-11-20 00:00:00', 10, 2, 2, 20250301),
(5,'Claritromicina 500mg', '2026-01-30 00:00:00', 60, 1, 2, 20250401),

(6,'Ibuprofeno 400mg', '2026-03-10 00:00:00', 500, 3, 2, 20250501),
(7,'Naproxeno 500mg', '2025-07-05 00:00:00', 80, 3, 2, 20250601),
(8,'Diclofenaco 50mg', '2024-10-01 00:00:00', 4, 3, 3, 20250701),
(9,'Paracetamol 500mg', '2027-02-28 00:00:00', 1000, 4, 3, 20250801),
(10,'Metamizol 1g', '2025-01-12 00:00:00', 70, 4, 3, 20250901),

(11,'Loratadina 10mg', '2026-08-15 00:00:00', 220, 5, 1, 20251001),
(12,'Cetirizina 10mg', '2025-09-30 00:00:00', 150, 5, 1, 20251101),
(13,'Clorfenamina 4mg', '2024-12-12 00:00:00', 5, 5, 1, 20251201),
(14,'Alcohol 70% 500ml', '2027-05-01 00:00:00', 400, 6, 4, 20260101),
(15,'Yodo Povidona 10%', '2026-04-20 00:00:00', 180, 6, 4, 20260201),

(16,'Vacuna Influenza 2025', '2025-11-01 00:00:00', 200, 7, 4, 20260301),
(17,'Vacuna Hepatitis B', '2028-02-14 00:00:00', 90, 7, 5, 20260401),
(18,'Atorvastatina 20mg', '2026-09-10 00:00:00', 160, 8, 5, 20260501),
(19,'Enalapril 10mg', '2025-03-03 00:00:00', 75, 8, 5, 20260601),
(20,'Metformina 850mg', '2026-06-06 00:00:00', 340, 9, 5, 20260701),

(21,'Omeprazol 20mg', '2027-01-01 00:00:00', 430, 10, 1, 20260801),
(22,'Sucralfato 1g', '2025-04-12 00:00:00', 60, 10, 1, 20260901),
(23,'Clotrimazol crema 1%', '2026-10-10 00:00:00', 260, 11, 2, 20261001),
(24,'Salbutamol inhalador', '2025-12-31 00:00:00', 55, 12, 2, 20261101),
(25,'Beclometasona aerosol', '2026-07-07 00:00:00', 40, 12, 3, 20261201),

(26,'Tamsulosina 0.4mg', '2026-08-08 00:00:00', 95, 13, 3, 20270101),
(27,'Gabapentina 300mg', '2025-05-05 00:00:00', 35, 14, 4, 20270201),
(28,'Metildopa 250mg', '2024-09-01 00:00:00', 3, 14, 4, 20270301),
(29,'Paracetamol pediátrico 120mg', '2027-03-03 00:00:00', 420, 15, 4, 20270401),
(30,'Gotas oftálmicas 0.5%', '2026-02-02 00:00:00', 140, 16, 5, 20270501),

(31,'Solución salina 0.9% 500ml', '2028-09-09 00:00:00', 620, 27, 5, 20270601),
(32,'Vendaje estéril 10x10', '2030-01-01 00:00:00', 350, 28, 2, 20270701),
(33,'Guantes Nitrilo M', '2026-11-11 00:00:00', 1200, 35, 2, 20270801),
(34,'Termómetro digital', '2030-05-05 00:00:00', 45, 29, 2, 20270901),
(35,'Insulina Glargina 100IU', '2025-10-10 00:00:00', 50, 30, 1, 20271001),

(36,'Ondansetrón 4mg', '2026-06-06 00:00:00', 210, 31, 3, 20271101),
(37,'Laxante oral 100ml', '2025-02-02 00:00:00', 150, 32, 2, 20271201),
(38,'Jarabe antitusivo 100ml', '2024-08-08 00:00:00', 2, 33, 5, 20280101),
(39,'Espasmo-relajante 10mg', '2026-03-03 00:00:00', 90, 34, 5, 20280201),
(40,'Toallitas húmedas 72u', '2027-09-09 00:00:00', 540, 35, 1, 20280301),

(41,'Kit prueba COVID-19', '2025-12-31 00:00:00', 120, 36, 1, 20280401),
(42,'Nutrición enteral 1L', '2026-04-04 00:00:00', 80, 37, 1, 20280501),
(43,'Albendazol 400mg', '2025-06-06 00:00:00', 300, 38, 1, 20280601),
(44,'Producto reposición genérico', '2028-12-12 00:00:00', 200, 39, 2, 20280701),
(45,'Cepillo interdental', '2030-12-12 00:00:00', 1000, 35, 2, 20280801),

(46,'Mascarilla N95', '2027-11-11 00:00:00', 900, 35, 3, 20280901),
(47,'Solución desinfectante 1L', '2026-09-09 00:00:00', 150, 6, 3, 20281001),
(48,'Crema cicatrizante 30g', '2025-07-07 00:00:00', 65, 11, 4, 20281101),
(49,'Antigripal 500mg', '2024-11-01 00:00:00', 1, 4, 5, 20281201),
(50,'Sonda Foley 16Fr', '2029-05-05 00:00:00', 40, 28, 5, 20290101);

ALTER TABLE detalle_proveedor_producto
ADD CONSTRAINT chk_precio_negativo CHECK (precio_unitario > 0);
 
 INSERT INTO detalle_proveedor_producto (producto_id, proveedor_id, precio_unitario) VALUES
(1,1, 3500.00),(2,1,2100.00),(3,1,4200.00),(4,1,5000.00),(5,1,6000.00),
(6,2, 800.00),(7,2,1200.00),(8,2,900.00),(9,2,350.00),(10,2,650.00),
(11,3,700.00),(12,3,600.00),(13,3,550.00),(14,3,2200.00),(15,3,3100.00),
(16,4,7500.00),(17,4,8800.00),(18,4,1100.00),(19,4,950.00),(20,4,880.00),
(21,5,500.00),(22,5,1450.00),(23,5,2300.00),(24,5,12000.00),(25,5,10500.00),
(26,6,1300.00),(27,6,2100.00),(28,6,750.00),(29,6,400.00),(30,6,3000.00),
(31,7,250.00),(32,7,1000.00),(33,7,120.00),(34,7,15000.00),(35,7,25000.00),
(36,8,2200.00),(37,8,1800.00),(38,8,1400.00),(39,8,950.00),(40,8,100.00),
(41,9,6500.00),(42,9,18000.00),(43,9,300.00),(44,9,1000.00),(45,9,200.00),
(46,10,900.00),(47,10,3500.00),(48,10,2600.00),(49,10,400.00),(50,10,5000.00);

INSERT INTO cliente (id_cliente, nombre_cliente, identificacion_cliente) VALUES
(1,'Clínica San Rafael', 900100100),
(2,'Hospital Central', 900100101),
(3,'Centro de Salud Norte', 900100102),
(4,'Farmacia La Salud', 900100103),
(5,'Dispensario El Buen Trato', 900100104),
(6,'Consultorio Vida', 900100105),
(7,'Centro Médico Sur', 900100106),
(8,'Farmacia Popular', 900100107),
(9,'Instituto Pediátrico', 900100108),
(10,'Laboratorio Analítico', 900100109),
(11,'Ambulatorio Nuevo Amanecer', 900100110),
(12,'Casa de Reposo Santa María', 900100111),
(13,'Clínica La Esperanza', 900100112),
(14,'Centro de Rehabilitación', 900100113),
(15,'Despacho Médico Privado', 900100114),
(16,'Centro Odontológico', 900100115),
(17,'Fundación Saludable', 900100116),
(18,'Centro de Especialidades', 900100117),
(19,'Emergencias Rápidas', 900100118),
(20,'Pediatría Integral', 900100119),
(21,'Farmacias Unidas', 900100120),
(22,'Hospital Regional', 900100121),
(23,'Clínica Santa Lucía', 900100122),
(24,'Centro Médico Integral', 900100123),
(25,'Juanita Pérez', 110200300);

ALTER TABLE correo
ADD CONSTRAINT chk_correo_cliente_o_proveedor
CHECK (
    (cliente_id IS NOT NULL AND proveedor_id IS NULL)
 OR (cliente_id IS NULL AND proveedor_id IS NOT NULL)
);

INSERT INTO barrio_direccion (id_barrio, nombre_barrio) VALUES
(1,'Centro'),(2,'Norte'),(3,'Sur'),(4,'Occidente'),(5,'Oriente');

INSERT INTO correo (id_correo, correo_electronico, tipo_correo_id, cliente_id, proveedor_id) VALUES
(1,'contacto@clinicasanrafael.com',2,NULL,1),
(2,'facturacion@clinicasanrafael.com',1,1,NULL),
(3,'contacto@hospitalcentral.com',2,NULL,2),
(4,'facturacion@hospitalcentral.com',1,2,NULL),
(5,'contacto@centrosaludnorte.com',2,NULL,3),
(6,'facturacion@centrosaludnorte.com',1,3,NULL),
(7,'contacto@farmacialasalud.com',2,NULL,4),
(8,'facturacion@farmacialasalud.com',1,4,NULL),
(9,'contacto@dispensariobuentrato.com',2,NULL,5),
(10,'facturacion@dispensariobuentrato.com',1,5,NULL),
(11,'contacto@consultoriovida.com',2,NULL,6),
(12,'facturacion@consultoriovida.com',1,6,NULL),
(13,'contacto@centromedicosur.com',2,NULL,7),
(14,'facturacion@centromedicosur.com',1,7,NULL),
(15,'contacto@farmaciapopular.com',2,NULL,8),
(16,'facturacion@farmaciapopular.com',1,8,NULL),
(17,'contacto@institutopediatrico.com',2,NULL,9),
(18,'facturacion@institutopediatrico.com',1,9,NULL),
(19,'contacto@laboratorioanalitico.com',2,NULL,10),
(20,'facturacion@laboratorioanalitico.com',1,10,NULL),
(21,'contacto@ambulatorionuevoamanecer.com',2,11,NULL),
(22,'facturacion@ambulatorionuevoamanecer.com',1,11,NULL),
(23,'contacto@repososantamaria.com',2,12,NULL),
(24,'facturacion@repososantamaria.com',1,12,NULL),
(25,'contacto@clinicaesperanza.com',2,13,NULL),
(26,'facturacion@clinicaesperanza.com',1,13,NULL),
(27,'contacto@rehabilitacion.com',2,14,NULL),
(28,'facturacion@rehabilitacion.com',1,14,NULL),
(29,'contacto@despachomedico.com',2,15,NULL),
(30,'facturacion@despachomedico.com',1,15,NULL),
(31,'contacto@centroodontologico.com',2,16,NULL),
(32,'facturacion@centroodontologico.com',1,16,NULL),
(33,'contacto@fundacionsaludable.com',2,17,NULL),
(34,'facturacion@fundacionsaludable.com',1,17,NULL),
(35,'contacto@centroespecialidades.com',2,18,NULL),
(36,'facturacion@centroespecialidades.com',1,NULL,7),
(37,'contacto@emergenciasrapidas.com',2,19,NULL),
(38,'facturacion@emergenciasrapidas.com',1,19,NULL),
(39,'contacto@pediatriaintegral.com',2,20,NULL),
(40,'facturacion@pediatriaintegral.com',1,NULL,5),
(41,'contacto@farmaciasunidas.com',2,21,NULL),
(42,'facturacion@farmaciasunidas.com',1,21,NULL),
(43,'contacto@hospitalregional.com',2,22,NULL),
(44,'facturacion@hospitalregional.com',1,NULL,2),
(45,'contacto@clinicasantalucia.com',2,23,NULL),
(46,'facturacion@clinicasantalucia.com',1,23,NULL),
(47,'contacto@centromedicointegral.com',2,24,NULL),
(48,'facturacion@centromedicointegral.com',1,NULL,10),
(49,'juanita.personal@mail.com',1,25,NULL),
(50,'juanita.corp@mail.com',2,25,NULL);

ALTER TABLE telefono
ADD CONSTRAINT chk_tel_cliente_o_proveedor
CHECK (
    (cliente_id IS NOT NULL AND proveedor_id IS NULL)
 OR (cliente_id IS NULL AND proveedor_id IS NOT NULL)
);

INSERT INTO telefono (id_telefono, numero, complemento, tipo_telefono_id, cliente_id, proveedor_id) VALUES
(1,'3001234567',NULL,1,1,NULL),
(2,'6011234567',NULL,2,1,NULL),
(3,'3001234568',NULL,1,2,NULL),
(4,'6011234568',NULL,2,2,NULL),
(5,'3001234569',NULL,1,3,NULL),
(6,'6011234569',NULL,2,3,NULL),
(7,'3001234570',NULL,1,4,NULL),
(8,'6011234570',NULL,2,4,NULL),
(9,'3001234571',NULL,1,5,NULL),
(10,'6011234571',NULL,2,5,NULL),
(11,'3001234572',NULL,1,6,NULL),
(12,'6011234572',NULL,2,6,NULL),
(13,'3001234573',NULL,1,7,NULL),
(14,'6011234573',NULL,2,7,NULL),
(15,'3001234574',NULL,1,8,NULL),
(16,'6011234574',NULL,2,8,NULL),
(17,'3001234575',NULL,1,9,NULL),
(18,'6011234575',NULL,2,9,NULL),
(19,'3001234576',NULL,1,10,NULL),
(20,'6011234576',NULL,2,10,NULL),
(21,'3001234577',NULL,1,11,NULL),
(22,'6011234577',NULL,2,11,NULL),
(23,'3001234578',NULL,1,12,NULL),
(24,'6011234578',NULL,2,12,NULL),
(25,'3001234579',NULL,1,13,NULL),
(26,'6011234579',NULL,2,13,NULL),
(27,'3001234580',NULL,1,14,NULL),
(28,'6011234580',NULL,2,14,NULL),
(29,'3001234581',NULL,1,15,NULL),
(30,'6011234581',NULL,2,15,NULL),
(31,'3001234582',NULL,1,16,NULL),
(32,'6011234582',NULL,2,16,NULL),
(33,'3001234583',NULL,1,17,NULL),
(34,'6011234583',NULL,2,17,NULL),
(35,'3001234584',NULL,1,18,NULL),
(36,'6011234584',NULL,2,18,NULL),
(37,'3001234585',NULL,1,19,NULL),
(38,'6011234585',NULL,2,19,NULL),
(39,'3001234586',NULL,1,20,NULL),
(40,'601-3456789',NULL,2, NULL, 1),
(41, '3004567890',NULL, 1,NULL, 1),
(42, '602-9876543',NULL,2, NULL, 2),
(43, '3125678901',NULL,1, NULL, 2),
(44, '604-2345678',NULL,2,NULL, 3),
(45, '3102345678',NULL,1 ,NULL, 3),
(46, '605-6789123',NULL,2,NULL, 4),
(47, '3139876543', NULL,1, NULL, 4),
(48, '607-2233445', NULL,2,NULL, 5),
(49, '3204567891', NULL,1,NULL, 6),
(50, '3225332138', NULL,1,NULL, 8);

ALTER TABLE direccion
ADD CONSTRAINT chk_dir_cliente_o_proveedor
CHECK (
    (cliente_id IS NOT NULL AND proveedor_id IS NULL)
 OR (cliente_id IS NULL AND proveedor_id IS NOT NULL)
);

INSERT INTO direccion (id_direccion, direccion, complemento, tipo_direccion_id, barrio_id, cliente_id, proveedor_id) VALUES
(1,'Cra 10 #20-30',NULL,1,1,1,NULL),
(2,'Av 5 #45-10',NULL,2,1,1,NULL),
(3,'Cll 30 #10-20',NULL,1,2,2,NULL),
(4,'Av 7 #22-11',NULL,2,2,2,NULL),
(5,'Calle 12 #4-56',NULL,1,3,3,NULL),
(6,'Av 2 #56-78',NULL,2,3,3,NULL),
(7,'Cra 2 #10-01',NULL,1,4,4,NULL),
(8,'Av 9 #34-90',NULL,2,4,4,NULL),
(9,'Cll 55 #2-11',NULL,1,5,5,NULL),
(10,'Av 11 #100-2',NULL,2,5,5,NULL),
(11,'Cll 3 #45-67',NULL,1,1,6,NULL),
(12,'Av 6 #12-13',NULL,2,1,6,NULL),
(13,'Cra 15 #7-09',NULL,1,2,7,NULL),
(14,'Av 13 #44-19',NULL,2,2,7,NULL),
(15,'Cll 77 #88-01',NULL,1,3,8,NULL),
(16,'Av 14 #2-22',NULL,2,3,8,NULL),
(17,'Cll 9 #3-55',NULL,1,4,9,NULL),
(18,'Av 1 #1-01',NULL,2,4,9,NULL),
(19,'Cll 8 #21-33',NULL,1,5,10,NULL),
(20,'Av 4 #7-99',NULL,2,5,10,NULL),
(21,'Cll 45 #12-22',NULL,1,1,11,NULL),
(22,'Av 15 #33-44',NULL,2,1,11,NULL),
(23,'Cll 18 #6-18',NULL,1,2,12,NULL),
(24,'Av 20 #20-20',NULL,2,2,12,NULL),
(25,'Cll 29 #2-02',NULL,1,3,13,NULL),
(26,'Av 22 #22-22',NULL,2,3,13,NULL),
(27,'Cll 39 #12-12',NULL,1,4,14,NULL),
(28,'Av 27 #7-77',NULL,2,4,14,NULL),
(29,'Cll 101 #1-01',NULL,1,5,15,NULL),
(30,'Av 30 #16-16',NULL,2,5,15,NULL),
(31,'Cll 2 #2-02',NULL,1,1,16,NULL),
(32,'Av 31 #3-03',NULL,2,1,16,NULL),
(33,'Cll 6 #66-66',NULL,1,2,17,NULL),
(34,'Av 32 #7-88',NULL,2,2,17,NULL),
(35,'Cll 14 #14-14',NULL,1,3,18,NULL),
(36,'Av 33 #9-09',NULL,2,3,18,NULL),
(37,'Cll 23 #23-23',NULL,1,4,19,NULL),
(38,'Av 35 #11-11',NULL,2,4,19,NULL),
(39,'Cll 26 #4-44',NULL,1,5,20,NULL),
(40,'Av 36 #12-12',NULL,2,5,20,NULL),
(41,'Cll 40 #40-40',NULL,1,1,21,NULL),
(42,'Av 38 #5-55',NULL,2,1,21,NULL),
(43,'Cll 50 #7-77',NULL,1,2,22,NULL),
(44,'Av 41 #9-99',NULL,2,2,22,NULL),
(45,'Cll 11 #11-11',NULL,1,3,23,NULL),
(46,'Av 42 #14-14',NULL,2,3,23,NULL),
(47,'Cll 21 #21-21',NULL,1,4,24,NULL),
(48,'Av 44 #8-08',NULL,2,4,24,NULL),
(49,'Cll 66 #6-06',NULL,1,5,25,NULL),
(50,'Av 45 #2-02',NULL,2,5,25,NULL),
(51,'CRRA 72 #12-47',NULL,2,5,NULL,1),
(52,'Av 60 #60-12',NULL,2,5,NULL,2),
(53,'Av 70 #70-12',NULL,2,5,NULL,3),
(54,'Av 80 #80-22',NULL,2,2,NULL,4),
(55,'Av 100 #100-98',NULL,2,1,NULL,5),
(56,'Av 110 #110-50',NULL,2,1,NULL,6),
(57,'CLL 12 #12-42',NULL,2,3,NULL,7),
(58,'CLL 30 #30-45',NULL,2,3,NULL,8),
(59,'CLL 30 #30-78',NULL,2,2,NULL,9),
(60,'CLL 72 #72-24',NULL,2,5,NULL,10);

ALTER TABLE pedido_compra
ADD CONSTRAINT chk_fecha_valida CHECK (fecha_pedido > '2000-01-01');

ALTER TABLE pedido_compra
ADD CONSTRAINT chk_valor_pedido CHECK (total_pedido > 0);

INSERT INTO pedido_compra (id_pedido, fecha_pedido, total_pedido, estado_pedido_id, proveedor_id) VALUES
(1,'2025-10-01 10:00:00', 350000.00, 2, 1),
(2,'2025-10-02 11:30:00', 420500.00, 2, 2),
(3,'2025-10-03 09:15:00', 150000.00, 3, 3),
(4,'2025-10-04 14:10:00', 780000.00, 1, 4),
(5,'2025-10-05 08:20:00', 120000.00, 2, 5),
(6,'2025-09-28 12:00:00', 500000.00, 2, 6),
(7,'2025-09-29 15:00:00', 230000.00, 2, 7),
(8,'2025-10-06 10:10:00', 90000.00, 1, 8),
(9,'2025-10-07 16:45:00', 640000.00, 2, 9),
(10,'2025-10-08 07:50:00', 300000.00, 3, 10),
(11,'2025-10-09 12:12:00', 145000.00, 2, 1),
(12,'2025-10-09 13:13:00', 220000.00, 2, 2),
(13,'2025-10-10 09:00:00', 410000.00, 2, 3),
(14,'2025-10-11 11:11:00', 95000.00, 2, 4),
(15,'2025-10-12 10:10:00', 560000.00, 1, 5),
(16,'2025-10-13 09:09:00', 125000.00, 2, 6),
(17,'2025-10-14 08:08:00', 320000.00, 2, 7),
(18,'2025-10-15 07:07:00', 205000.00, 2, 8),
(19,'2025-10-16 06:06:00', 410000.00, 2, 9),
(20,'2025-10-17 05:05:00', 275000.00, 2, 10);

ALTER TABLE detalle_pedido
ADD CONSTRAINT chk_cantidad CHECK (cantidad > 0),
ADD CONSTRAINT chk_subtotal CHECK (subtotal >= 0),
ADD CONSTRAINT chk_precio_unitario_valido CHECK (precio_unitario > 0);

INSERT INTO detalle_pedido (id_detalle_pedido, cantidad, subtotal, precio_unitario, pedido_compra_id, producto_id) VALUES
(1,50,175000.00,3500.00,1,1),
(2,100,210000.00,2100.00,1,2),
(3,20,84000.00,4200.00,2,3),
(4,10,50000.00,5000.00,2,4),
(5,20,120000.00,6000.00,3,5),
(6,200,160000.00,800.00,4,6),
(7,50,60000.00,1200.00,4,7),
(8,10,9000.00,900.00,5,8),
(9,300,105000.00,350.00,5,9),
(10,70,45500.00,650.00,6,10),
(11,100,70000.00,700.00,6,11),
(12,50,30000.00,600.00,7,12),
(13,5,2750.00,550.00,7,13),
(14,200,440000.00,2200.00,8,14),
(15,50,155000.00,3100.00,8,15),
(16,20,150000.00,7500.00,9,16),
(17,10,88000.00,8800.00,9,17),
(18,30,33000.00,1100.00,10,18),
(19,20,19000.00,950.00,10,19),
(20,100,88000.00,880.00,11,20),
(21,50,25000.00,500.00,11,21),
(22,60,87000.00,1450.00,12,22),
(23,40,92000.00,2300.00,12,23),
(24,20,240000.00,12000.00,13,24),
(25,10,105000.00,10500.00,13,25),
(26,30,39000.00,1300.00,14,26),
(27,15,31500.00,2100.00,14,27),
(28,5,3750.00,750.00,15,28),
(29,200,80000.00,400.00,15,29),
(30,10,30000.00,3000.00,16,30),
(31,500,125000.00,250.00,16,31),
(32,100,100000.00,1000.00,17,32),
(33,50,6000.00,120.00,17,33),
(34,5,75000.00,15000.00,18,34),
(35,2,50000.00,25000.00,18,35),
(36,40,88000.00,2200.00,19,36),
(37,30,54000.00,1800.00,19,37),
(38,10,14000.00,1400.00,20,38),
(39,80,76000.00,950.00,20,39),
(40,100,10000.00,100.00,20,40);

ALTER TABLE movimiento_prod
ADD CONSTRAINT chk_fecha_movimiento_valida CHECK (fecha_movimiento > '2000-01-01');

INSERT INTO movimiento_prod (id_movimiento_inv, fecha_movimiento, cantidad_desplazada, motivo_repor, picker_checker, producto_id, usuario_id, tipo_movimiento_id) VALUES
(1,'2025-10-01 10:15:00', 240, 'Compra recibida', 1, 1, 1, 1),
(2,'2025-10-02 11:00:00', 120, 'Venta facturada', 2, 9, 2, 2),
(3,'2025-10-02 11:05:00', 50, 'Ajuste por conteo', 3, 2, 3, 3),
(4,'2025-10-03 09:30:00', 30, 'Compra recibida', 1, 3, 1, 1),
(5,'2025-10-04 14:00:00', 10, 'Venta', 2, 4, 2, 2),
(6,'2025-10-05 08:30:00', 20, 'Devolución proveedor', 1, 5, 1, 1),
(7,'2025-10-06 10:20:00', 200, 'Compra', 1, 6, 1, 1),
(8,'2025-10-07 16:50:00', 80, 'Venta mayorista', 2, 7, 2, 2),
(9,'2025-10-08 07:55:00', 4, 'Ajuste por daño', 3, 8, 3, 3),
(10,'2025-10-09 12:15:00', 120, 'Compra', 1, 11, 1, 1),
(11,'2025-10-09 13:20:00', 150, 'Venta', 2, 12, 2, 2),
(12,'2025-10-10 09:05:00', 50, 'Compra', 1, 14, 1, 1),
(13,'2025-10-10 09:10:00', 20, 'Venta', 2, 15, 2, 2),
(14,'2025-10-11 11:05:00', 100, 'Compra', 1, 16, 1, 1),
(15,'2025-10-12 10:00:00', 10, 'Venta', 2, 17, 2, 2),
(16,'2025-10-13 09:30:00', 5, 'Ajuste inventario', 3, 18, 3, 3),
(17,'2025-10-14 08:45:00', 30, 'Compra', 1, 21, 1, 1),
(18,'2025-10-15 07:40:00', 50, 'Venta', 2, 20, 2, 2),
(19,'2025-10-16 06:20:00', 200, 'Compra', 1, 31, 1, 1),
(20,'2025-10-17 05:00:00', 300, 'Compra', 1, 33, 1, 1),
(21,'2025-10-17 08:00:00', 2, 'Venta', 2, 38, 2, 2),
(22,'2025-10-17 09:00:00', 1, 'Venta', 2, 49, 2, 2),
(23,'2025-10-17 10:00:00', 20, 'Ajuste por discrepancia', 3, 27, 3, 3),
(24,'2025-10-17 11:00:00', 40, 'Compra', 1, 24, 1, 1),
(25,'2025-10-18 09:00:00', 15, 'Venta', 2, 35, 2, 2);

ALTER TABLE venta_registro
ADD CONSTRAINT chk_fecha_compra_valida CHECK (fecha_venta > '2000-01-01'),
ADD CONSTRAINT chk_total_venta_valida CHECK (total_venta > 0);

INSERT INTO venta_registro (id_venta, fecha_venta, total_venta, cliente_id) VALUES
(1,'2025-10-02 11:00:00', 420000.00, 4),
(2,'2025-10-03 09:40:00', 12000.00, 8),
(3,'2025-10-04 14:05:00', 5500.00, 5),
(4,'2025-10-05 08:50:00', 300000.00, 6),
(5,'2025-10-06 10:30:00', 880000.00, 11),
(6,'2025-10-07 16:55:00', 15000.00, 7),
(7,'2025-10-08 08:00:00', 7500.00, 10),
(8,'2025-10-09 12:30:00', 220000.00, 12),
(9,'2025-10-09 13:30:00', 4800.00, 15),
(10,'2025-10-10 09:20:00', 200000.00, 13),
(11,'2025-10-11 11:30:00', 95000.00, 2),
(12,'2025-10-12 10:45:00', 560000.00, 14),
(13,'2025-10-13 09:40:00', 410000.00, 3),
(14,'2025-10-14 08:10:00', 125000.00, 16),
(15,'2025-10-15 07:05:00', 320000.00, 9),
(16,'2025-10-15 12:00:00', 205000.00, 17),
(17,'2025-10-16 06:25:00', 410000.00, 19),
(18,'2025-10-16 17:45:00', 275000.00, 20),
(19,'2025-10-16 18:10:00', 145000.00, 21),
(20,'2025-10-17 09:30:00', 220000.00, 22);

ALTER TABLE detalle_venta
ADD CONSTRAINT chk_cantidad_vendida_valida CHECK (cantidad > 0),
ADD CONSTRAINT chk_precio_unitario_venta_valido CHECK (precio_unitario >= 100);

INSERT INTO detalle_venta (id_detalle_venta, cantidad, precio_unitario, producto_id, venta_registro_id) VALUES
(1,120,350.00,9,1),
(2,20,1200.00,7,1),
(3,5,900.00,8,2),
(4,10,650.00,10,3),
(5,40,700.00,11,4),
(6,15,600.00,12,5),
(7,2,550.00,13,6),
(8,5,2200.00,14,7),
(9,8,3100.00,15,8),
(10,10,7500.00,16,9),
(11,12,950.00,19,10),
(12,20,880.00,20,11),
(13,30,500.00,21,12),
(14,6,1450.00,22,13),
(15,3,2300.00,23,14),
(16,4,12000.00,24,15),
(17,2,25000.00,35,16),
(18,50,250.00,31,17),
(19,10,18000.00,42,18),
(20,5,400.00,49,19),
(21,20,1300.00,26,20);

ALTER TABLE alerta_inv
ADD CONSTRAINT chk_fecha_creacion_valida CHECK (fecha_creacion > '2000-01-01');

INSERT INTO alerta_inv (id_alerta, fecha_creacion, tipo_alerta, descripcion_alerta, producto_id) VALUES
(1, '2025-10-10 09:00:00', 'stock_bajo', 'Stock por debajo del umbral crítico', 8),
(2, '2025-10-11 08:00:00', 'stock_bajo', 'Stock por debajo del umbral crítico', 28),
(3, '2025-10-12 10:00:00', 'stock_bajo', 'Stock por debajo del umbral crítico', 38),
(4, '2025-10-13 09:45:00', 'stock_bajo', 'Stock por debajo del umbral crítico', 49),
(5, '2025-10-14 07:30:00', 'stock_bajo', 'Stock por debajo del umbral crítico', 13),
(6, '2024-10-01 00:00:00', 'vencimiento', 'Producto con fecha de expiración pasada', 2),
(7, '2024-11-01 00:00:00', 'vencimiento', 'Producto con fecha de expiración pasada', 4),
(8, '2024-08-09 00:00:00', 'vencimiento', 'Producto con fecha de expiración pasada', 28),
(9, '2024-09-15 00:00:00', 'vencimiento', 'Producto con fecha de expiración pasada', 38),
(10,'2024-10-20 00:00:00', 'vencimiento', 'Producto con fecha de expiración pasada', 49);

ALTER TABLE reporte_inv
ADD CONSTRAINT chk_fecha_reporte_valida CHECK (fecha_generacion > '2000-01-01');

INSERT INTO reporte_inv (id_reporte_inv, fecha_generacion, tipo_reporte, movimiento_prod_id, alerta_inv_id, usuario_id, url_resultado) VALUES
(1,'2025-10-12 10:30:00','stock_resumen',1,NULL,1,NULL),
(2,'2025-10-13 11:00:00','vencidos',NULL,6,1,NULL),
(3,'2025-10-14 09:00:00','movimientos_periodo',2,NULL,2,NULL),
(4,'2025-10-15 08:00:00','proveedores_entregas',3,NULL,1,NULL),
(5,'2025-10-16 07:00:00','reporte_general',NULL,8,5,NULL);

ALTER TABLE filtro_busqueda
ADD CONSTRAINT chk_fecha_filtro_valida CHECK (fecha_creacion > '2000-01-01');

INSERT INTO filtro_busqueda (id_filtro_busqueda, descripcion, fecha_creacion, reporte_inv_id) VALUES
(1,'Stock menor a 50','2025-10-12 10:00:00',1),
(2,'Vencidos hasta 2025-09-30','2025-10-13 10:50:00',2),
(3,'Movimientos usuario 2 entre fechas','2025-10-14 08:50:00',3),
(4,'Entregas proveedor 3 en mes','2025-10-15 07:50:00',4),
(5,'Resumen general mes actual','2025-10-16 06:50:00',5);

INSERT INTO detalle_filtro (id_detalle_filtro, tipo_dato, campo_filtro, valor_filtro, filtro_busqueda_id) VALUES
(1,'int','stock','<50',1),
(2,'date','fecha_expiracion','2025-09-30',2),
(3,'int','usuario_id','2',3),
(4,'varchar','proveedor_id','3',4),
(5,'varchar','periodo','2025-10',5);

ALTER TABLE proyecciones
ADD CONSTRAINT chk_fecha_proyeccion_valida CHECK (fecha_generacion > '2000-01-01');

INSERT INTO proyecciones (id_proyecciones, resultado_proyeccion, referencia_tipo, fecha_generacion, unidad_medida, metodo_proyeccion_id, tipo_proyeccion_id, categoria_id, producto_id, fecha_inicio, fecha_fin) VALUES
(1,'Aumento demanda 10%','demanda_mensual','2025-09-01 00:00:00','unidades',1,1,1,1,'2025-10-01 00:00:00','2025-12-31 00:00:00'),
(2,'Reducción consumo 5%','demanda_mensual','2025-09-02 00:00:00','unidades',2,1,2,6,'2025-10-01 00:00:00','2026-03-31 00:00:00'),
(3,'Reponer cada 30 días','reposición','2025-09-03 00:00:00','unidades',3,3,10,21,'2025-10-01 00:00:00','2026-10-01 00:00:00'),
(4,'Estacional: pico invierno','estacionalidad','2025-09-04 00:00:00','unidades',4,4,12,24,'2025-11-01 00:00:00','2026-02-28 00:00:00'),
(5,'Crecimiento 3% mensual','proyección general','2025-09-05 00:00:00','unidades',5,5,20,31,'2025-10-01 00:00:00','2026-10-01 00:00:00');

INSERT INTO estado_usuario (id_estado_usuario, observacion, fecha_inicio, fecha_fin, tipo_estado_id, usuario_id) VALUES
(1,'Activo desde creación','2025-01-01 00:00:00',NULL,1,1),
(2,'Activo','2025-02-01 00:00:00',NULL,1,2),
(3,'Activo','2025-03-01 00:00:00',NULL,1,3),
(4,'Inactivo temporal','2024-12-01 00:00:00','2025-01-15 00:00:00',2,4),
(5,'Activo','2025-04-01 00:00:00',NULL,1,5);

/* INDICES */

CREATE INDEX idx_producto_stock ON producto (stock);
CREATE INDEX idx_producto_expiracion ON producto (fecha_expiracion);
CREATE INDEX idx_movimiento_fecha ON movimiento_prod (fecha_movimiento);
CREATE INDEX idx_venta_fecha ON venta_registro (fecha_venta);
CREATE INDEX idx_pedido_estado ON pedido_compra (estado_pedido_id);
CREATE INDEX idx_detalleventa_producto ON detalle_venta (producto_id);
CREATE INDEX idx_detallepedido_producto ON detalle_pedido (producto_id);




-- -----------------------------------------------------
-- Schema sofka_taller_07
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sofka_taller_07
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sofka_taller_07` DEFAULT CHARACTER SET utf8 ;
USE `sofka_taller_07` ;

-- -----------------------------------------------------
-- Table `sofka_taller_07`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sofka_taller_07`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sofka_taller_07`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sofka_taller_07`.`supplier` (
  `sup_id` INT NOT NULL AUTO_INCREMENT,
  `sup_name` VARCHAR(45) NOT NULL,
  `city_city_id` INT NOT NULL,
  `sup_address` VARCHAR(45) NULL,
  `sup_phone` VARCHAR(16) NULL,
  PRIMARY KEY (`sup_id`),
  UNIQUE INDEX `supp_id_UNIQUE` (`sup_id` ASC) VISIBLE,
  INDEX `fk_supplier_city1_idx` (`city_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `sofka_taller_07`.`city` (`city_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `sofka_taller_07`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sofka_taller_07`.`product` (
  `prod_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_sup_id` INT NOT NULL,
  `prod_name` VARCHAR(45) NOT NULL,
  `prod_brand` VARCHAR(45) NULL,
  `prod_price` DECIMAL(19,2) NOT NULL,
  PRIMARY KEY (`prod_id`),
  UNIQUE INDEX `id_product_UNIQUE` (`prod_id` ASC) VISIBLE,
  INDEX `fk_product_supplier_idx` (`supplier_sup_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_supplier`
    FOREIGN KEY (`supplier_sup_id`)
    REFERENCES `sofka_taller_07`.`supplier` (`sup_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sofka_taller_07`.`document_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sofka_taller_07`.`document_type` (
  `doc_type_id` INT NOT NULL AUTO_INCREMENT,
  `document_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`doc_type_id`),
  UNIQUE INDEX `doctype_id_UNIQUE` (`doc_type_id` ASC) VISIBLE,
  UNIQUE INDEX `document_type_UNIQUE` (`document_type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sofka_taller_07`.`invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sofka_taller_07`.`invoice` (
  `invoice_id` INT NOT NULL AUTO_INCREMENT,
  `document_type_doc_type_id` INT NOT NULL,
  `document_number` INT NOT NULL,
  `is_deleted` TINYINT(1) NULL,
  PRIMARY KEY (`invoice_id`),
  INDEX `fk_sale_document_type1_idx` (`document_type_doc_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_sale_document_type1`
    FOREIGN KEY (`document_type_doc_type_id`)
    REFERENCES `sofka_taller_07`.`document_type` (`doc_type_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sofka_taller_07`.`invoice_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sofka_taller_07`.`invoice_detail` (
  `invoice_detail_id` INT NOT NULL AUTO_INCREMENT,
  `invoice_invoice_id` INT NOT NULL,
  `product_prod_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`invoice_detail_id`),
  UNIQUE INDEX `invoice_detail_id_UNIQUE` (`invoice_detail_id` ASC) VISIBLE,
  INDEX `fk_invoice_detail_product1_idx` (`product_prod_id` ASC) VISIBLE,
  INDEX `fk_invoice_detail_invoice1_idx` (`invoice_invoice_id` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_detail_product1`
    FOREIGN KEY (`product_prod_id`)
    REFERENCES `sofka_taller_07`.`product` (`prod_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_invoice_detail_invoice1`
    FOREIGN KEY (`invoice_invoice_id`)
    REFERENCES `sofka_taller_07`.`invoice` (`invoice_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

--
-- Carga de datos de la tabla city
--
INSERT INTO city (city_name)
VALUES
  ('Medellín'),
  ('Buenos Aires'),
  ('Montevideo'),
  ('Washington');

--
-- Carga de datos de la tabla document_type
--
INSERT INTO document_type (document_type)
VALUES
  ('DNI'),
  ('CC'),
  ('Pasaporte'),
  ('CI');

--
-- Carga de datos de la tabla supplier
--
INSERT INTO supplier (sup_name, city_city_id, sup_address, sup_phone)
VALUES
  ('Brennan Garner',3,'268-9713 Nullam Avenue','1-963-811-1515'),
  ('Maggie Wolf',4,'2937 Tortor Road','1-476-621-1162'),
  ('Sage Green',2,'124-1333 Lacus St.','(369) 572-6758'),
  ('Merrill Pittman',3,'Ap #333-8183 Elit. Rd.','(476) 340-2625'),
  ('Sylvester Ford',1,'9123 Dictum. Rd.','(844) 756-1682)');


--
-- Carga de datos de la tabla product
--
INSERT INTO product (supplier_sup_id, prod_name, prod_brand, prod_price)
VALUES
  (4,'sem','bibendum',10.05),
  (2,'velit','sapien',5),
  (3,'Sed','nisl',6),
  (4,'hendrerit','arcu',160),
  (1,'Nunc','scelerisque',1000.03),
  (3,'facilisis','Phasellus',0.30),
  (5,'dolor,','aliquet',15.05),
  (1,'lorem,','Vivamus',259.99),
  (3,'ac','sit',99.98),
  (4,'justo','at',13000);

--
-- Carga de datos de la tabla invoice
--
INSERT INTO invoice (document_type_doc_type_id, document_number)
VALUES
  (2,30390110),
  (3,48522322),
  (1,44113022),
  (3,37922349),
  (1,43064534),
  (2,48864768),
  (4,33349038),
  (3,51457561),
  (2,47037592),
  (3,32975462),
  (2,55737894),
  (2,47538997),
  (4,36470383),
  (2,53437270),
  (2,37648462);

--
-- Carga de datos de la tabla invoice_detail
--
INSERT INTO invoice_detail (invoice_invoice_id, product_prod_id, quantity)
VALUES (1, 5, 93),
       (1, 2, 1),
       (2, 6, 5),
       (3, 2, 80),
       (3, 1, 5),
       (4, 2, 3),
       (5, 2, 50),
       (5, 10, 10),
       (6,2,100),
       (7,2,1);


--
-- Borrado lógico de dos ventas.
--
UPDATE invoice
SET is_deleted = 1
WHERE invoice_id = 1;

UPDATE invoice
SET is_deleted = 1
WHERE invoice_id = 2;

--
-- Borrado físico de dos ventas.
--
DELETE FROM invoice
WHERE invoice_id = 3;

DELETE FROM invoice
WHERE invoice_id = 4;

--
-- Modificación de tres productos en su nombre y proveedor que los provee.
--
UPDATE product
SET prod_name = 'El mejor'
WHERE prod_id = 1;

UPDATE supplier
SET sup_name = 'Los mejores'
WHERE sup_id = (SELECT supplier_sup_id FROM product WHERE prod_id = 1);


UPDATE product
SET prod_name = 'Bueno, bonito y barato'
WHERE prod_id = 2;

UPDATE supplier
SET sup_name = 'Buenos, bonitos y baratos'
WHERE sup_id = (SELECT supplier_sup_id FROM product WHERE prod_id = 2);

UPDATE product
SET prod_name = 'Trapo'
WHERE prod_id = 3;

UPDATE supplier
SET sup_name = 'Que te aTrapo'
WHERE sup_id = (SELECT supplier_sup_id FROM product WHERE prod_id = 3);
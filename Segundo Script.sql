USE `sofka_taller_07` ;

# Consulta SQL donde pueda obtener los productos vendidos
# digitando tipo de documento y número de documento.
SELECT document_type AS tipo_de_documento,
       document_number AS nro_de_documento,
       prod_name AS producto,
       quantity AS cantidad,
       prod_price AS precio_unitario
FROM invoice
    INNER JOIN document_type ON doc_type_id = document_type_doc_type_id
    INNER JOIN invoice_detail ON invoice.invoice_id = invoice_detail.invoice_invoice_id
    INNER JOIN product ON prod_id = invoice_detail.product_prod_id
WHERE document_number = 43064534 AND document_type = 'DNI' AND (is_deleted IS NULL OR is_deleted = 0);


# Consultar productos por medio del nombre,
# el cual debe mostrar quien o quienes han sido sus proveedores.
SELECT prod_name AS producto,
       sup_name AS proveedor
FROM product
    INNER JOIN supplier s on product.supplier_sup_id = s.sup_id
WHERE prod_name = 'Trapo';


# [PLUS no obligatorio] Crear una consulta que me permita ver qué producto ha sido el más vendido
# y en qué cantidades de mayor a menor.
SELECT prod_name AS producto,
       sum(quantity) AS cantidad
FROM invoice
    INNER JOIN invoice_detail ON invoice.invoice_id = invoice_detail.invoice_invoice_id
    INNER JOIN product ON prod_id = invoice_detail.product_prod_id
WHERE is_deleted IS NULL OR is_deleted = 0
GROUP BY prod_name
ORDER BY cantidad DESC;
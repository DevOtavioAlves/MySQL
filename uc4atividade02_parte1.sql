/* A parte abaixo é a de criação da Procedure */
DELIMITER //
CREATE PROCEDURE ListaDeCompras(
    IN p_cliente_id INT,
    IN p_data DATE,
    IN p_data_envio DATE
)
BEGIN
    SELECT
        c.nome,
        iv.venda_id,
        v.valor_total,
        iv.nome_produto,
        iv.quantidade
    FROM cliente c
	INNER JOIN venda v ON 
		c.id = v.cliente_id
    INNER JOIN item_venda iv ON 
		v.id = iv.venda_id
    WHERE
		(v.data_pagamento BETWEEN p_data AND p_data_envio)
        AND (v.cliente_id = p_cliente_id)
    ORDER BY
        iv.venda_id, iv.produto_id;
END //
DELIMITER ;

call ListaDeCompras('5', '2020-06-12 09:10:00','2020-06-22 09:10:00');

select * from item_venda;
select * from venda;

DROP procedure ListaDeCompras;
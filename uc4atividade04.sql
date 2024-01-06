/*Primeira Parte do Projeto*/
ALTER TABLE Cliente
	DROP COLUMN endereco;
ALTER TABLE Cliente
	ADD Logradouro VARCHAR(255),
	ADD CEP VARCHAR(8),
	ADD Numero VARCHAR(5);
/*Primeira Parte do Projeto*/

/*Segunda Parte do Projeto*/
ALTER TABLE Item_Venda
	DROP COLUMN nome_produto,
	DROP COLUMN valor_unitario;

ALTER TABLE Produto
	ADD valor_unitario DECIMAL(9,2) NOT NULL;
/*Segunda Parte do Projeto*/

/*Terceira Parte do Projeto*/
ALTER TABLE venda
	DROP COLUMN valor_total;
CREATE VIEW ValorTotal AS
	SELECT iv.produto_id, p.valor_unitario, iv.quantidade, (p.valor_unitario * iv.quantidade) AS valor_total
	FROM Produto p
    INNER JOIN Item_Venda iv ON iv.produto_id = p.id
    INNER JOIN Venda v ON iv.venda_id = v.id;
SELECT * FROM ValorTotal;
/*Terceira Parte do Projeto*/
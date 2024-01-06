

/***
consulta para um relatório de todas as vendas pagas em dinheiro. 
Necessários para o relatório data da venda, valor total; produtos vendidos, quantidade e valor unitário; nome do cliente, cpf e telefone.
Ordena-se pela data de venda, as mais recentes primeiro.
**/

/*Melhoria de Código, realiza uma consulta apenas do item específico*/
CREATE INDEX tipo_de_pagamento ON venda(tipo_pagamento);
/*Melhoria de Código, realiza uma consulta apenas do item específico*/

EXPLAIN SELECT v.tipo_pagamento, v.data, v.valor_total, iv.nome_produto, iv.quantidade, iv.valor_unitario, c.nome, c.cpf, c.telefone 
FROM venda v
INNER JOIN item_venda iv ON iv.venda_id = v.id
INNER JOIN produto p ON p.id = iv.produto_id
INNER JOIN cliente c ON c.id = v.cliente_id
WHERE tipo_pagamento = 'D'
ORDER BY v.data DESC;

/***
consulta para encontrar todas as vendas de produtos de um dado fabricante
Mostrar dados do produto, quantidade vendida, data da venda.
Ordena-se pelo nome do produto.
***/

/*Melhoria de Código, realiza uma consulta apenas do item específico*/
CREATE INDEX fabricante_produto ON produto(fabricante);
/*Melhoria de Código, realiza uma consulta apenas do item específico*/

EXPLAIN SELECT p.nome, p.descricao, p.estoque, p.fabricante, iv.quantidade, v.data_pagamento
FROM venda v
INNER JOIN item_venda iv ON iv.venda_id = v.id
INNER JOIN produto p ON p.id = iv.produto_id
WHERE p.fabricante like 'Ultralar';

/***
Relatório de vendas de produto por cliente.
Mostrar dados do cliente, dados do produto e valor e quantidade totais de venda ao cliente de cada produto.
*/
SELECT c.nome, c.cpf, c.endereco, c.telefone, p.nome, p.descricao, p.estoque, p.fabricante, SUM(iv.subtotal), SUM(iv.quantidade)
FROM produto p
INNER JOIN item_venda iv ON iv.produto_id = p.id
INNER JOIN venda v ON v.id = iv.venda_id
INNER JOIN cliente c ON c.id = v.cliente_id
GROUP BY c.nome, c.cpf, c.endereco, c.telefone, p.nome, p.descricao, p.estoque, p.fabricante;


CREATE USER IF NOT EXISTS 'user_relatorio'@'localhost';
CREATE ROLE IF NOT EXISTS 'visualizacao';
GRANT SELECT ON *.* TO 'visualizacao';
GRANT 'visualizacao' TO 'user_relatorio'@'localhost';

SELECT * FROM mysql.user;

CREATE USER IF NOT EXISTS 'user_funcionario'@'localhost';
CREATE ROLE IF NOT EXISTS 'inserir', 'atualizar', 'deletar', 'visualizar';

GRANT SELECT ON uc4atividades.venda TO 'visualizar';
GRANT SELECT ON uc4atividades.produto TO 'visualizar';
GRANT SELECT ON uc4atividades.cliente TO 'visualizar';

GRANT INSERT ON uc4atividades.venda TO 'inserir';
GRANT INSERT ON uc4atividades.produto TO 'inserir';
GRANT INSERT ON uc4atividades.cliente TO 'inserir';

GRANT UPDATE ON uc4atividades.venda TO 'atualizar';
GRANT UPDATE ON uc4atividades.cliente TO 'atualizar';
GRANT UPDATE ON uc4atividades.produto TO 'atualizar';

GRANT DELETE ON uc4atividades.venda TO 'deletar';
GRANT DELETE ON uc4atividades.cliente TO 'deletar';
GRANT DELETE ON uc4atividades.produto TO 'deletar';
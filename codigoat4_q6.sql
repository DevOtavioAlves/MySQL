select 
	*, 
    datediff(data_alta, data_entrada) * valor_diaria as valorCobrado
from internacao as i
inner join quarto as q
on i.quarto_id = q.id
inner join tipo_quarto as tq
on q.tipo_quarto_id = tq.id;
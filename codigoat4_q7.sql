select 
	i.data_entrada,
    i.data_prev_alta,
    i.data_alta,
    i.procedimento,
    q.numero
from internacao as i
inner join quarto as q
on i.quarto_id = q.id
inner join tipo_quarto as tq
on q.tipo_quarto_id = tq.id
where descricao like 'Apartamentos'
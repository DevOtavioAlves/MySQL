select 
	p.nome, 
    m.nome, 
    i.data_entrada, 
    i.procedimento,
    e.nome
from internacao as i
inner join paciente as p
on i.paciente_id = p.id
inner join medico as m
on i.medico_id = m.id
inner join medico_especialidade as me
on m.id = me.medico_id
inner join especialidade as e
on e.id = me.especialidade_id
inner join quarto as q
on i.quarto_id = q.id
inner join tipo_quarto as tq
on q.tipo_quarto_id = tq.id
where e.nome = 'Gastroenterologia' and tq.descricao = 'Enfermaria';
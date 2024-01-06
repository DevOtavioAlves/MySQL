/*Solicite ao código o nome do convênio, o ID do convênio e a quantidade de vezes que o convênio participou mais de uma vez.*/

select 
	c.nome,
    cs.convenio_id,
    count(cs.convenio_id)
from convenio as c
inner join consulta as cs
on cs.convenio_id = c.id
group by c.nome, cs.convenio_id
having count(cs.convenio_id) > 1
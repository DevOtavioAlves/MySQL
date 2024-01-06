delete from convenio
where id = 4;
delete from paciente
where Convenio_id = 4;
delete from consulta
where Convenio_id = 4;

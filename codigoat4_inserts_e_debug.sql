/*Alterações Utilizadas Durante o Código: */

Alter table medico
Add crm VARCHAR(45) NOT NULL;

Insert into medico (crm)
values 
('227999701'),
('557018265'),
('803562117'),
('909061744'),
('909061744'),
('188834932'),
('204909727'),
('603556698'),
('603556698'),
('299711594');

UPDATE 
	internacao
SET 
	data_alta = '2021-01-15 21:54:41'
WHERE id = 3;

insert into medico_especialidade ( medico_id, especialidade_id )
values
(1, 3),
(1, 2),
(3, 5),
(4, 2),
(7, 4),
(8, 5),
(2, 1),
(3, 1),
(10, 2),
(6, 2),
(2, 3),
(5, 4),
(5, 2);

/* Código do SQL enviado anteriormente com as inserts: *\

-- MySQL Script generated by MySQL Workbench
-- Fri May  5 14:26:26 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hospital_otavio_alves
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hospital_otavio_alves
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital_otavio_alves` DEFAULT CHARACTER SET utf8mb4 ;
USE `hospital_otavio_alves` ;

-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Convenio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Convenio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cnpj` VARCHAR(40) NOT NULL,
  `tempo_carencia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Paciente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Convenio_id` INT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `rg` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Paciente_Convenio1_idx` (`Convenio_id` ASC) VISIBLE,
  CONSTRAINT `fk_Paciente_Convenio1`
    FOREIGN KEY (`Convenio_id`)
    REFERENCES `hospital_otavio_alves`.`Convenio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Medico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `rg` VARCHAR(45) NOT NULL,
  `crm` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `em_atividade` BIT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `rg_UNIQUE` (`rg` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Especialidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Consulta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `paciente_id` INT NOT NULL,
  `medico_id` INT NOT NULL,
  `especialidade_id` INT NOT NULL,
  `convenio_id` INT NULL,
  `data_hora_realizacao` DATETIME NOT NULL,
  `valor_consulta` DECIMAL(5,2) NOT NULL,
  `numero_carteira` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `paciente_id`, `medico_id`, `especialidade_id`),
  INDEX `fk_Consulta_Paciente1_idx` (`paciente_id` ASC) VISIBLE,
  INDEX `fk_Consulta_Medico1_idx` (`medico_id` ASC) VISIBLE,
  INDEX `fk_Consulta_Especialidade1_idx` (`especialidade_id` ASC) VISIBLE,
  INDEX `fk_Consulta_Convenio1_idx` (`convenio_id` ASC) VISIBLE,
  CONSTRAINT `fk_Consulta_Paciente1`
    FOREIGN KEY (`paciente_id`)
    REFERENCES `hospital_otavio_alves`.`Paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Medico1`
    FOREIGN KEY (`medico_id`)
    REFERENCES `hospital_otavio_alves`.`Medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Especialidade1`
    FOREIGN KEY (`especialidade_id`)
    REFERENCES `hospital_otavio_alves`.`Especialidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Convenio1`
    FOREIGN KEY (`convenio_id`)
    REFERENCES `hospital_otavio_alves`.`Convenio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Receita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Receita` (
  `consulta_id` INT NOT NULL,
  `receita_escrita` TEXT NULL COMMENT 'Medicamentos receitados, a quantidade de medicamentos receitados e as instruções de uso dos tais.',
  UNIQUE INDEX `Consulta_id_UNIQUE` (`consulta_id` ASC),
  CONSTRAINT `fk_Receita_Consulta`
    FOREIGN KEY (`consulta_id`)
    REFERENCES `hospital_otavio_alves`.`Consulta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Medico_Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Medico_Especialidade` (
  `medico_id` INT NOT NULL,
  `especialidade_id` INT NOT NULL,
  PRIMARY KEY (`medico_id`, `especialidade_id`),
  INDEX `fk_Medico_Especialidade_Especialidade1_idx` (`especialidade_id` ASC) VISIBLE,
  CONSTRAINT `fk_Medico_Especialidade_Medico1`
    FOREIGN KEY (`medico_id`)
    REFERENCES `hospital_otavio_alves`.`Medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medico_Especialidade_Especialidade1`
    FOREIGN KEY (`especialidade_id`)
    REFERENCES `hospital_otavio_alves`.`Especialidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Enfermeiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Enfermeiro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `cre` CHAR(6) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Tipo_quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Tipo_quarto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(200) NOT NULL,
  `valor_diaria` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Quarto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(200) NOT NULL,
  `tipo_quarto_id` INT NOT NULL,
  PRIMARY KEY (`id`, `tipo_quarto_id`),
  INDEX `fk_Quarto_Tipo_quarto1_idx` (`tipo_quarto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Quarto_Tipo_quarto1`
    FOREIGN KEY (`tipo_quarto_id`)
    REFERENCES `hospital_otavio_alves`.`Tipo_quarto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Internacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Internacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_entrada` DATETIME NOT NULL,
  `data_prev_alta` DATETIME NOT NULL,
  `data_alta` DATETIME NOT NULL,
  `procedimento` TEXT NOT NULL,
  `paciente_id` INT NOT NULL,
  `medico_id` INT NOT NULL,
  `quarto_id` INT NOT NULL,
  PRIMARY KEY (`id`, `paciente_id`, `medico_id`, `quarto_id`),
  INDEX `fk_Internacao_Paciente1_idx` (`paciente_id` ASC) VISIBLE,
  INDEX `fk_Internacao_Medico1_idx` (`medico_id` ASC) VISIBLE,
  INDEX `fk_Internacao_Quarto1_idx` (`quarto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Internacao_Paciente1`
    FOREIGN KEY (`paciente_id`)
    REFERENCES `hospital_otavio_alves`.`Paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Internacao_Medico1`
    FOREIGN KEY (`medico_id`)
    REFERENCES `hospital_otavio_alves`.`Medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Internacao_Quarto1`
    FOREIGN KEY (`quarto_id`)
    REFERENCES `hospital_otavio_alves`.`Quarto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital_otavio_alves`.`Internacao_Enfermeiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital_otavio_alves`.`Internacao_Enfermeiro` (
  `enfermeiro_id` INT NOT NULL,
  `internacao_id` INT NOT NULL,
  PRIMARY KEY (`enfermeiro_id`, `internacao_id`),
  INDEX `fk_Internacao_has_Enfermeiro_Enfermeiro1_idx` (`enfermeiro_id` ASC) VISIBLE,
  INDEX `fk_Internacao_has_Enfermeiro_Internacao1_idx` (`internacao_id` ASC) VISIBLE,
  CONSTRAINT `fk_Internacao_has_Enfermeiro_Internacao1`
    FOREIGN KEY (`internacao_id`)
    REFERENCES `hospital_otavio_alves`.`Internacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Internacao_has_Enfermeiro_Enfermeiro1`
    FOREIGN KEY (`enfermeiro_id`)
    REFERENCES `hospital_otavio_alves`.`Enfermeiro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Convenio`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Convenio` (`id`, `nome`, `cnpj`, `tempo_carencia`) VALUES (1, 'UNICA SAUDE', '94967486000185', '6 meses');
INSERT INTO `hospital_otavio_alves`.`Convenio` (`id`, `nome`, `cnpj`, `tempo_carencia`) VALUES (2, 'SUL AMERICA', '64367053000128', '3 meses');
INSERT INTO `hospital_otavio_alves`.`Convenio` (`id`, `nome`, `cnpj`, `tempo_carencia`) VALUES (3, 'PLENA SAUDE', '74765444000154', '5 meses');
INSERT INTO `hospital_otavio_alves`.`Convenio` (`id`, `nome`, `cnpj`, `tempo_carencia`) VALUES (4, 'BRADESCO SAUDE', '38886939000178', '7 meses');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Paciente`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (1, 3, 'Luciane Muniz', '1970-07-16', 'Seropedica-RJ', '(22) 98193-2348', 'luciane.manhaes@geradornv.com.br', '23152467761', '217737742');
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (2, NULL, 'Paloma Moreira', '1996-09-14', 'Rio das Ostras-RJ', '(22) 97318-9258', 'paloma.braz@geradornv.com.br', '98053868720', '173266460');
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (3, 2, 'Inez Zava', '2001-03-25', 'Itaborai-Rj', '(24) 97966-1888', 'inez.carmoriz@geradornv.com.br', '58326252778', '317523223');
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (4, 4, 'Anderson Alentejo', '1945-08-14', 'Rio de Janeiro-RJ', '(22) 97950-1029', 'anderson.assis@geradornv.com.br', '11935025783', '132610802');
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (5, NULL, 'Lucas Felipe', '1982-02-09', 'Campos dos Gaytacazes-RJ', '(22) 96757-0688', 'lucas.abreu@geradornv.com.br', '13480272746', '389191723');
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (6, NULL, 'Emmanuel Albergaria', '1972-04-11', 'Sao Goncalo-RJ', '(21) 98765-1266', 'emmanuel.leite@geradornv.com.br', '52170339752', '206795737');
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (7, 1, 'Sandreli Albenaz', '1943-04-23', 'Nova Iguacu-RJ', '(24) 98778-0320', 'sandreli.robadey@geradornv.com.br', '14138663797', '140775286');
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (8, NULL, 'Thalia Barher', '1964-12-03', 'Rio de Janeiro-RJ', '(21) 98188-4684', 'thalia.barros@geradornv.com.br', '85573431757', '125443330');
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (9, NULL, 'Nilza Santana', '1998-01-30', 'Teresopolis-Rj', '(24) 98855-3801', 'nilza.marotti@geradornv.com.br', '22120756775', '463623679');
INSERT INTO `hospital_otavio_alves`.`Paciente` (`id`, `Convenio_id`, `nome`, `data_nascimento`, `endereco`, `telefone`, `email`, `cpf`, `rg`) VALUES (10, 2, 'Priscilla Manhaes', '1977-03-22', 'Cabo Frio-RJ', '(24) 98642-0848', 'priscilla.debossam@geradornv.com.br', '65776074789', '111337628');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Medico`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (1, 'Hevelyn Yabuta', '33962714758', '213609599', '227999701', '1957-04-14', 0);
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (2, 'Joelma de Sa', '88237489764', '342848288', '557018265', '1973-04-21', 1);
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (3, 'Joemia Carmanin', '97402595706', '176756401', '803562117', '1940-02-23', 1);
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (4, 'Gutemberg Zava', '26325146735', '270366714', '909061744', '1992-04-09', 1);
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (5, 'Tania Werneck', '63242671724', '367028360', '909061744', '1943-12-08', 0);
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (6, 'Soraya Siqueira', '68654445742', '101047186', '188834932', '1962-02-06', 1);
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (7, 'Geanny Koga', '76698442720', '182725388', '204909727', '1956-07-28', 1);
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (8, 'Vinicius Garbelini', '97753893726', '189268037', '603556698', '1998-09-08', 1);
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (9, 'Sedenir Giacomini', '20078512700', '425221222', '603556698', '1984-05-30', 1);
INSERT INTO `hospital_otavio_alves`.`Medico` (`id`, `nome`, `cpf`, `rg`, `crm`, `data_nascimento`, `em_atividade`) VALUES (10, 'Rejane Feitosa', '27659675710', '348780709', '299711594', '1945-11-14', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Especialidade`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Especialidade` (`id`, `nome`) VALUES (1, 'Clinico Geral');
INSERT INTO `hospital_otavio_alves`.`Especialidade` (`id`, `nome`) VALUES (2, 'Dermatologia');
INSERT INTO `hospital_otavio_alves`.`Especialidade` (`id`, `nome`) VALUES (3, 'Gastroenterologia');
INSERT INTO `hospital_otavio_alves`.`Especialidade` (`id`, `nome`) VALUES (4, 'Pediatria');
INSERT INTO `hospital_otavio_alves`.`Especialidade` (`id`, `nome`) VALUES (5, 'Ginecologia');
INSERT INTO `hospital_otavio_alves`.`Especialidade` (`id`, `nome`) VALUES (6, 'Anestesiologia');
INSERT INTO `hospital_otavio_alves`.`Especialidade` (`id`, `nome`) VALUES (7, 'Cardiologia');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Consulta`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (1, 3, 1, 4, 2, '2018-02-01 01:05:23', 200.00, '3');
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (2, 5, 4, 6, NULL, '2022-06-05 22:23:19', 140.00, '5');
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (3, 3, 1, 4, 2, '2018-02-09 15:13:00', 210.00, '3');
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (4, 1, 8, 1, 3, '2021-12-05 19:04:06', 350.00, '1');
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (5, 4, 6, 7, NULL, '2018-05-25 12:45:35', 430.00, '4');
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (6, 7, 3, 7, 1, '2021-01-12 13:54:23', 510.00, '7');
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (7, 9, 2, 2, NULL, '2017-07-05 05:02:22', 780.00, '9');
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (8, 8, 9, 5, NULL, '2018-11-09 18:32:42', 250.00, '8');
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (9, 7, 10, 3, 1, '2021-01-22 14:23:54', 340.00, '7');
INSERT INTO `hospital_otavio_alves`.`Consulta` (`id`, `paciente_id`, `medico_id`, `especialidade_id`, `convenio_id`, `data_hora_realizacao`, `valor_consulta`, `numero_carteira`) VALUES (10, 10, 1, 1, 2, '2020-04-28 12:38:32', 210.00, '10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Receita`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Receita` (`consulta_id`, `receita_escrita`) VALUES (1, 'Dipirona - Administrar Em Relacao ao Peso.');
INSERT INTO `hospital_otavio_alves`.`Receita` (`consulta_id`, `receita_escrita`) VALUES (3, 'Loratadina - Administrar em Relação ao Peso da Criança.');
INSERT INTO `hospital_otavio_alves`.`Receita` (`consulta_id`, `receita_escrita`) VALUES (7, 'Bisoprolol - 10 Mg uma vez ao dia');
INSERT INTO `hospital_otavio_alves`.`Receita` (`consulta_id`, `receita_escrita`) VALUES (9, 'Consuma 15 a 20 gramas de carboidratos, caso tenha convulsões/desmaios, não injete a insulina.');
INSERT INTO `hospital_otavio_alves`.`Receita` (`consulta_id`, `receita_escrita`) VALUES (10, 'Desloratadina - Ajustar de acordo com o paciente');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Enfermeiro`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Enfermeiro` (`id`, `nome`, `cpf`, `cre`) VALUES (1, 'Rafael Vargas', '43337914721', '189765');
INSERT INTO `hospital_otavio_alves`.`Enfermeiro` (`id`, `nome`, `cpf`, `cre`) VALUES (2, 'Jose Antonio', '58470652729', '741396');
INSERT INTO `hospital_otavio_alves`.`Enfermeiro` (`id`, `nome`, `cpf`, `cre`) VALUES (3, 'Marcus Zuniga', '61826817727', '927519');
INSERT INTO `hospital_otavio_alves`.`Enfermeiro` (`id`, `nome`, `cpf`, `cre`) VALUES (4, 'Roseanne Guerini', '52997514789', '308417');
INSERT INTO `hospital_otavio_alves`.`Enfermeiro` (`id`, `nome`, `cpf`, `cre`) VALUES (5, 'Soraya Louzano', '72241455725', '645737');
INSERT INTO `hospital_otavio_alves`.`Enfermeiro` (`id`, `nome`, `cpf`, `cre`) VALUES (6, 'Evelyn Farias', '38527544709', '618875');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Tipo_quarto`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Tipo_quarto` (`id`, `descricao`, `valor_diaria`) VALUES (1, 'Apartamentos', 75);
INSERT INTO `hospital_otavio_alves`.`Tipo_quarto` (`id`, `descricao`, `valor_diaria`) VALUES (2, 'Quartos Duplos', 25);
INSERT INTO `hospital_otavio_alves`.`Tipo_quarto` (`id`, `descricao`, `valor_diaria`) VALUES (3, 'Enfermaria', 20);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Quarto`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Quarto` (`id`, `numero`, `tipo_quarto_id`) VALUES (1, '103', 1);
INSERT INTO `hospital_otavio_alves`.`Quarto` (`id`, `numero`, `tipo_quarto_id`) VALUES (2, '203', 2);
INSERT INTO `hospital_otavio_alves`.`Quarto` (`id`, `numero`, `tipo_quarto_id`) VALUES (3, '303', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Internacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Internacao` (`id`, `data_entrada`, `data_prev_alta`, `data_alta`, `procedimento`, `paciente_id`, `medico_id`, `quarto_id`) VALUES (1, '2018-02-01 01:10:54', '2018-02-01 01:40:00', '2018-02-01 02:03:55', 'Intoxicação Alimentar', 2, 1, 1);
INSERT INTO `hospital_otavio_alves`.`Internacao` (`id`, `data_entrada`, `data_prev_alta`, `data_alta`, `procedimento`, `paciente_id`, `medico_id`, `quarto_id`) VALUES (2, '2022-06-05 23:23:19', '2022-07-05 06:05:00', '2022-07-05 03:55:32', 'Gases Intestinais', 5, 4, 3);
INSERT INTO `hospital_otavio_alves`.`Internacao` (`id`, `data_entrada`, `data_prev_alta`, `data_alta`, `procedimento`, `paciente_id`, `medico_id`, `quarto_id`) VALUES (3, '2021-12-17 14:28:42', '2021-12-18 20:00:00', '2021-12-15 21:54:41', 'Alergias pelo Corpo', 3, 6, 2);
INSERT INTO `hospital_otavio_alves`.`Internacao` (`id`, `data_entrada`, `data_prev_alta`, `data_alta`, `procedimento`, `paciente_id`, `medico_id`, `quarto_id`) VALUES (4, '2018-03-14 06:30:45', '2018-12-07 15:00:00', '2018-12-01 20:00:32', 'Intoxicação Alimentar', 2, 1, 1);
INSERT INTO `hospital_otavio_alves`.`Internacao` (`id`, `data_entrada`, `data_prev_alta`, `data_alta`, `procedimento`, `paciente_id`, `medico_id`, `quarto_id`) VALUES (5, '2022-03-22 17:32:36', '2022-03-23 00:00:00', '2022-03-22 18:15:45', 'Alergias na Perna ( Piores do que as anteriores )', 3, 6, 2);
INSERT INTO `hospital_otavio_alves`.`Internacao` (`id`, `data_entrada`, `data_prev_alta`, `data_alta`, `procedimento`, `paciente_id`, `medico_id`, `quarto_id`) VALUES (6, '2019-08-03 23:06:24', '2019-08-06 15:23:54', '2019-08-05 05:43:22', 'Torção Testicular', 10, 9, 1);
INSERT INTO `hospital_otavio_alves`.`Internacao` (`id`, `data_entrada`, `data_prev_alta`, `data_alta`, `procedimento`, `paciente_id`, `medico_id`, `quarto_id`) VALUES (7, '2019-11-12 05:17:06', '2019-11-16 09:00:00', '2019-11-16 05:32:45', 'Dores no Coração', 8, 5, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital_otavio_alves`.`Internacao_Enfermeiro`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital_otavio_alves`;
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (1, 1);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (1, 6);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (2, 4);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (4, 2);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (3, 4);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (6, 3);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (2, 2);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (4, 3);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (1, 5);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (5, 7);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (3, 1);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (2, 1);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (1, 3);
INSERT INTO `hospital_otavio_alves`.`Internacao_Enfermeiro` (`enfermeiro_id`, `internacao_id`) VALUES (6, 7);

COMMIT;


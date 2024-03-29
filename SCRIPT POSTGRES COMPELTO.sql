DROP DATABASE IF EXISTS uvv;

CREATE USER gustavo WITH
NOSUPERUSER
CREATEDB
CREATEROLE
LOGIN
ENCRYPTED PASSWORD '123456'

CREATE DATABASE uvv WITH
owner = gustavo
template = template0
encoding = 'UTF-8'
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'

\c "dbname=uvv user=gustavo password=123456"

CREATE SCHEMA elmasri AUTHORIZATION gustavo;

ALTER USER gustavo
SET SEARCH_PARTH TO elmasri, "$user", public;

SET SEARCH_PATH TO elmasri, "$user", public;






CREATE TYPE elmasri.sexo AS ENUM('M','F');

CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(35),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (cpf)
);



CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT dependente_pk PRIMARY KEY (cpf_funcionario, nome_dependente)
);

CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento)
);


CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto)
);

CREATE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

CREATE UNIQUE INDEX projeto_idx1
 ON elmasri.projeto
 ( nome_projeto );

CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1),
                CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);


CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT localizacoes_departamento_pk PRIMARY KEY (numero_departamento, local)
);

ALTER TABLE IF EXISTS elmasri.departamento
    ADD CONSTRAINT nome_departamento_ak UNIQUE (nome_departamento);



ALTER TABLE IF EXISTS elmasri.projeto
    ADD CONSTRAINT nome_projeto_ak UNIQUE (nome_projeto);



COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.data_nascimento IS 'Data de nascimento do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereço do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'Salário do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Número do departamento do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'Cpf do supervisor do funcionario';


COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';


COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informaçoẽs dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';


COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localização do projeto.';


COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';


COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';


ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf);


ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf);


ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf);


ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf);


ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento);


ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento);

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto);


INSERT INTO elmasri.funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (88866555576,'Jorge','E','Brito','10-11-1937','R.do Horto,35,São Paulo,SP','M',55.000, NULL, 1);		
INSERT INTO elmasri.funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (33344555587,'Fernando','T','Wong','08-12-1955','R. da Lapa, 34,SãoPaulo, SP','M',40.000,88866555576, 5);
INSERT INTO elmasri.funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (66688444476,'Ronaldo','K','Lima','15-09-1962','Rua Rebouças,65,Piracicaba,SP','M',38.000,33344555587, 5);
INSERT INTO elmasri.funcionario(
	cpf, primeiro_nome, nome_meio,ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (98765432168,'Jennifer','S','Souza','20-06-1941','Av.Arthur de Uma,54,SantoAndré,SP','F',43.000,88866555576,4);
INSERT INTO elmasri.funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (12345678966,'joão','B','Silva','09-01-1965','R.das Flores,751.São Paulo,SP','M',30.000,33344555587, 5);
INSERT INTO elmasri.funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (99988777767,'Alice','J','Zelaya','19-01-1968','R. Souza Uma,35,Curitiba,PR','F',25.000,98765432168, 4);
INSERT INTO elmasri.funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (45345345376,'Joice','A','Leite','31-07-1972','Av.Lucas Obes,74,São fóulo, SP','F',25.000,33344555587, 5);
INSERT INTO elmasri.funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (98798798733,'André','V','Pereira','29-03-1969','RuaTimbira, 35, São Paulo, SP','M',25.000,98765432168,4);



INSERT INTO elmasri.departamento(
	numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente)
	VALUES (5, 'Pesquisa', 33344555587,'22-05-1988');
INSERT INTO elmasri.departamento(
	numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente)
	VALUES (4, 'Administração',98765432168 ,'01-01-1995');
INSERT INTO elmasri.departamento(
	numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente)
	VALUES (1, 'Matriz', 88866555576,'19-06-1981');	



	
INSERT INTO elmasri.localizacoes_departamento(
	numero_departamento, local)
	VALUES (1,'São Paulo');
INSERT INTO elmasri.localizacoes_departamento(
	numero_departamento, local)
	VALUES (4,'Mauá');
INSERT INTO elmasri.localizacoes_departamento(
	numero_departamento, local)
	VALUES (5 ,'SantoAndré');
INSERT INTO elmasri.localizacoes_departamento(
	numero_departamento, local)
	VALUES (5,'Itu');
INSERT INTO elmasri.localizacoes_departamento(
	numero_departamento, local)
	VALUES (5,'São Paulo');
	


INSERT INTO elmasri.projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (1, 'ProdutoX','SantoAndré', 5 );
INSERT INTO elmasri.projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (2, 'ProdutoY','Itu', 5 );
INSERT INTO elmasri.projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (3, 'ProdutoZ','São_Paulo', 5 );
INSERT INTO elmasri.projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (10, 'Informatização','Mauá', 4 );
INSERT INTO elmasri.projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (20, 'Reorganização','São_Paulo', 1 );
INSERT INTO elmasri.projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (30, 'Novosbeneficios','Mauá', 4 );	
	




INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (12345678966, 1, 32.5 );
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (12345678966, 2, 7.5);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (66688444476 , 3, 40.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (45345345376, 1, 20.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (45345345376, 2, 20.00);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (33344555587, 2, 10.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (33344555587, 3, 10.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (33344555587, 10, 10.0);	
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (33344555587, 20, 10.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (99988777767, 30, 30.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (99988777767, 10, 10.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (98798798733, 10, 35.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (98798798733, 30, 5.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (98765432168, 30, 20.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (98765432168, 20, 15.0);
INSERT INTO elmasri.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (88866555576, 10, null);	


INSERT INTO elmasri.dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (33344555587, 'Alicia', 'F', '05-04-1986', 'filha');
INSERT INTO elmasri.dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (33344555587, 'Tiago', 'M', '25-10-1983', 'filho');
INSERT INTO elmasri.dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (33344555587, 'Janaína', 'F', '03-05-1958' , 'Esposa');
INSERT INTO elmasri.dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (98765432168, 'Antonio', 'M', '28-02-1942', 'Marido');
INSERT INTO elmasri.dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (12345678966, 'Michael', 'M', '04-01-1988','Filho');
INSERT INTO elmasri.dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (12345678966, 'Alicia', 'F', '30-12-1988','Filha');
INSERT INTO elmasri.dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (12345678966, 'Elizabeth', 'F', '05-05-1967','Esposa');



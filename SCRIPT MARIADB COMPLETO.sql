CREATE DATABASE uvv;

USE uvv;

CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(35),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);


ALTER TABLE funcionario
ADD CONSTRAINT ch_sexo
CHECK (sexo IN('M','F'));



CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);

ALTER TABLE dependente
ADD CONSTRAINT ch_sexo
CHECK (sexo IN('M','F'));



CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);



CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);


CREATE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

CREATE UNIQUE INDEX projeto_idx1
 ON projeto
 ( nome_projeto );


CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1),
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);



CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);




ALTER TABLE funcionario COMMENT 'Tabela que armazena as informações dos funcionários.';

ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário. Será a PK da tabela.';

ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Primeiro nome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.';

ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Sobrenome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(35) COMMENT 'Endereço do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Salário do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento do funcionário.';


ALTER TABLE dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários.';

ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Nome do dependente. Faz parte da PK desta tabela.';

ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente.';

ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente.';

ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Descrição do parentesco do dependente com o funcionário.';



ALTER TABLE departamento COMMENT 'Tabela que armazena as informaçoẽs dos departamentos.';

ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É a PK desta tabela.';

ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Nome do departamento. Deve ser único.';

ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';

ALTER TABLE departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'Data do início do gerente no departamento.';



ALTER TABLE projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos.';

ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto. É a PK desta tabela.';

ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(15) COMMENT 'Nome do projeto. Deve ser único.';

ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Localização do projeto.';



ALTER TABLE trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos.';

ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';

ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';

ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto.';



ALTER TABLE localizacoes_departamento COMMENT 'Tabela que armazena as possíveis localizações dos departamentos.';

ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';

ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Localização do departamento. Faz parte da PK desta tabela.';




INSERT INTO funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) 
	VALUES (88866555576,'Jorge','E','Brito','1937-11-10','R.do Horto, 35, São Paulo, SP','M',55.000, NULL, 1);		
INSERT INTO funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (33344555587,'Fernando','T','Wong','1955-12-08','R.da Lapa, 34, São Paulo, SP','M',40.000,88866555576, 5);  
INSERT INTO funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (66688444476, 'Ronaldo','K','Lima' ,'1962-09-15','Rua Rebouças,65,Piracicaba, SP','M',38.000,33344555587, 5);  
INSERT INTO funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (98765432168,'Jennifer','S','Souza' ,'1941-06-20' ,'Av.Arthur de Uma,54,SantoAndré,SP','F',43.000,88866555576, 4);
INSERT INTO funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (12345678966,'joão', 'B' ,'Silva','1965-01-09' ,'R. das Flores,751.São Paulo,SP','M', 30.000,33344555587, 5);
INSERT INTO funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (99988777767,'Alice','J','Zelaya','1968-01-19','R. Souza Uma,35,Curitiba,PR','F',25.000,98765432168, 4);
INSERT INTO funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (45345345376, 'Joice','A','Leite','1972-07-31' ,'Av.Lucas Obes, 74,São fóulo, SP','F',25.000,33344555587, 5);
INSERT INTO funcionario(
	cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
	VALUES (98798798733,'André','V','Pereira','1969-03-29','RuaTimbira, 35,São Paulo, SP','M',25.000,98765432168, 4);



INSERT INTO departamento(
	numero_departamento,nome_departamento, cpf_gerente, data_inicio_gerente)
	VALUES (5, 'Pesquisa',33344555587,'1988-05-22');
INSERT INTO departamento(
	numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente)
	VALUES (4, 'Administração',98765432168 ,'1995-01-01');
INSERT INTO departamento(
	numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente)
	VALUES (1, 'Matriz',88866555576,'1981-06-19');	



	
INSERT INTO localizacoes_departamento(
	numero_departamento, local)
	VALUES (1,'São Paulo');
INSERT INTO localizacoes_departamento(
	numero_departamento, local)
	VALUES (4,'Mauá');
INSERT INTO elocalizacoes_departamento(
	numero_departamento, local)
	VALUES (5 ,'SantoAndré');
INSERT INTO localizacoes_departamento(
	numero_departamento, local)
	VALUES (5,'Itu');
INSERT INTO localizacoes_departamento(
	numero_departamento, local)
	VALUES (5,'São Paulo');
	


INSERT INTO projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (1, 'ProdutoX','SantoAndré', 5);
INSERT INTO projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (2, 'ProdutoY','Itu', 5);
INSERT INTO projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (3, 'ProdutoZ','São_Paulo', 5);
INSERT INTO projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (10, 'Informatização','Mauá', 4);
INSERT INTO projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (20, 'Reorganização','São_Paulo',1);
INSERT INTO projeto(
	numero_projeto, nome_projeto, local_projeto, numero_departamento)
	VALUES (30, 'Novosbeneficios','Mauá',4 );	
	




INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (12345678966,1,32.5 );
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (12345678966,2,7.5);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (66688444476,3,40.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (45345345376,1,20.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (45345345376,2, 20.00);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (33344555587,2, 10.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (33344555587,3, 10.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (33344555587,10, 10.0);	
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (33344555587,20, 10.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (99988777767,30, 30.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (99988777767,10, 10.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (98798798733,10, 35.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (98798798733,30, 5.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (98765432168,30, 20.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (98765432168,20, 15.0);
INSERT INTO trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES (88866555576,10, null);	


INSERT INTO dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (33344555587, 'Alicia','F','1986-04-05','filha');
INSERT INTO dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (33344555587,'Tiago','M','1983-10-25','filho');
INSERT INTO dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (33344555587,'Janaína','F','1958-05-03','Esposa');
INSERT INTO dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (98765432168, 'Antonio','M','1942-02-28','Marido');
INSERT INTO dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (12345678966, 'Michael','M','1988-01-04','Filho');04-01-1988
INSERT INTO dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (12345678966,'Alicia','F','1988-12-1988','Filha');
INSERT INTO dependente(
	cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
	VALUES (12345678966,'Elizabeth','F','1967-05-05','Esposa');






ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf);


ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf);


ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf);


ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf);


ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento);


ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento);


ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto);

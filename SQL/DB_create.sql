CREATE DATABASE LMS24
GO
USE LMS24
GO
CREATE TABLE coordenador (
id INT AUTO_INCREMENT PRIMARY KEY
, logon VARCHAR (20) UNIQUE
, senha VARCHAR (20) NOT NULL
, nome VARCHAR(30) NOT NULL
, email VARCHAR  (40) UNIQUE not null
, celular CHAR(9)  UNIQUE
, dtExpiracao DATE DEFAULT GETDATE()
)
GO
CREATE TABLE aluno (
id INT AUTO_INCREMENT PRIMARY KEY
, logon VARCHAR (20) UNIQUE
, senha VARCHAR (20) NOT NULL
, nome VARCHAR(30) NOT NULL
, email VARCHAR  (40) UNIQUE NOT NULL
, celular CHAR(9)  UNIQUE
, foto VARCHAR (255) NULL
, dtExpiracao DATE DEFAULT GETDATE()
, ra VARCHAR (20)
)

go
CREATE TABLE professor (
id INT AUTO_INCREMENT PRIMARY KEY
, logon VARCHAR (20) UNIQUE
, senha VARCHAR (20) NOT NULL
, nome VARCHAR(30) NOT NULL
, email VARCHAR  (40) UNIQUE NOT NULL
, celular CHAR(9)  UNIQUE
, dtExpiracao DATE DEFAULT GETDATE()
, apelido VARCHAR (20)
)
go
CREATE TABLE disciplina (
id INT AUTO_INCREMENT PRIMARY KEY
, nome VARCHAR (30) UNIQUE
, data DATE DEFAULT GETDATE()
, statusDisc VARCHAR (20) DEFAULT('ABERTO')
, planoDeEnsino VARCHAR (1000)
, cargaHoraria INT
CHECK(cargaHoraria = 80 or cargaHoraria = 40)
, competencias VARCHAR (1000)
, habilidades VARCHAR (1000)
, ementa VARCHAR (1000)
, conteudoProgramatico VARCHAR (1000)
, bibliografiaBasica VARCHAR (1000)
, bibliografiaComplementar VARCHAR (1000)
, percentualPratico INT
CHECK(percentualPratico >=0 AND percentualPratico <= 100)
, percentualTeorico INT
CHECK(percentualTeorico >=0 AND percentualTeorico <= 100)
, idCoordenador INT NOT NULL
, CONSTRAINT fkIdCoordenador FOREIGN KEY(idCoordenador) REFERENCES coordenador (ID)
, CONSTRAINT pkDisciplina PRIMARY KEY (ID)
)
GO
CREATE TABLE curso (
id INT AUTO_INCREMENT PRIMARY KEY identity(1,1)
, nome varchar(30) UNIQUE NOT NULL
)
CREATE TABLE disciplinaOfertada (
id INT AUTO_INCREMENT PRIMARY KEY identity(1,1),
idCoordenador INT NOT NULL
, dtInicioMatricula DATE NULL
, dtFimMatricula DATE NULL
, IdDisciplina INT NOT NULL
, idCurso INT NOT NULL
, ano INT NOT NULL
, semestre INT NOT NULL
, turma VARCHAR(6)
, idProfessor INT NULL
, metodologia VARCHAR(1000) NULL
, recursos VARCHAR(1000) NULL
, criterioAvaliacao VARCHAR(1000) NULL
, planoDeAulas VARCHAR(1000) NULL
, CONSTRAINT fKIdCoordenador FOREIGN KEY (IdCoordenador) REFERENCES coordenador(id)
, CONSTRAINT fkIdDisciplina FOREIGN KEY (IdDisciplina) REFERENCES disciplina(id)
, CONSTRAINT fkIdProfessor FOREIGN KEY (IdProfessor) REFERENCES professor(id)
, CONSTRAINT ckAno CHECK (ano BETWEEN 1900 AND 2100)
, CONSTRAINT ckSemestre CHECK (semestre BETWEEN 1 AND 2)
, CONSTRAINT ckTurma CHECK (turma BETWEEN 'A' AND 'Z')
, CONSTRAINT fkCurso FOREIGN KEY (idCurso) REFERENCES curso (id)
)

GO

CREATE TABLE solicitacaoMatricula
(
id INT identity (1,1) PRIMARY KEY
, idAluno INT NOT NULL
, idDisciplinaOfertada INT NOT NULL
, dtSolicitacao DATE DEFAULT GETDATE() NOT NULL
, idCoordenador INT NULL
, [status] VARCHAR (100) DEFAULT 'SOLICITADA' CHECK ([status]= 'SOLICITADA' or [status]= 'APROVADA' or [status]= 'REJEITADA' or [status]= 'CANCELADA')
, CONSTRAINT fkIdAluno FOREIGN KEY (idAluno) REFERENCES aluno (id)
, CONSTRAINT fkIdDisciplinaOfertada FOREIGN KEY (idDisciplinaOfertada) REFERENCES disciplinaOfertada (id)
, CONSTRAINT fkIdCoordenadorSC FOREIGN KEY (idCoordenador) REFERENCES coordenador (id)
)
GO
CREATE TABLE atividade
(
id INT NOT NULL PRIMARY KEY identity (1,1)
, titulo VARCHAR (50)
, descricao VARCHAR (1000) NOT NULL
, conteudo VARCHAR (1000) NULL
, tipo VARCHAR (50) CHECK(tipo = 'RESPOSTA ABERTA' or tipo = 'TESTE')
, extra VARCHAR (1000) NULL
, idProfessor INT NOT NULL FOREIGN KEY REFERENCES professor (id)
)

GO
CREATE TABLE atividadeVinculada (
id INT NOT NULL PRIMARY KEY
, professor INT NOT NULL
, atividade INT NOT NULL
, disciplinaOfertada INT NOT NULL
, rotulo VARCHAR (100) NOT NULL UNIQUE (atividade, disciplinaOfertada)
, CONSTRAINT fkAtividade FOREIGN KEY (atividade) REFERENCES atividade (id)
, CONSTRAINT fkProfessor FOREIGN KEY (professor) REFERENCES professor (id)
, CONSTRAINT fkDisciplinaOfertada FOREIGN KEY (disciplinaOfertada) REFERENCES disciplinaOfertada (id)
, estado VARCHAR (100)
, dtInicioRespostas DATE
, dtFimRespostas DATE
)

GO
CREATE TABLE entrega (
id INT identity(1,1) PRIMARY KEY
, idAluno INT NOT NULL
, titulo VARCHAR (40)
, resposta VARCHAR(1000)
, atividadeVinculada INT NOT NULL
, dtEntrega DATE DEFAULT GETDATE() NOT NULL
, [status] VARCHAR(20) DEFAULT('ENTREGUE') CHECK([status] = 'ENTREGUE' or [status] = 'CORRIGIDO')
, idProfessor INT NOT NULL
, nota DECIMAL(4,2) NOT NULL
, dtAvaliacao DATE NOT NULL
, obs VARCHAR(1000)
, CONSTRAINT fkAluno FOREIGN KEY (idAluno) REFERENCES aluno (id),
, CONSTRAINT fkProfessor FOREIGN KEY (idProfessor) REFERENCES professor (id),
, CONSTRAINT ckNota CHECK (nota BETWEEN 0 AND 10)
, CONSTRAINT fkAtividadeVinculada FOREIGN KEY (atividadeVinculada)
, REFERENCES atividadeVinculada (id)
)

GO
CREATE TABLE mensagem (
id INT NOT NULL PRIMARY KEY identity (1,1)
, idAluno INT NOT NULL
, idProfessor INT NOT NULL
, assunto VARCHAR (1000) NULL
, referencia VARCHAR (1000) NULL
, conteudo VARCHAR (1000) NULL
, [status] VARCHAR (50) CHECK([status] = 'ENVIADO' or [status] = 'LIDO' or [status] = 'RESPONDIDO')
, dtEnvio DATE DEFAULT GETDATE()
, dtResposta DATE NOT NULL
, resposta VARCHAR (1000) NULL
, CONSTRAINT fkAlunoMensagem FOREIGN KEY (idAluno) REFERENCES aluno (id)
, CONSTRAINT fkProfessorMensagem FOREIGN KEY (idProfessor) REFERENCES professor (id)
)
-------------------------------------------------------------------------------

----------------------- INICIO AC6 ----------------

/* --Cadastrem: 1 Coordenador, 10 Alunos, ---5 Professores ----- ( INSERT )-- */

insert into Coordenador(ID,LOGON,Senha,Nome,Email,Celular)
Values(01,'GabrielCoordenador','impacta','Gabriel','gabrielcod@gmail.com','999999999')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(01,'PabloImpacta','impacta','Pablo','pabloaluno@gmail.com','999999999','10000')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(02,'LuizImpacta','impacta','Luiz','luizaluno@gmail.com','999999987','10001')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(03,'MarcosImpacta','impacta','Marcos','marcoaluno@gmail.com','99999923','10002')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(04,'GuilhermeImpacta','impacta','Guilherme','guialuno@gmail.com','99999943','10003')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(05,'LucasImpacta','impacta','Lucas','lucasaluno@gmail.com','999999943','10004')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(06,'DouglasImpacta','impacta','Douglas','dougaluno@gmail.com','999999234','10005')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(07,'FraImpacta','impacta','Francoise','franaluno@gmail.com','999999453','10006')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(08,'Juliaimpacta','impacta','Julia','Juliaaluno@gmail.com','999995467','10007')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(09,'Jesusimpacta','impacta','Jesus','jesusaluno@gmail.com','999992314','10008')

insert into Aluno(ID,LOGON,Senha,Nome,Email,Celular,RA)
Values(10,'Milaimpacta','impacta','Mila','milaaluno@gmail.com','999362314','10009')

--------------------------------------------------------------------------------
/*•	Cadastrem todos os cursos existentes nesta universidade, se quiserem, 
podem utilizar os nomes reduzidos dos mesmos, ADS, SI, etc. ( INSERTT ) */ 

insert into Curso(Nome)
Values('ADS')

insert into Curso(Nome)
Values('ADM')

insert into Curso(Nome)
Values('BD')

insert into Curso(Nome)
Values('GTI')

insert into Curso(Nome)
Values('JD')

insert into Curso(Nome)
Values('PG')

insert into Curso(Nome)
Values('PM')

insert into Curso(Nome)
Values('REDES')

insert into Curso(Nome)
Values('SI')
-----------------------------------------------------------------------------------
/*	Criem 2 Disciplinas ( planos de ensino ) – Linguagem SQL e Tec Web
( utilizem dados reais para preencher a tabela,
 vejam os planos de ensino apresentados ( INSERT ) */

insert into Disciplina(ID,Nome,Plano_de_ensino,CargaHoraria,Competencias,Habilidades,Ementa,Conteudo_Programatico,Bibliografia_Basica,Bibliografia_Complementar,Percentual_Pratico,Percentual_Teorico,IdCoordenador)
Values(01,'Linguagem SQL','Conceitos basicos, Linguagem SQL, Manipulação de Dados e etc..' ,80,'Arquitetar um Banco de dados, Garantir a integridade e criar relatorios','Conhecimento aprofundado sobre SQL e sua linguagem',
'Introdução a linguagem,Linguagem de Manipulação de dados, Funções e Visões','Historia da Linguagem, O modelo fisico, Create, Alter, Drop e Update, Insert, Delete e Join,Revisao e Prova ','DATE, C.J. SQL e Teoria Relacional: Como escrever codigos em SQL precisos - São Paulo:Novatec, 2015','ELMASRI, R.E.; NAVATHE, S. B. Sistemas de Banco de Dados. Ed. São Paulo: Pearson. 2011',75,25,01)

insert into Disciplina(ID,Nome,status_disc,Plano_de_ensino,CargaHoraria,Competencias,Habilidades,Ementa,Conteudo_Programatico,Bibliografia_Basica,Bibliografia_Complementar,Percentual_Pratico,Percentual_Teorico,IdCoordenador)
Values(02,'Tecnologia Web','ABERTO','Conceitos basicos de HTML5,CSS3,JavaScripts ao avançado, Introdução e ferramentas ao Django',80,'Desenvolver aplicação Web','Conhecer e dominar as principais maneiras de  construção de publicação de um site utilizando HTML5, CSS3 e JavaScripts',
'Tecnologias para desenvolvimento de aplicações web com HTML5,CSS3 e JavaScripts','Introdução a HTML5,CSS3 e JavaScripts programação avançada, revisão e prova','Use a Cabeça!, HTML5 com CSS3.Rio de Janeiro: Alta Books, 2 edição, 2015','Moraes, Construindo Aplicações Web. São Paulo, NovaTec,2015',50,50,01)

------------------------------------------------------------------------------------------------------------------------

/* 	Ofertem a Disciplina “Linguagem SQL” em 2018, 1ºsemestre,
 turma B, para os cursos de SI e ADS. ( INSERT ) (não feito) */

insert into DisciplinaOfertada(IdCoordenador,DtInicioMatricula,DtFimMatricula,IdDisciplina,IdCurso,Ano,Semestre,Turma,IdProfessor,Metodologia,Recursos,CriterioAvaliacao,PlanoDeAulas)
values(01,'2018-04-16','2019-04-16',01,01,2018,01,'ADS2B',01,'Aulas utilizando projetor, lousa e computador, cada aula terá 50 minutos e atividades contínuas diárias.',
'Máquina virtual com servidor Microsoft SQL Server 2014','Nota Final = 60% MAC + 40% Prova e Frequencia 75% ','Historia da Linguagem, O modelo fisico, Create, Alter, Drop e Update, Insert, Delete e Join,Revisao e Prova ')

insert into DisciplinaOfertada(IdCoordenador,DtInicioMatricula,DtFimMatricula,IdDisciplina,IdCurso,Ano,Semestre,Turma,IdProfessor,Metodologia,Recursos,CriterioAvaliacao,PlanoDeAulas)
values(02,'2018-02-10','2024-04-02',02,09,2018,02,'SI2B',01,'Aulas utilizando projetor, lousa e computador, cada aula terá 50 minutos e atividades contínuas diárias.','Computadores com softwares apropriados para a disciplina',
'Nota Final = 60% MAC + 40% Prova e Frequencia 75% ','Tecnologias para desenvolvimento de aplicações web com HTML5,CSS3 e JavaScripts')

------------------------------------------------------------------------------------
/* não está na AC */
insert into Professor(ID,LOGON,Senha,Nome,Email,Celular)
values(01,'Erick_prof','impacta','Erick','erickimpacta@gmail.com',999998886)


-----------------------------------MATIAS-------------------------------------------------------
/* Atribuam um Professor diferente à cada uma das disciplinas ofertadas
 ( utilizem o UPDATE alterar uma disciplina ofertada já criada ),
  preenchendo as demais colunas com dados reais ( ver plano de ensino ). ( UPDATE ) */

  update nomedatabela set NomedaColuna = 'valor' where chaveprimaria = 'id' 


----------------------------------- MATIAS-----------------------------------------------------------------------------------------
/* Atribuam datas de inicio e fim de matricula às disciplinas 
ofertadas ( utilizem o UPDATE alterar uma disciplina ofertada já criada ). (UPDATE ) */


-----------------------------------------------------------------------------------------------

/* 	Preencham a solicitação de matricula de pelo menos 3 alunos 
em cada uma das 2 Disciplinas ofertadas. ( INSERT ) */

insert into SolicitacaoMatricula (IDAluno,IDDisciplinaOfertada,DtSolicitacao, IDCoordenador)
values (05,01,'2018-04-03',01)

insert into SolicitacaoMatricula (IDAluno,IDDisciplinaOfertada,DtSolicitacao, IDCoordenador)
values (04,01,'2018-04-08',01)

insert into SolicitacaoMatricula (IDAluno,IDDisciplinaOfertada,DtSolicitacao, IDCoordenador)
values (03,01,'2018-03-05',01)

insert into SolicitacaoMatricula (IDAluno,IDDisciplinaOfertada,DtSolicitacao, IDCoordenador)
values (02,02,'2018-06-03',01)


insert into SolicitacaoMatricula (IDAluno,IDDisciplinaOfertada,DtSolicitacao, IDCoordenador)
values (01,02,'2018-06-12',01)


insert into SolicitacaoMatricula (IDAluno,IDDisciplinaOfertada,DtSolicitacao, IDCoordenador)
values (07,02,'2018-05-22',01)

-------------------------------------------------------------------------------------------------------------------------------------------------------------
/*	Atualize as solicitações de matricula, 
atribuindo status diversos às mesmas, aprovando algumas, rejeitando outras ( UPDATE ) */
update SolicitacaoMatricula set [Status] = 'Aprovada' where ID = 02

update SolicitacaoMatricula set [Status] = 'Rejeitada' where ID = 03

update SolicitacaoMatricula set [Status] = 'Cancelada' where ID = 06
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Criem 2 atividades, e depois vincule uma destas atividades à disciplina ofertada
 “Linguagem SQL”, ano 2018, 1ºsemestre, turma B, curso SI. ( INSERT ) */

insert into atividade (titulo,descricao,conteudo,idProfessor)
values('Construção de formulários com HTML5','Construir um formulário que tenha campos login e senha','Verificar os slides da aula anterior',01)

insert into atividade (titulo,descricao,conteudo,idProfessor)
values('Layout do formulário','Construir o CSS3 do formulário de Login','Verificar os slides da aula anterior',01)

-----------------------------------------------------------------------------------------------------
------------------------- PABLO --------------------
/* Realizem 2 entregas destes trabalhos vinculados, realizados por qualquer aluno. ( INSERT). */

go
CREATE TABLE entrega (
id INT identity(1,1) PRIMARY KEY
, idAluno INT NOT NULL
, titulo VARCHAR (40)
, resposta VARCHAR(1000)
, atividadeVinculada INT NOT NULL
, dtEntrega DATE DEFAULT GETDATE() NOT NULL
, [status] VARCHAR(20) DEFAULT('ENTREGUE') CHECK([status] = 'ENTREGUE' or [status] = 'CORRIGIDO')
, idProfessor INT NOT NULL
, nota DECIMAL(4,2) NULL
, dtAvaliacao DATE NOT NULL
, obs VARCHAR(1000)
, CONSTRAINT fkAluno FOREIGN KEY (idAluno) REFERENCES aluno (id),
, CONSTRAINT fkProfessor FOREIGN KEY (idProfessor) REFERENCES professor (id),
, CONSTRAINT ckNota CHECK (nota BETWEEN 0 AND 10)
, CONSTRAINT fkAtividadeVinculada FOREIGN KEY (atividadeVinculada)
, REFERENCES atividadeVinculada (id)
)

insert into entrega (idAluno,titulo,resposta,atividadeVinculada,
idProfessor, dtAvaliacao, obs) 
values (1,'Atividade 1', 'segue minha resposta', 1, 1,'16/10/2018', 'Parabéns putinha'),
(1,'Atividade 2', 'segue minha resposta 2', 1, 1,'16/13/2018', 'Parabéns putinha 2')



-------------------------PABLO ----------------------
/* Atualizem uma destas entregas, atribuindo uma nota pelo professor vigente 
daquela disciplina ofertada. ( UPDATE ). */

update entrega set nota ='10' where id ='1'

-------------------------------------------DOUGLAS ----------------------------
/* •	Cadastrem o envio de 1 dúvida de um aluno qualquer, ao professor da
disciplina de Linguagem SQL com a seguinte mensagem: “qual a data de entrega da AC6 ?” ( INSERT ) */


-----------------------------------DOUGLAS ------------------------------
/* Registrem a resposta do professor à mensagem acima, informando que a
“a data de entrega da AC6 é na próxima semana”.(UPDATE) */
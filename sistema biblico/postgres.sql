CREATE USER grupo WITH 
NOSUPERUSER
CREATEDB
CREATEROLE
ENCRYPTED PASSWORD '123456' 
;
DROP DATABASE IF EXISTS biblico;
CREATE DATABASE biblico WITH 
owner = 'grupo'
template = template0
encoding = 'UTF-8'
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'
;
\c "dbname=biblico user=grupo password=123456"

CREATE SCHEMA eliana AUTHORIZATION grupo;

ALTER USER grupo SET 
SEARCH_PATH to eliana, "grupo", public;

SET SEARCH_PATH to eliana, "grupo", public;

CREATE TABLE eliana.profecia (
                cod_profecia INTEGER NOT NULL,
                nome_profecia VARCHAR(60) NOT NULL,
                descricao_profecia VARCHAR(100) NOT NULL,
                CONSTRAINT pk_profecia PRIMARY KEY (cod_profecia)
);
COMMENT ON TABLE eliana.profecia IS 'Tabela que armazena informações sobre profecia';
COMMENT ON COLUMN eliana.profecia.cod_profecia IS 'Código da profecia. É a pk da tabela.';
COMMENT ON COLUMN eliana.profecia.nome_profecia IS 'Nome da profecia';
COMMENT ON COLUMN eliana.profecia.descricao_profecia IS 'Descrição da profecia';


CREATE TABLE eliana.data_relevante (
                cod_data INTEGER NOT NULL,
                dia REAL,
                mes REAL,
                ano INTEGER,
                tempo CHAR(2) CHECK (tempo in('AC', 'DC')),
                cod_profecia INTEGER NOT NULL,
                CONSTRAINT pk_data_relevante PRIMARY KEY (cod_data)
);
COMMENT ON TABLE eliana.data_relevante IS 'É a tabela que armazena informações sobre datas relevantes';
COMMENT ON COLUMN eliana.data_relevante.cod_data IS 'Código da data. É a pk da tabela data relevante.';
COMMENT ON COLUMN eliana.data_relevante.dia IS 'Dia em que o evento aconteceu';
COMMENT ON COLUMN eliana.data_relevante.mes IS 'Mês em que o evento aconteceu';
COMMENT ON COLUMN eliana.data_relevante.ano IS 'Ano em que o evento aconteceu';
COMMENT ON COLUMN eliana.data_relevante.tempo IS 'Tempo em que o evento aconteceu. Checar se o preenchido é AC ou DC';
COMMENT ON COLUMN eliana.data_relevante.cod_profecia IS 'Código da profecia. É uma fk da tabela.';


CREATE TABLE eliana.pessoas (
                cod_pessoas INTEGER NOT NULL,
                nome_pessoas VARCHAR(60) NOT NULL,
                idade INTEGER,
                loc_nascimento VARCHAR(100),
                CONSTRAINT pk_pessoas PRIMARY KEY (cod_pessoas)
);
COMMENT ON TABLE eliana.pessoas IS 'Tabela que armazena informações a respeito das pessoas';
COMMENT ON COLUMN eliana.pessoas.cod_pessoas IS 'Código das pessoas. É a pk da tabela pessoas.';
COMMENT ON COLUMN eliana.pessoas.nome_pessoas IS 'Nome das pessoas';
COMMENT ON COLUMN eliana.pessoas.idade IS 'Idade das pessoas';
COMMENT ON COLUMN eliana.pessoas.loc_nascimento IS 'Local de nascimento das pessoas';


CREATE TABLE eliana.p_ascendem (
                cod_pessoas INTEGER NOT NULL,
                cod_ascensor INTEGER NOT NULL,
                CONSTRAINT pk_p_ascendem PRIMARY KEY (cod_pessoas, cod_ascensor)
);
COMMENT ON TABLE eliana.p_ascendem IS 'Tabela que armazena informações sobre pessoas ascendendo outras pessoas';
COMMENT ON COLUMN eliana.p_ascendem.cod_pessoas IS 'Código das pessoas que ascenderam. É a pk da tabela pessoas.';
COMMENT ON COLUMN eliana.p_ascendem.cod_ascensor IS 'Código das pessoas que auxiliou a ascender. É a pk da tabela pessoas.';


CREATE TABLE eliana.p_local_habitado (
                cod_pessoas INTEGER NOT NULL,
                loc_habitou VARCHAR(100) NOT NULL,
                CONSTRAINT pk_local PRIMARY KEY (cod_pessoas, loc_habitou)
);
COMMENT ON TABLE eliana.p_local_habitado IS 'Tabela que armazena as localizações em que as pessoas já habitaram';
COMMENT ON COLUMN eliana.p_local_habitado.cod_pessoas IS 'Código das pessoas. É a pk da tabela local e também uma fk que referencia a tabela pessoas';
COMMENT ON COLUMN eliana.p_local_habitado.loc_habitou IS 'Local onde a pessoa já habitou';


CREATE TABLE eliana.versiculos (
                cod_versiculos INTEGER NOT NULL,
                nome_versiculo VARCHAR(60) NOT NULL,
                texto_versiculo VARCHAR(300) NOT NULL,
                obj_versiculo VARCHAR(50) NOT NULL,
                reflexao_tema VARCHAR(100) NOT NULL,
                CONSTRAINT pk_versiculos PRIMARY KEY (cod_versiculos)
);
COMMENT ON TABLE eliana.versiculos IS 'Tabela que armazena informações a respeito dos versículos';
COMMENT ON COLUMN eliana.versiculos.cod_versiculos IS 'Código versículo. É a pk da tabela versículos';
COMMENT ON COLUMN eliana.versiculos.nome_versiculo IS 'Nome do versículo.';
COMMENT ON COLUMN eliana.versiculos.texto_versiculo IS 'Texto do versículo.';
COMMENT ON COLUMN eliana.versiculos.obj_versiculo IS 'Objetivo do versículo';
COMMENT ON COLUMN eliana.versiculos.reflexao_tema IS 'Reflexão sobre o tema do versículo';


CREATE TABLE eliana.profecias_aparecem (
                cod_versiculos INTEGER NOT NULL,
                cod_profecia INTEGER NOT NULL,
                CONSTRAINT pk_profecias_aparecem PRIMARY KEY (cod_versiculos, cod_profecia)
);
COMMENT ON TABLE eliana.profecias_aparecem IS 'Tabela que armazena informações acerca das congruências entre as tabelas profecias e versículos';
COMMENT ON COLUMN eliana.profecias_aparecem.cod_versiculos IS 'Código versículo. É a pk da tabela.';
COMMENT ON COLUMN eliana.profecias_aparecem.cod_profecia IS 'Código da profecia. É a pk da tabela.';


CREATE TABLE eliana.versiculos_orientam (
                cod_versiculos INTEGER NOT NULL,
                cod_data INTEGER NOT NULL,
                CONSTRAINT pk_versiculos_orientam PRIMARY KEY (cod_versiculos, cod_data)
);
COMMENT ON TABLE eliana.versiculos_orientam IS 'Tabela que armazena as congruências entre as tabelas versículos e datas relevantes';
COMMENT ON COLUMN eliana.versiculos_orientam.cod_versiculos IS 'Código versículo. É a pk da tabela.';
COMMENT ON COLUMN eliana.versiculos_orientam.cod_data IS 'Código da data. É a pk da tabela.';


CREATE TABLE eliana.mapas (
                cod_mapa INTEGER NOT NULL,
                nome_mapa VARCHAR(60) NOT NULL,
                regiao_mapa VARCHAR(30) NOT NULL,
                relevo_mapa VARCHAR(60) NOT NULL,
                vegetacao VARCHAR(60) NOT NULL,
                clima VARCHAR(60) NOT NULL,
                temp_media VARCHAR(5) NOT NULL,
                temp_maxima VARCHAR(5) NOT NULL,
                temp_minima VARCHAR(5) NOT NULL,
                cod_versiculos INTEGER NOT NULL,
                CONSTRAINT pk_mapas PRIMARY KEY (cod_mapa)
);
COMMENT ON TABLE eliana.mapas IS 'É a tabela que armazena informações a resspeito dos mapas';
COMMENT ON COLUMN eliana.mapas.cod_mapa IS 'Código do mapa. É a pk da tabela.';
COMMENT ON COLUMN eliana.mapas.nome_mapa IS 'Nome do mapa';
COMMENT ON COLUMN eliana.mapas.regiao_mapa IS 'Região do mapa';
COMMENT ON COLUMN eliana.mapas.relevo_mapa IS 'Relevo do mapa';
COMMENT ON COLUMN eliana.mapas.vegetacao IS 'Vegetação do mapa.';
COMMENT ON COLUMN eliana.mapas.clima IS 'Clima do mapa';
COMMENT ON COLUMN eliana.mapas.temp_media IS 'Temperatura média';
COMMENT ON COLUMN eliana.mapas.temp_maxima IS 'Temperatura máxima';
COMMENT ON COLUMN eliana.mapas.temp_minima IS 'Temperatura mínima';
COMMENT ON COLUMN eliana.mapas.cod_versiculos IS 'Código versículo. É uma fk da tabela';


CREATE TABLE eliana.fatos_relevantes (
                cod_fatos INTEGER NOT NULL,
                nome_fatos VARCHAR(60) NOT NULL,
                descricao_fatos VARCHAR(100) NOT NULL,
                cod_versiculos INTEGER NOT NULL,
                CONSTRAINT pk_fatos_relevantes PRIMARY KEY (cod_fatos)
);
COMMENT ON TABLE eliana.fatos_relevantes IS 'É a tabela que armazena informações sobre o fatos relevantes';
COMMENT ON COLUMN eliana.fatos_relevantes.cod_fatos IS 'Código dos fatos. É a pk da tabela fatos relevantes.';
COMMENT ON COLUMN eliana.fatos_relevantes.nome_fatos IS 'Nome dos fatos.';
COMMENT ON COLUMN eliana.fatos_relevantes.descricao_fatos IS 'Descrição dos fatos.';
COMMENT ON COLUMN eliana.fatos_relevantes.cod_versiculos IS 'Código versículo. É uma fk da tabela.';


CREATE TABLE eliana.fatos_envolvem (
                cod_pessoas INTEGER NOT NULL,
                cod_fatos INTEGER NOT NULL,
                CONSTRAINT pk_fatos_envolvem PRIMARY KEY (cod_pessoas, cod_fatos)
);
COMMENT ON TABLE eliana.fatos_envolvem IS 'Tabela que armazena informações acerca da congruência de informações entre as tabelas pessoas e fatoz relevantes';
COMMENT ON COLUMN eliana.fatos_envolvem.cod_pessoas IS 'Código das pessoas. É a pk da tabela.';
COMMENT ON COLUMN eliana.fatos_envolvem.cod_fatos IS 'Código dos fatos. É a pk da tabela';


CREATE TABLE eliana.plano_leitura (
                cod_plano INTEGER NOT NULL,
                obj_p_leitura VARCHAR(50) NOT NULL,
                duracao TIME NOT NULL,
                CONSTRAINT pk_p_leitura PRIMARY KEY (cod_plano)
);
COMMENT ON TABLE eliana.plano_leitura IS 'Tabela que armazena as informações sobre o plano de leitura';
COMMENT ON COLUMN eliana.plano_leitura.cod_plano IS 'Código do plano de leitura. É a PK da tabela, elemento identificador do plano de leitura.';
COMMENT ON COLUMN eliana.plano_leitura.obj_p_leitura IS 'O objetivo do plano de leitura';
COMMENT ON COLUMN eliana.plano_leitura.duracao IS 'Tempo de duração do plano de leitura';


CREATE TABLE eliana.livros (
                cod_livro INTEGER NOT NULL,
                nome_livro VARCHAR(60) NOT NULL,
                quant_capitulo INTEGER NOT NULL,
                epoca DATE NOT NULL,
                abreviatura VARCHAR(5) NOT NULL,
                cod_plano INTEGER NOT NULL,
                CONSTRAINT pk_livros PRIMARY KEY (cod_livro)
);
COMMENT ON TABLE eliana.livros IS 'Tabela que armazena as informações a respeito dos livros';
COMMENT ON COLUMN eliana.livros.cod_livro IS 'Código dos livros. É a pk da tabela livros.';
COMMENT ON COLUMN eliana.livros.nome_livro IS 'Nome dos livros';
COMMENT ON COLUMN eliana.livros.quant_capitulo IS 'Quantidade de capítulos de um livro';
COMMENT ON COLUMN eliana.livros.epoca IS 'Época do livro.';
COMMENT ON COLUMN eliana.livros.abreviatura IS 'Abreviatura do livro';
COMMENT ON COLUMN eliana.livros.cod_plano IS 'Código do plano de leitura. É uma fK da tabela.';


CREATE TABLE eliana.livros_escritos (
                cod_pessoas INTEGER NOT NULL,
                cod_livro INTEGER NOT NULL,
                CONSTRAINT pk_livros_escritos PRIMARY KEY (cod_pessoas, cod_livro)
);
COMMENT ON TABLE eliana.livros_escritos IS 'Tabela que armazena informações acerca da congruência entre as tabelas lvros e pessoas';
COMMENT ON COLUMN eliana.livros_escritos.cod_pessoas IS 'Código das pessoas. É a pk da tabela.';
COMMENT ON COLUMN eliana.livros_escritos.cod_livro IS 'Código dos livros. É a pk da tabela.';


CREATE TABLE eliana.capitulos (
                cod_capitulo INTEGER NOT NULL,
                cod_livro INTEGER NOT NULL,
                nome_capitulo VARCHAR(60) NOT NULL,
                quant_versiculos INTEGER NOT NULL,
                categoria VARCHAR(20) NOT NULL,
                reflexao_tema VARCHAR(100) NOT NULL,
                cod_versiculos INTEGER NOT NULL,
                CONSTRAINT pk_capitulos PRIMARY KEY (cod_capitulo, cod_livro)
);
COMMENT ON TABLE eliana.capitulos IS 'Tabela em que armazena as informações sobre os capítulos';
COMMENT ON COLUMN eliana.capitulos.cod_capitulo IS 'Código do capítulo. É a pk da tabela capítulo.';
COMMENT ON COLUMN eliana.capitulos.cod_livro IS 'Código dos livros. É a pk da tabela e também uma fk, por referenciar a tabela livros';
COMMENT ON COLUMN eliana.capitulos.nome_capitulo IS 'Nome do capítulo';
COMMENT ON COLUMN eliana.capitulos.quant_versiculos IS 'Quantidade de versículos';
COMMENT ON COLUMN eliana.capitulos.categoria IS 'Categoria do livro';
COMMENT ON COLUMN eliana.capitulos.reflexao_tema IS 'Reflexão sobre o tema.';
COMMENT ON COLUMN eliana.capitulos.cod_versiculos IS 'Código versículo. É uma fk da tabela';


ALTER TABLE eliana.data_relevante ADD CONSTRAINT profecia_data_relevante_fk
FOREIGN KEY (cod_profecia)
REFERENCES eliana.profecia (cod_profecia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.profecias_aparecem ADD CONSTRAINT profecia_profecias_aparecem_fk
FOREIGN KEY (cod_profecia)
REFERENCES eliana.profecia (cod_profecia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.versiculos_orientam ADD CONSTRAINT data_relevante_versiculos_orientam_fk
FOREIGN KEY (cod_data)
REFERENCES eliana.data_relevante (cod_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.p_local_habitado ADD CONSTRAINT pessoas_local_fk
FOREIGN KEY (cod_pessoas)
REFERENCES eliana.pessoas (cod_pessoas)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.p_ascendem ADD CONSTRAINT pessoas_p_ascendem_fk
FOREIGN KEY (cod_pessoas)
REFERENCES eliana.pessoas (cod_pessoas)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.p_ascendem ADD CONSTRAINT pessoas_p_ascendem_fk1
FOREIGN KEY (cod_ascensor)
REFERENCES eliana.pessoas (cod_pessoas)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.livros_escritos ADD CONSTRAINT pessoas_livros_escritos_fk
FOREIGN KEY (cod_pessoas)
REFERENCES eliana.pessoas (cod_pessoas)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.fatos_envolvem ADD CONSTRAINT pessoas_fatos_envolvem_fk
FOREIGN KEY (cod_pessoas)
REFERENCES eliana.pessoas (cod_pessoas)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.fatos_relevantes ADD CONSTRAINT versiculos_fatos_relevantes_fk
FOREIGN KEY (cod_versiculos)
REFERENCES eliana.versiculos (cod_versiculos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.mapas ADD CONSTRAINT versiculos_mapas_fk
FOREIGN KEY (cod_versiculos)
REFERENCES eliana.versiculos (cod_versiculos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.capitulos ADD CONSTRAINT versiculos_capitulos_1_fk
FOREIGN KEY (cod_versiculos)
REFERENCES eliana.versiculos (cod_versiculos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.versiculos_orientam ADD CONSTRAINT versiculos_versiculos_orientam_fk
FOREIGN KEY (cod_versiculos)
REFERENCES eliana.versiculos (cod_versiculos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.profecias_aparecem ADD CONSTRAINT versiculos_profecias_aparecem_fk
FOREIGN KEY (cod_versiculos)
REFERENCES eliana.versiculos (cod_versiculos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.fatos_envolvem ADD CONSTRAINT fatos_relevantes_fatos_envolvem_fk
FOREIGN KEY (cod_fatos)
REFERENCES eliana.fatos_relevantes (cod_fatos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.livros ADD CONSTRAINT p_leitura_livros_fk
FOREIGN KEY (cod_plano)
REFERENCES eliana.plano_leitura (cod_plano)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.capitulos ADD CONSTRAINT livros_capitulos_fk
FOREIGN KEY (cod_livro)
REFERENCES eliana.livros (cod_livro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE eliana.livros_escritos ADD CONSTRAINT livros_livros_escritos_fk
FOREIGN KEY (cod_livro)
REFERENCES eliana.livros (cod_livro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- PGPASSWORD='computacao@raiz' psql -U postgres < ~/Desktop/script/script.sql
/*Esta parte inicial do script serve para deletar, caso existam, o banco de 
dados uvv e a role 'andrei'*/
DROP DATABASE IF EXISTS uvv;
DROP ROLE IF EXISTS andrei;

/*Aqui é criada a role andrei, com permissões para criar outras roles e bancos de dados. 
Essa role possui uma senha criptografada.*/
CREATE ROLE andrei WITH LOGIN CREATEDB CREATEROLE ENCRYPTED PASSWORD 'computacao@raiz';

/*Esta é a instrução para criar o banco de dados com todas as especificações contidas no 
arquivo do PSET1.*/
CREATE DATABASE uvv WITH
OWNER andrei
TEMPLATE template0
ENCODING UTF8
LC_COLLATE 'pt_BR.UTF-8'
LC_CTYPE 'pt_BR.UTF-8'
ALLOW_CONNECTIONS TRUE;

--Este comando é usado para acessar o banco de dados "uvv"
\c uvv;

/*Quando se acessa o banco de dados "uvv" o usuário padrão é o "postgres", tornando a ser 
necessário uma especificação para entrar na role "andrei" de fato*/
SET ROLE andrei;

--Aqui é criado o esquema lojas, com autorização dada a role "andrei"
CREATE SCHEMA lojas AUTHORIZATION andrei;

/*Essas alterações foram feitas conforme foi pedido no PSET1 para que "lojas se tornasse o 
 *  primeiro item no search_path padrão role "andrei"*/
ALTER ROLE andrei
SET SEARCH_PATH TO lojas, "$user", public;

--Esta é a criação da tabela "clientes" conforme apresentada no projeto lógica.
/*É interessante apontar a constraint declarada no nível da tabela ao final da instrução 
 * "CREATE TABLE".*/
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38)  NOT NULL,
                email      VARCHAR(255) NOT NULL,
                nome       VARCHAR(255) NOT NULL,
                telefone1  VARCHAR(20),
                telefone2  VARCHAR(20),
                telefone3  VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

--Esses são os comentários de tabela e coluna na tabela clientes.
COMMENT ON TABLE lojas.clientes             IS 'Tabela que reúne dados relativos aos clientes e informações de contato.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Identificador do  cliente. Serve de PK para a tabela.';
COMMENT ON COLUMN lojas.clientes.email      IS 'Reúne os registros de e-mail para contato com os clientes. É uma coluna obrigatória.';
COMMENT ON COLUMN lojas.clientes.nome       IS 'Nome de cada cliente. É uma coluna que não aceita valores nulos.';
COMMENT ON COLUMN lojas.clientes.telefone1  IS 'Registro do primeiro número de telefone do cliente. Faz parte de um atributo multivalorado.';
COMMENT ON COLUMN lojas.clientes.telefone2  IS 'Segundo número de telefone do cliente. É parte de um atributo multivalorado.';
COMMENT ON COLUMN lojas.clientes.telefone3  IS 'Terceiro número de telefone do cliente. É parte de um atributo multivalorado.';

--Aqui é criado a tabela produtos seguindo o projeto lógico.
CREATE TABLE lojas.produtos (
                produto_id                NUMERIC(38) NOT NULL,
                nome VARCHAR(255)         NOT NULL,
                preco_unitario            NUMERIC(10,2),
                detalhes                  BYTEA,
                imagem                    BYTEA,
                imagem_mime_type          VARCHAR(512),
                imagem_arquivo            VARCHAR(512),
                imagem_charset            VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

-- Aqui estão os comentários sobre a tabela e as colunas da tabela "produtos"
COMMENT ON TABLE lojas.produtos                            IS 'Tabela contendo dados acerca dos produtos.';
COMMENT ON COLUMN lojas.produtos.produto_id                IS 'Coluna de identificação para a tabela "produtos". É a PK da tabela.';
COMMENT ON COLUMN lojas.produtos.nome                      IS 'Esse campo serve para indicar o nome do produto. Não aceita nulos.';
COMMENT ON COLUMN lojas.produtos.preco_unitario            IS 'Valor da unidade de cada produto referido na tabela.';
COMMENT ON COLUMN lojas.produtos.detalhes                  IS 'Comentários detalhados acerca do produto em questão.';
COMMENT ON COLUMN lojas.produtos.imagem                    IS 'Valor em BLOB da imagem que corresponde ao produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type          IS 'Essa coluna especifica o tipo de dado contido no campo "imagem".';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo            IS 'Campo destinado a indicar o caminho que deve ser percorrido para chegar no arquivo da imagem propriamente dito.';
COMMENT ON COLUMN lojas.produtos.imagem_charset            IS 'Indica o charset utilizado no armazenamento da imagem,';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data da última atualização da imagem do produto.';

--Essa é a instrução para criar a tabela "lojas"
CREATE TABLE lojas.lojas (
                loja_id                 NUMERIC(38)  NOT NULL,
                nome                    VARCHAR(255) NOT NULL,
                endereco_web            VARCHAR(100),
                endereco_fisico         VARCHAR(512),
                latitude                NUMERIC,
                longitude               NUMERIC,
                logo                    BYTEA,
                logo_mime_type          VARCHAR(512),
                logo_arquivo            VARCHAR(512),
                logo_charset            VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

--Aqui estão localizadas as instruções para definir comentários nas colunas e na tabela.
COMMENT ON TABLE lojas.lojas                          IS 'Tabela que contém dados referentes às lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id                 IS 'Essa coluna é o identificador exclusivo de cada loja. Serve de PK.';
COMMENT ON COLUMN lojas.lojas.nome                    IS 'Nome de cada uma das lojas incluídas na tabela. É um atributo que não aceita nulos.';
COMMENT ON COLUMN lojas.lojas.endereco_web            IS 'URL da página da loja caso exista.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico         IS 'Atributo composto que contém o endereço fisico da loja em questão.';
COMMENT ON COLUMN lojas.lojas.latitude                IS 'Valor da latitude da localização da loja.';
COMMENT ON COLUMN lojas.lojas.longitude               IS 'Valor da longitude da localização da loja.';
COMMENT ON COLUMN lojas.lojas.logo                    IS 'Valor em BLOB (Binary Large Object) da imagem que corresponde à logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type          IS 'Essa coluna especifica o tipo de dado contido no campo "logo".';
COMMENT ON COLUMN lojas.lojas.logo_arquivo            IS 'Campo destinado a indicar o caminho que deve ser percorrido para chegar no arquivo da logo propriamente dito.';
COMMENT ON COLUMN lojas.lojas.logo_charset            IS 'Indica o charset utilizado para armazenar a logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da última atualização da logo da loja.';

--Esta é a instrução para criar a tabela "pedidos"
CREATE TABLE lojas.pedidos (
                pedido_id  NUMERIC(38) NOT NULL,
                data_hora  TIMESTAMP   NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status     VARCHAR(15) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

--Estes são os comentários referentes à tabela e às colunas
COMMENT ON TABLE lojas.pedidos             IS 'Tabela que reúne dados acerca dos pedidos feitos pelos clientes.';
COMMENT ON COLUMN lojas.pedidos.pedido_id  IS 'Campo de identificação exclusiva da tabela "pedidos".  Serve de PK.';
COMMENT ON COLUMN lojas.pedidos.data_hora  IS 'Indica o horário em que o pedido foi feito. É um campo que não aceita nulos.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Essa coluna identifica o cliente que fez o pedido através de uma FK com a tabela "clientes".';
COMMENT ON COLUMN lojas.pedidos.status     IS 'Essa coluna indica se o pedido, por exemplo, foi entregue ou não. Exibe o status do pedido.';
COMMENT ON COLUMN lojas.pedidos.loja_id    IS 'Esse campo é destinado a identificar a loja em que pedido foi feito através de uma FK.';

--Este é o comando para criar a tabela "envios"
CREATE TABLE lojas.envios (
                envio_id         NUMERIC(38)  NOT NULL,
                loja_id          NUMERIC(38)  NOT NULL,
                cliente_id       NUMERIC(38)  NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status           VARCHAR(15)  NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

--Aqui estão os comentários da tabela e das colunas da tabela "envios".
COMMENT ON TABLE lojas.envios                   IS 'Coleção de dados referentes aos envios, incluindo os envolvidos no processo.';
COMMENT ON COLUMN lojas.envios.envio_id         IS 'Essa coluna serve de identificador para a tabela "envios". É uma PK.';
COMMENT ON COLUMN lojas.envios.loja_id          IS 'FK para a tabela "lojas". É o identificador de cada loja.';
COMMENT ON COLUMN lojas.envios.cliente_id       IS 'Essa coluna serve de FK para a tabela "clientes". É o identificador de cada cliente.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Atributo composto que faz referência ao endereço para o qual os produtos pedidos serão entregues.';
COMMENT ON COLUMN lojas.envios.status           IS 'Essa coluna faz referência ao status do envio, podendo ser concluído ou não, por exemplo.';

--Esta é a criação da tabela "pedidos_itens"
CREATE TABLE lojas.pedidos_itens (
                pedido_id       NUMERIC(38)   NOT NULL,
                produto_id      NUMERIC(38)   NOT NULL,
                numero_da_linha NUMERIC(38)   NOT NULL,
                preco_unitario  NUMERIC(10,2) NOT NULL,
                quantidade      NUMERIC(38)   NOT NULL,
                envio_id        NUMERIC(38)   NOT NULL,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

--Estes são os comentários relativos à tabela e às colunas da tabela "pedidos_itens"
COMMENT ON TABLE lojas.pedidos_itens                  IS 'Tabela com dados referentes aos itens contidos nos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id       IS 'Este campo representa o identificador do pedido em questão. É uma PK nesta tabela e, ao mesmo tempo, uma FK que referencia a tabela "pedidos".';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id      IS 'Esta coluna diz respeito ao produto que será referenciado. Serve de PK nesta tabela e FK para a tabela "produtos".';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Esse campo indica a ordem dos produtos no pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario  IS 'Esse atributo, redundante, indica o preço unitário de cada produto, assim como na tabela produtos.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade      IS 'Este campo representa a quantidade pedida do produto em questão. Não são aceitos valores nulos.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id        IS 'Esta coluna faz referencia à tabela "envios" e serve para acompanhar o status de cada produto, como por exemplo se foram entregues ou não.';

--Por fim, essa é a criação da tabela "estoques"
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

--Estes são comentários sobre a tabela e as colunas da tabela "estoques".
COMMENT ON TABLE lojas.estoques             IS 'Tabela cujos dados se referem aos estoques de cada produto contido nas lojas.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Esta coluna serve para a identificação exclusiva dos estoques. É a PK da tabela.';
COMMENT ON COLUMN lojas.estoques.loja_id    IS 'FK que indica a loja cujo estoque está sendo apresentado.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Indica a qual produto está sendo referenciado por cada estoque_id.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Esta coluna serve para armazenar as quantidades de cada produto em cada loja.';

--Esta é uma check constraint que visa previnir o usuário de inserir um preço negativo na coluna preco_unitario
ALTER TABLE lojas.produtos ADD CONSTRAINT ck_preco_unitario
CHECK (preco_unitario > 0);

--Esta check constraint previne o usuário de inserir quantidades negativas na coluna pedidos_itens.quantidade
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT ck_pi_quantidade
CHECK (quantidade > 0);

--Esta check constraint previne o usuário de inserir quantidades negativas na coluna produtos_quantidade
ALTER TABLE lojas.estoques ADD CONSTRAINT ck_e_quantidade
CHECK (quantidade > 0);

/*Este comando ALTER TABLE define uma chave estrangeira na tabela "pedidos" que referencia
 * a tabela "clientes"*/
ALTER TABLE lojas.pedidos ADD CONSTRAINT fk_clientes_pedidos
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Esta constraint foi pedida no arquivo do PSET1 e restringe as possibilidades de strings
 * que podem ser adicionadas como valores na coluna "status" da tabela "pedidos*/
ALTER TABLE lojas.pedidos ADD CONSTRAINT ck_pedidos_status
CHECK (status in ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'));


/*Esta ALTER TABLE define uma FK na tabela "envios" que referencia a tabela "clientes"*/
ALTER TABLE lojas.envios ADD CONSTRAINT fk_clientes_envios
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de uma FK na tabela "estoques" que referencie a tabela "produtos"
ALTER TABLE lojas.estoques ADD CONSTRAINT fk_produtos_estoques
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de uma FK na tabela "pedidos_itens" que referencie a tabela "produtos"
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT fk_produtos_pedidos_itens
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de uma FK na tabela "estoques" que referencie a tabela "lojas"
ALTER TABLE lojas.estoques ADD CONSTRAINT fk_lojas_estoques
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de uma FK na tabela "envios" que referencie a tabela "lojas"
ALTER TABLE lojas.envios ADD CONSTRAINT fk_lojas_envios
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Check constraint pedida no PSET para limitar os dados inseridos na coluna envios.status
ALTER TABLE lojas.envios ADD CONSTRAINT ck_envios_status
CHECK (status in ('CRIADO','ENVIADO','TRANSITO','ENTREGUE'));

--Declaração de uma FK na tabela "pedidos" que referencia a tabela "lojas"
ALTER TABLE lojas.pedidos ADD CONSTRAINT fk_lojas_pedidos
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Esta é uma declaração de FK na tabela "pedidos_itens" que referencia a tabela "pedidos" 
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT fk_pedidos_pedidos_itens
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Esta é uma declaração de FK na tabela "pedidos_itens" que referencia a tabela "envios" 
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT fk_envios_pedidos_itens
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Esta check constraint foi pedida no PSET e impossibilita de as colunas endereco_fisico ou
 * endereco_web estarem  simultaneamente nulas*/
ALTER TABLE lojas.lojas ADD CONSTRAINT ck_endfis_endweb
CHECK (endereco_fisico is not null or endereco_web is not null);

--Este é um comentário para o banco de dados recém criado
comment on database uvv is 'Este banco de dados armazena esquemas relativos às atividades da UVV. Neste trabalho o único esquema produzido foi o "lojas".';

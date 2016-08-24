-- "funcInsertClientes" --

CREATE OR REPLACE FUNCTION "funcInsertClientes"
(
    f_nome varchar(50),
    f_telefone varchar(14),
    f_email varchar(100),
    f_endereco integer,
    f_imagem oid,
    f_rg varchar(15),
    f_cpf varchar(11),
    f_login varchar(20),
    f_senha varchar(32)
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE person integer;  -- Pessoa que está sendo inserida

BEGIN
                            --INSERE PESSOA E CLIENTE--
	WITH pess AS
	(
		INSERT INTO "Pessoas" -- Inserre o cliente na tabela de pessoas
		(
			nome_pessoas,
			telefone_pessoas,
			email_pessoas,
			endereco_pessoas,
			imagem_pessoas,
			login_pessoas,
			senha_pessoas
		)
		VALUES (f_nome, f_telefone, f_email, f_endereco, f_imagem, f_login, f_senha) RETURNING id_pessoas -- Insere a pessoa e retorna o ID
	)
	INSERT INTO "Clientes" SELECT p.id_pessoas, f_rg, f_cpf FROM pess AS p
	    RETURNING pessoa_clientes INTO person; -- Insere o cliente e retorna a pessoa_clientes para a variável person

	RETURN person;

                                --- EXCEÇÕES ---
	EXCEPTION
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Campos obrigatórios estam em branco ao tentar inserir Cliente';
			RETURN NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar inserir Cliente';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Cliente';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertClientes"(varchar(50),varchar(14),varchar(100),integer,oid,varchar(15),varchar(11),varchar(20),varchar(32)) IS 'Função para inserir clientes';
-- ddl-end --



-- "funcInsertEnderecos" --

CREATE OR REPLACE FUNCTION "funcInsertEnderecos"
(
    f_cep varchar(9),
    f_numero varchar(5),
    f_complemento varchar(100)
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE endereco integer;

BEGIN

	INSERT INTO "Enderecos"
	(
		cep_enderecos,
		numero_enderecos,
		complemento_enderecos
	)
	VALUES(f_cep, f_numero, f_complemento) RETURNING id_enderecos INTO endereco;

	RETURN endereco;

	EXCEPTION

		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Endereco';
			RETURN NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Endereco';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Endereco';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertEnderecos"(varchar(9),varchar(5),varchar(100)) IS 'Função para inserir endereços';
-- ddl-end --



-- "funcInsertEstados" --

CREATE OR REPLACE FUNCTION "funcInsertEstados" (INOUT f_sigla character(2),  f_nome varchar(50))
	RETURNS character(2)
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	INSERT INTO "Estados"
	(
		sigla_estados,
		nome_estados
	)
	VALUES(f_sigla, f_nome);

	EXCEPTION
    	WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Campos obrigatórios estão em branco ao tentar inserir Estado';
			f_sigla := NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar inserir Estado';
			f_sigla := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Estado';
			f_sigla := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_sigla := NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertEstados"(INOUT character(2),varchar(50)) IS 'Função de inserção de estados';
-- ddl-end --



-- "funcInsertLogradouros" --

CREATE OR REPLACE FUNCTION "funcInsertLogradouros" ( f_nome varchar(50))
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE lograd integer;

BEGIN

	INSERT INTO "Logradouros"(nome_logradouros) VALUES(f_nome) RETURNING id_logradouros INTO lograd;

	RETURN lograd;

	EXCEPTION
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estam em branco ao tentar inserir Logradouro';
			RETURN NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar inserir Logradouro';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Logradouro';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertLogradouros"(varchar(50)) IS 'Função de inserção de logradouros';
-- ddl-end --



-- "funcInsertOperadores" --

CREATE OR REPLACE FUNCTION "funcInsertOperadores"
(
    f_nome varchar(50),
    f_telefone varchar(14),
    f_email varchar(100),
    f_endereco integer,
    f_imagem oid,
    f_login varchar(20),
    f_senha varchar(32),
    f_root boolean DEFAULT FALSE
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE person integer; -- id da pessoa

BEGIN

	WITH pess AS
	(
		INSERT INTO "Pessoas" -- Insere o operador na tabela de pessoas
		(
			nome_pessoas,
			telefone_pessoas,
			email_pessoas,
			endereco_pessoas,
			imagem_pessoas,
			login_pessoas,
			senha_pessoas
		)
		VALUES
		(
			f_nome,
			f_telefone,
			f_email,
			f_endereco,
			f_imagem,
			f_login,
			f_senha
		)
		RETURNING id_pessoas
	)
	INSERT INTO "Operadores" SELECT p.id_pessoas, f_root FROM pess AS p
	    RETURNING pessoa_operadores INTO person;

	RETURN person;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar inserir Operador';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Campos obrigatórios estão em branco ao tentar inserir Operador';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Operador';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertOperadores"(varchar(50),varchar(14),varchar(100),integer,oid,varchar(20),varchar(32),boolean) IS 'Função para inserir operadores';
-- ddl-end --



-- "funcInsertDependentes" --

CREATE OR REPLACE FUNCTION "funcInsertDependentes"
(
    f_nome varchar(50),
    f_telefone varchar(14),
    f_email varchar(100),
    f_endereco integer,
    f_imagem oid,
    f_login varchar(20),
    f_senha varchar(32),
    f_cliente integer
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE person integer;

BEGIN

	WITH pess AS
	(
		INSERT INTO "Pessoas"	-- Insere o dependente em "Pessoas"
		(
			nome_pessoas,
			telefone_pessoas,
			email_pessoas,
			endereco_pessoas,
			imagem_pessoas,
			login_pessoas,
			senha_pessoas
		)
		VALUES
		(
			f_nome,
			f_telefone,
			f_email,
			f_endereco,
			f_imagem,
			f_login,
			f_senha
		)
		RETURNING id_pessoas	-- Retorna o id da pessoa inserida
	)
	INSERT INTO "Dependentes" SELECT p.id_pessoas, f_cliente FROM pess AS p
		RETURNING pessoa_dependentes INTO person;

	RETURN person;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Um ou mais chaves únicas foram violadas ao tentar inserir Dependente';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Dependente';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Um ou mais constraints foram violadas ao tentar inserir Dependente';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertDependentes"(varchar(50),varchar(14),varchar(100),integer,oid,varchar(20),varchar(32),integer) IS 'Função para inserir dependentes';
-- ddl-end --



-- "funcInsertFilmes" --

CREATE OR REPLACE FUNCTION "funcInsertFilmes"
(
    f_nome varchar(50),
    f_valor money,
    f_custo money,
    f_unidade character(3),
    f_barcode varchar(14),
    f_estoque numeric(6,2),
    f_genero smallint,
    f_trailer varchar(100),
    f_urltrailer varchar(100),
    f_idademin smallint,
    f_produtora smallint,
    f_distribuidora smallint,
    f_sinopse text,
    f_capa oid,
    f_tipofisicomidia smallint,
    f_duracao numeric(5,2),
    f_formatotela smallint,
    f_audios smallint[],
    f_legendas smallint[],
    f_elenco integer[]
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE filme integer;

BEGIN
		--Insert Produtos--
	WITH prod AS
	(
		INSERT INTO "Produtos"
		(
			nome_produtos,
			preco_produtos,
			custo_produtos,
			unidade_produtos,
			barcode_produtos,
			estoque_produtos,
			tipo_produtos
		)
		VALUES
		(
			f_nome,
			f_valor,
			f_custo,
			f_unidade,
			f_barcode,
			f_estoque,
			'Midia'
		) RETURNING id_produtos	-- Retorna o ID do produto inserido
	),
	mid AS
	(
		INSERT INTO "Midias"	-- Insert Midia --
		(
			produto_midias,
			genero_midias,
			trailer_midias,
			urltrailer_midias,
			idademin_midias,
			produtora_midias,
			distribuidora_midias,
			sinopse_midias,
			capa_midias,
			tipofisicomidia_midias,
			tipo_midias
		)
		SELECT
			p.id_produtos,
			f_genero,
			f_trailer,
			f_urltrailer,
			f_idademin,
			f_produtora,
			f_distribuidora,
			f_sinopse,
			f_capa,
			f_tipofisicomidia,
			1

		FROM prod AS p RETURNING produto_midias
	)
	INSERT INTO "Filmes" SELECT m.produto_midias, f_duracao, f_formatotela FROM mid AS m
		RETURNING midia_filmes INTO filme; -- Insere o filme na tabela de filmes

	INSERT INTO "AudioMidias" SELECT filme, audio.* FROM unnest(f_audios) AS audio; -- Inserer os audios do filme

	INSERT INTO "LegenMidias" SELECT filme, legenda.* FROM unnest(f_legendas) AS legenda; -- Insere as legendas do filme

	INSERT INTO "Elencos" SELECT filme, ator.* FROM unnest(f_elenco) AS ator; -- Insere o elenco do filme

	RETURN filme;


	EXCEPTION
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Filme';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Filme';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Filme';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertFilmes"
(
	varchar(50),money,money,character(3),varchar(14),numeric(6,2),smallint,smallint,
	varchar(100),varchar(100),smallint,smallint,smallint,text,oid,numeric(5,2),smallint,
	smallint[],smallint[],integer[]
)
IS 'Função para inserir filmes';
-- ddl-end --



-- "funcInsertJogos" --

CREATE OR REPLACE FUNCTION "funcInsertJogos"
(
    f_nome varchar(50),
    f_valor money,
    f_custo money,
    f_unidade character(3),
    f_barcode varchar(14),
    f_estoque numeric(6,2),
    f_gerero smallint,
    f_trailer varchar(100),
    f_urltrailer varchar(100),
    f_idademin smallint,
    f_produtora smallint,
    f_distribuidora smallint,
    f_sinopse text,
    f_capa oid,
    f_tipofisicomidia smallint,
    f_players smallint,
    f_online boolean,
    f_console smallint,
    f_audios smallint[],
    f_legendas smallint[]
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE jogo integer;

BEGIN
		--Insert Produtos--
	WITH prod AS
	(
		INSERT INTO "Produtos"
		(
			nome_produtos,
			preco_produtos,
			custo_produtos,
			unidade_produtos,
			barcode_produtos,
			estoque_produtos,
			tipo_produtos
		)
		VALUES
		(
			f_nome,
			f_valor,
			f_custo,
			f_unidade,
			f_barcode,
			f_estoque,
			'Midia'
		) RETURNING id_produtos	-- Retorna o ID do produto inserido
	),
	mid AS
	(
		INSERT INTO "Midias"	-- Insert Midia --
		(
			produto_midias,
			genero_midias,
			trailer_midias,
			urltrailer_midias,
			idademin_midias,
			produtora_midias,
			distribuidora_midias,
			sinopse_midias,
			capa_midias,
			tipofisicomidia_midias,
			tipo_midias
		)
		SELECT
			p.id_produtos,
			f_genero,
			f_trailer,
			f_urltrailer,
			f_idademin,
			f_produtora,
			f_distribuidora,
			f_sinopse,
			f_capa,
			f_tipofisicomidia,
			2

		FROM prod AS p RETURNING produto_midias
	)
	INSERT INTO "Jogos" SELECT m.produto_midia, f_players, f_online, f_console FROM mid AS m RETURNING midia_jogos INTO jogo; -- Insere o jogo em Jogos

	INSERT INTO "AudioMidias" SELECT jogo, audio.* FROM unnest(f_audios) AS audio; -- Insere os audios do jogo

	INSERT INTO "LegenMidias" SELECT  jogo, legenda.* FROM unnest(f_legendas) AS legenda; -- Insere  as legendas do jogo

	RETURN jogo;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Jogo';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatorios ficaram em branco ao tentar inserir Jogo';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Jogo';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertJogos"
(
	varchar(50),money,money,character(3),varchar(14),numeric(6,2),smallint,smallint,varchar(100),
	varchar(100),smallint,smallint,smallint,text,oid,smallint,smallint,boolean,smallint,smallint[],
	smallint[]
)
IS 'Função para inserir Jogos';
-- ddl-end --



-- "funcInsertOutrosProdutos" --

CREATE OR REPLACE FUNCTION "funcInsertOutrosProdutos"
(
    f_nome varchar(50),
    f_valor money,
    f_custo money,
    f_unidade character(3),
    f_barcode varchar(14),
    f_estoque numeric(6,2)
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE produto integer;

BEGIN

	INSERT INTO "Produtos"
	(
		nome_produtos,
		preco_produtos,
		custo_produtos,
		unidade_produtos,
		barcode_produtos,
		estoque_produtos,
		tipo_produtos
	)
	VALUES
	(
		f_nome,
		f_valor,
		f_custo,
		f_unidade,
		f_barcode,
		f_estoque,
		'Outros'

	) RETURNING id_produtos INTO produto;

	RETURN produto;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Produto';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Produto';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Produto';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertOutrosProdutos"(varchar(50),money,money,character(3),varchar(14),numeric(6,2)) IS 'Função para inserir outros tipos de produtos';
-- ddl-end --


-- "funcInsertUnidades" --

CREATE OR REPLACE FUNCTION "funcInsertUnidades"
(
    INOUT f_abreviacao character(3),
    f_descricao varchar(10)
)
	RETURNS character(3)
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	INSERT INTO "Unidades" VALUES(f_abreviacao, f_descricao);

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Unidades';
			f_abreviacao := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Unidades';
			f_abreviacao := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Unidades';
			f_abreviacao := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_abreviacao := NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertUnidades"(INOUT character(3),varchar(10)) IS 'Função para inserir unidades de produto';
-- ddl-end --



-- "funcInsertLegendas" --

CREATE OR REPLACE FUNCTION "funcInsertLegendas" ( f_nome varchar(20))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE legenda smallint;

BEGIN

	INSERT INTO "Legendas" (nome_legendas) VALUES(f_nome) RETURNING id_legendas INTO legenda;

	RETURN legenda;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Legenda';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Legenda';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Legenda';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertLegendas"(varchar(20)) IS 'Função para inserir legendas de filmes e jogos';
-- ddl-end --



-- "funcInsertFormatosTela" --

CREATE OR REPLACE FUNCTION "funcInsertFormatosTela" ( f_descricao varchar(10))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE formtela smallint;

BEGIN

	INSERT INTO "FormatosTela"(descricao_formatostela) VALUES(f_descricao) RETURNING id_formatostela INTO formtela;

	RETURN formtela;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir FormatoTela';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir FormatoTela';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir FormatoTela';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertFormatosTela"(varchar(10)) IS 'Função para inserir formatos de tela';
-- ddl-end --



-- "funcInsertGeneros" --

CREATE OR REPLACE FUNCTION "funcInsertGeneros" ( f_nome varchar(30))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE genero smallint;

BEGIN

	INSERT INTO "Generos"(nome_genereos) VALUES(f_nome) RETURNING id_generos INTO genero;

	RETURN genero;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Genero';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Genero';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Genero';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertGeneros"(varchar(30)) IS 'Função para inserir generos de filmes e jogos';
-- ddl-end --



-- "funcInsertAtores" --

CREATE OR REPLACE FUNCTION "funcInsertAtores" ( f_nome varchar(50))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE ator smallint;

BEGIN

	INSERT INTO "Atores"(nome_atores) VALUES(f_nome) RETURNING id_atores INTO ator;

	RETURN ator;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Ator';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Ator';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Ator';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertAtores"(varchar(50)) IS 'Função para inserir atores de filmes';
-- ddl-end --



-- "funcInsertTiposMidia" --

CREATE OR REPLACE FUNCTION "funcInsertTiposMidia" ( f_descricao varchar(20))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE tipomidia smallint;

BEGIN

	INSERT INTO "TiposMidia"(descricao_tiposmidia) VALUES(f_descricao) RETURNING id_tiposmidia INTO tipomidia;

	RETURN tipomidia;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir TiposMidia';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir TiposMidia';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir TiposMidia';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertTiposMidia"(varchar(20)) IS 'Função para inserir tipos de mídias';
-- ddl-end --



-- "funcInsertTiposFisicosMidia" --

CREATE OR REPLACE FUNCTION "funcInsertTiposFisicosMidia" ( f_descricao varchar(10))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE tipfismid smallint;

BEGIN

	INSERT INTO "TiposFisicosMidia"(descricao_tiposfisicosmidia) VALUES(f_descricao)
		RETURNING id _tiposfisicosmidia INTO tipfismid;

	RETURN tipfismid;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir TipoFisicoMidia';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir TipoFisicoMidia';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir TipoFisicoMidia';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertTiposFisicosMidia"(varchar(10)) IS 'Função para inserir tipos fisicos de midias';
-- ddl-end --



-- "funcInsertDistribuidoras" --

CREATE OR REPLACE FUNCTION "funcInsertDistribuidoras" ( f_nome varchar(50))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE distrib smallint;

BEGIN

	INSERT INTO "Distribuidoras" (nome_distribuidoras) VALUES(f_nome) RETURNING id_distribuidoras INTO distrib;

	RETURN distrib;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Distribuidora';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Distribuidora';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Distribuidora';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertDistribuidoras"(varchar(50)) IS 'Função para inserir distribuidoras';
-- ddl-end --



-- "funcInsertProdutoras" --

CREATE OR REPLACE FUNCTION "funcInsertProdutoras" ( f_nome varchar(50))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE produtora smallint;

BEGIN

	INSERT INTO "Produtoras"(nome_produtoras) VALUES(f_nome)
		RETURNING id_produtores INTO produtora;

	RETURN produtora;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Produtora';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Produtora';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Produtora';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertProdutoras"(varchar(50)) IS 'Função para inserir produtoras de midias';
-- ddl-end --



-- "funcInsertConsoles" --

CREATE OR REPLACE FUNCTION "funcInsertConsoles" ( f_nome varchar(10))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE console smallint;

BEGIN

	INSERT INTO "Consoles"(nome_consoles) VALUES(f_nome) RETURNING id_consoles INTO console;

	RETURN console;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Console';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Console';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Console';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertConsoles"(varchar(10)) IS 'Função para inserir consoles';
-- ddl-end --



-- "funcInsertAudios" --

CREATE OR REPLACE FUNCTION "funcInsertAudios" ( f_nome varchar(20))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE audio smallint;

BEGIN

	INSERT INTO "Audios"(nome_audios) VALUES(f_nome) RETURNING id_audios INTO audio;

	RETURN audio;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Audio';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Audio';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Audio';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertAudios"(varchar(20)) IS 'Função para inserir audios das mídias';
-- ddl-end --



-- "funcInsertTiposMovCaixa" --

CREATE OR REPLACE FUNCTION "funcInsertTiposMovCaixa" ( f_descricao varchar(10))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE tipmovcai smallint;

BEGIN

	INSERT INTO "TiposMovCaixa"(descricao_tiposmovcaixa) VALUES(f_descricao)
		RETURNING id_tiposmovcaixa INTO tipmovcai;

	RETURN tipmovcai;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir TiposMovCaixa';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir TiposMovCaixa';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir TiposMovCaixa';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertTiposMovCaixa"(varchar(10)) IS 'Função para inserir tipos de movimento de caixa';
-- ddl-end --



-- "funcInsertCaixas" --

CREATE OR REPLACE FUNCTION "funcInsertCaixas" ( f_operador integer,  f_fundo money)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE caixa integer;

BEGIN

	INSERT INTO"Caixas"(operador_caixas, fundo_caixas) VALUES(f_operador, f_fundo) RETURNING id_caixas INTO caixa;

	RETURN caixa;


	EXCEPTION

		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Campos obrigatórios estão em branco ao tentar inserir Caixa';
			RETURN NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Caixa';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Caixa';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertCaixas"(integer,money) IS 'Função para inserir caixas';
-- ddl-end --



-- "funcInsertMovsCaixas" --

CREATE OR REPLACE FUNCTION "funcInsertMovsCaixas"
(
    f_caixa integer,
    f_operador integer,
    f_valor money,
    f_tipo smallint,
    f_observacao text
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE movcaixa  integer;

BEGIN

	INSERT INTO "MovsCaixas"
	(
		caixa_movscaixas,
		operador_movscaixas,
		valor_movscaixas,
		tipo_movscaixas,
		observacao_movscaixas
	)
	VALUES
	(
		f_caixa,
		f_operador,
		f_valor,
		f_tipo,
		f_observacao

	) RETURNING id_movscaixas INTO movcaixa;

	RETURN movcaixa;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir MovCaixa';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos únicos ficaram em branco ao tentar inserir MovCaixa';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir MovCaixa';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertMovsCaixas"(integer,integer,money,smallint,text) IS 'Função para inserir movimentos de caixas';
-- ddl-end --



-- "funcInsertVendas" --

CREATE OR REPLACE FUNCTION "funcInsertVendas"
(
    f_cliente integer,
    f_operador integer,
    f_produtos tipomovproditem[]
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE venda integer;

BEGIN

	INSERT INTO "Vendas"
	(
		cliente_vendas,
		operador_vendas
	)
	VALUES
	(
		f_cliente,
		f_operador

	) RETURNING id_vendas INTO venda;

	INSERT INTO "VendasItens" SELECT venda, produto.* FROM unnest(f_produtos) AS produto;

    -- Registra o movimento --
	SELECT "funcInsertMovProdutos"(f_operador, 'Venda', NULL, f_produtos)

	RETURN venda;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Venda';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Venda';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Venda';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertVendas"(integer,integer,tipomovproditem[]) IS 'Funçao para inserir vendas';
-- ddl-end --



-- "funcInsertLocacoes" --
CREATE OR REPLACE FUNCTION "funcInsertLocacoes"
(
    f_cliente integer,
    f_registradopor integer,
    f_datadevo date,
    f_observacao text,
	f_midias tipomovproditem[],
    f_valorpago money DEFAULT 0
)

	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE loca integer;

BEGIN

	INSERT INTO "Locacoes"
	(
		cliente_locacoes,
		registradopor_locacoes,
		previsaodevolta_locacoes,
		valorpago_locacoes,
		observacao_locacoes
	)
	VALUES
	(
		f_cliente,
		f_registradopor,
		f_datadevo,
		f_valorpago,
		f_observacao
	)
	RETURNING id_locacoes INTO loca;

	INSERT INTO "LocacoesMidias" SELECT loca, m.* FROM unnest(f_midias) AS m;

	-- Registra o movimento --
	SELECT "funcInsertMovProdutos"(f_registradopor, 'Locacao', f_observacao, f_midias)

	RETURN loca;


	EXCEPTION
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estam em branco ao tentar inserir Locação';
			RETURN NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar inserir Locação';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Locacao';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertLocacoes"(integer,integer,date,text,tipomovproditem[],money) IS 'Função para inserir locações';
-- ddl-end --



-- "funcInsertDevolucoes" --
CREATE OR REPLACE FUNCTION "funcInsertDevolucoes"
(
	f_locacao integer, f_valorpago money, f_registradopor integer, f_devolvidopor varchar(50), f_midias tipomovproditem[]
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE devo integer;

BEGIN

	INSERT INTO "Devolucoes"
	(
		locacao_devolucoes,
		valorpago_devolucoes,
		registradopor_devolucoes,
		devolvidopor_devolucoes
	)
	VALUES
	(
		f_locacao,
		f_valorpago,
		f_registradopor,
		f_devolvidopor
	)
	RETURNING id_devolucoes INTO devo;

	INSERT INTO
		"DevolucoesMidias"
	SELECT
		devo, m.produto_tipomovproditem, m.quantidade_tipomovproditem FROM unnest(f_midias) AS m;

	--Registra o movimento--
	SELECT "funcInsertMovProdutos"(f_registradopor, 'Devolucao', NULL, f_midias)

	RETURN devo;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Devolucoes';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Devolucoes';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Devolucoes';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertDevolucoes"(integer,money,integer,tipomovproditem[]) IS 'Função para inserir devoluções';
-- ddl-end --



-- "funcInsertReservas" --

CREATE OR REPLACE FUNCTION "funcInsertReservas"
(
    f_cliente integer,
    f_registradopor integer,
    f_datahoraagen timestamp,
    f_midias integer[]
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE reserva integer;

BEGIN

	INSERT INTO "Reservas"
	(
		cliente_reservas,
		registradopor_reservas,
		datahoraagen_reservas
	)
	VALUES
	(
		f_cliente,
		f_registradopor,
		f_datahoraagen
	)
	RETURNING id_reservas INTO reserva;

	INSERT INTO "ReservasMidias" SELECT reserva, m FROM unnest(f_midias) AS m;

	RETURN reserva;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir Reserva';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir Reserva';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir Reserva';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertReservas"(integer,integer,timestamp,integer[]) IS 'Função para inserir reservas';
-- ddl-end --


-- "funcInsertMovProdutos" --

CREATE OR REPLACE FUNCTION "funcInsertMovProdutos"
(
    f_geridopor integer,
    f_tipo enumtipomovproduto,
	f_observacao text,
    f_itens tipomovproditem[]
)
	RETURNS bigint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE movprod bigint;

BEGIN

	INSERT INTO "MovProdutos"
	(
		geridopor_movprodutos,
		tipo_movprodutos,
		observacao_movprodutos
	)
	VALUES
	(
		f_geridopor,
		f_tipo,
		f_observacao
	)
	RETURNING id_movprodutos INTO movprod;

	INSERT INTO "MovProdutosItens" SELECT movprod, i.* FROM unnest(f_itens) AS i;

	--	ALTERA O ESTOQUE DO PRODUTO	--
	IF f_tipo = 'Venda' OR f_tipo = 'Descarte' THEN

	    UPDATE
	        "Produtos"
	    SET
	        estoque_produtos = estoque_produtos - prod.quantidade_tipomovproditem FROM unnest(f_itens) AS prod
	    WHERE
	        id_produtos = prod.produto_tipomovproditem;

	ELSE IF f_tipo  = 'Compra' THEN

		UPDATE
			"Produtos"
		SET
			estoque_produtos = estoque_produtos + prod.quantidade_tipomovproditem FROM unnest(f_itens) AS prod
		WHERE
			id_produtos = prod.produto_tipomovproditem;

    END IF;

	RETURN movprod;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar inserir MovProduto';
			RETURN NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar inserir MovProduto';
			RETURN NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar inserir MovProduto';
			RETURN NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        RETURN NULL;
END;
$$;

COMMENT ON FUNCTION "funcInsertMovProdutos"(integer,enumtipomovproduto,text,ipomovproditem[]) IS 'Função para inserir movimentos de produtos';
-- ddl-end --

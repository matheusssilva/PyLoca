-- funcUpdateBairros --

CREATE OR REPLACE FUNCTION "funcUpdateBairros"(INOUT f_idbairro integer, f_nome varchar(50))
    RETURNS integer
    LANGUAGE plpgsql
    VOLATILE
    COST 100
    AS $$

BEGIN

    UPDATE "Bairros" SET nome_bairros = f_nome WHERE id_bairros = f_idbairro;

    EXCEPTION

        WHEN NOT_NULL_VIOLATION THEN
            RAISE NOTICE 'Um ou mais campos obrigatorios ficaram em branco ao atualizar Bairro';
            f_idbairro := NULL;
        WHEN UNIQUE_VIOLATION THEN
            RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao atualizar Bairro';
            f_idbairro := NULL;
        WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
            RAISE NOTICE 'Uma ou mais foram violadas ao atualizar Bairro';
            f_idbairro := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idbairro := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateBairros"(INOUT integer, varchar(50)) IS 'Função para alterar bairros';
-- end-ddl --



-- "funcUpdateCeps" --

CREATE OR REPLACE FUNCTION "funcUpdateCeps"
(
    f_cep varchar(9),
    INOUT f_newcep varchar(9),
    f_uf character(2),
    f_cidade integer,
    f_bairro integer,
    f_logradouro integer
)
	RETURNS varchar(9)
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE
	    "Ceps"
	SET
	    cep_ceps = f_newcep,
	    uf_ceps = f_uf,
	    cidade_ceps = f_cidade,
	    bairro_ceps = f_bairro,
	    logradouro_ceps = f_logradouro

	WHERE
	    cep_ceps = f_cep;

	EXCEPTION

		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Campos obrigatórios estão em branco ao tentar atualizar Cep';
			f_newcep := NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar atualizar Cep';
			f_newcep := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar atualizar Cep';
			f_newcep := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_newcep := NULL;

END;
$$;

COMMENT ON FUNCTION "funcUpdateCeps"(varchar(9),INOUT varchar(9),character(2),integer,integer,integer) IS 'Função para alterar Ceps';
-- ddl-end --



-- "funcUpdateCidades" --

CREATE OR REPLACE FUNCTION "funcUpdateCidades" (INOUT f_idcidade integer, f_nome varchar(50))
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

    UPDATE
        "Cidades"
    SET
        nome_cidades = f_nome
    WHERE
        id_cidades = f_idcidade;

	EXCEPTION

		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Cidade';
			f_idcidade := NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Cidade';
			f_idcidade := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Cidade';
			f_idcidade := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idcidade := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateCidades"(INOUT integer, varchar(50)) IS 'Função para alterar Cidades';
-- ddl-end --



-- "funcUpdateClientes" --

CREATE OR REPLACE FUNCTION "funcUpdateClientes"
(
    INOUT f_idcliente integer,
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

BEGIN
                            --ALTERA A PESSOA--
	UPDATE
	    "Pessoas" -- Altera o cliente na tabela de pessoas
	SET
		nome_pessoas = f_nome,
		telefone_pessoas = f_telefone,
		email_pessoas = f_email,
		endereco_pessoas = f_endereco,
		imagem_pessoas = f_imagem,
        login_pessoas = f_login,
        senha_pessoas = f_senha
	WHERE
	    id_cliente = f_idcliente;

                            --ALTERA O CLIENTE--
	UPDATE
	    "Clientes"
	SET
	    rg_clientes = f_rg,
	    cpf_clientes = f_cpf
	WHERE
	    pessoa_clientes = f_idcliente;


                                --- EXCEÇÕES ---
	EXCEPTION

		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Campos obrigatórios estam em branco ao tentar alterar Cliente';
			f_idcliente := NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar alterar Cliente';
			f_idcliente := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Cliente';
			f_idcliente := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idcliente := NULL;

END;
$$;

COMMENT ON FUNCTION "funcUpdateClientes"(INOUT integer, varchar(50),varchar(14),varchar(100),integer,oid,varchar(15),varchar(11),varchar(20),varchar(32)) IS 'Função para alterar clientes';
-- ddl-end --



-- "funcUpdateEnderecos" --

CREATE OR REPLACE FUNCTION "funcUpdateEnderecos"
(
    INOUT f_idendereco integer,
    f_cep varchar(9),
    f_numero varchar(5),
    f_complemento varchar(100)
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE
	    "Enderecos"
	SET
	    cep_enderecos = f_cep,
	    numero_enderecos = f_numero,
	    complemento_enderecos = f_complemento
	WHERE
	    id_enderecos = f_idendereco;


	EXCEPTION

		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Endereco';
			f_idendereco := NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Endereco';
			f_idendereco := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Endereco';
			f_idendereco := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idendereco := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateEnderecos"(INOUT integer, varchar(9),varchar(5),varchar(100)) IS 'Função para alterar endereços';
-- ddl-end --



-- "funcUpdateEstados" --

CREATE OR REPLACE FUNCTION "funcUpdateEstados" (f_sigla character(2), INOUT f_newsigla character(2), f_nome varchar(50))
	RETURNS character(2)
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE
	    "Estados"
	SET
	    sigla_estados = f_newsigla,
	    nome_estados = f_nome
	WHERE
	    sigla_estados = f_sigla;


	EXCEPTION

    	WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Campos obrigatórios estão em branco ao tentar alterar Estado';
			f_newsigla := NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar alterar Estado';
			f_newsigla := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Estado';
			f_newsigla := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_newsigla := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateEstados"(character(2),INOUT character(2),varchar(50)) IS 'Função alterar estados';
-- ddl-end --



-- "funcUpdateLogradouros" --

CREATE OR REPLACE FUNCTION "funcUpdateLogradouros" (INOUT f_idlogradouro integer, f_nome varchar(50))
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE
	    "Logradouros"
	SET
	    nome_logradouros = f_nome
	WHERE
	    id_logradouros = f_idlogradouro;


	EXCEPTION

		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estam em branco ao tentar alterar Logradouro';
			f_idlogradouro := NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar alterar Logradouro';
			f_idlogradouro := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Logradouro';
			f_idlogradouro := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idlogradouro := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateLogradouros"(INOUT integer,varchar(50)) IS 'Função para alterar logradouros';
-- ddl-end --



-- "funcUpdateOperadores" --

CREATE OR REPLACE FUNCTION "funcUpdateOperadores"
(
    INOUT f_idoperador integer,
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

BEGIN
                    -- ALTERA A PESSOA --
	UPDATE
	    "Pessoas" -- Altera o operador na tabela de pessoas
	SET
		nome_pessoas = f_nome,
		telefone_pessoas = f_telefone,
		email_pessoas = f_email,
		endereco_pessoas = f_endereco,
		imagem_pessoas = f_imagem,
        login_pessoas = f_login,
        senha_pessoas = f_senha
	WHERE
	    id_pessoas = f_idoperador;


                    -- ALTERA O OPERADOR --
	UPDATE
	    "Operadores" -- Altera o operador na tabela de operadores
	SET
	    root_operadores = f_root
	WHERE
	    pessoa_operadores = f_idoperador;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar alterar Operador';
			f_idoperador := NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Campos obrigatórios estão em branco ao tentar alterar Operador';
			f_idoperador := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Operador';
			f_idoperador := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idoperador := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateOperadores"(INOUT integer,varchar(50),varchar(14),varchar(100),integer,oid,varchar(20),varchar(32),boolean) IS 'Função para alterar operadores';
-- ddl-end --



-- "funcUpdateDependentes" --

CREATE OR REPLACE FUNCTION "funcUpdateDependentes"
(
    INOUT f_iddependente integer,
    f_nome varchar(50),
    f_telefone varchar(14),
    f_email varchar(100),
    f_endereco integer,
    f_imagem oid,
    f_login varchar(20),
    f_senha varchar(32),
    f_cliente integer,
    f_autorizacao boolean DEFAULT TRUE
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN
                -- ALTERA PESSOA --
	UPDATE
	    "Pessoas"
	SET
	    nome_pessoas = f_nome,
	    telefone_pessoas = f_telefone,
	    email_pessoas = f_email,
	    endereco_pessoas = f_endereco,
	    imagem_pessoas = f_imagem,
        login_pessoas = f_login,
        senha_pessoas = f_senha
	WHERE
	    id_pessoas = f_iddependente;


                -- ALTERA DEPENDENTE --
    UPDATE
        "Dependentes"
    SET
        cliente_dependentes = f_cliente,
        autorizacao_dependentes = f_autorizacao
    WHERE
        pessoa_dependentes = f_iddependente;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Um ou mais chaves únicas foram violadas ao tentar alterar Dependente';
			f_iddependente := NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Dependente';
			f_iddependente := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Um ou mais constraints foram violadas ao tentar alterar Dependente';
			f_iddependente := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_iddependente := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateDependentes"(INOUT integer,varchar(50),varchar(14),varchar(100),integer,oid,varchar(20),varchar(32),integer, boolean) IS 'Função para alterar dependentes';
-- ddl-end --



-- "funcUpdateFilmes" --

CREATE OR REPLACE FUNCTION "funcUpdateFilmes"
(
    INOUT f_idfilme integer,
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

DECLARE oldaudios smallint[]; oldlegendas smallint[]; oldelenco integer[];

BEGIN

		--ALTERA O PRODUTO--
    UPDATE
        "Produtos"
	SET
		nome_produtos = f_nome,
		preco_produtos = f_valor,
		custo_produtos = f_custo,
		unidade_produtos = f_unidade,
		barcode_produtos = f_barcode,
		estoque_produtos = f_estoque
    WHERE
        id_produtos = f_idfilme;


        -- ALTERA A MIDIA --
	UPDATE
	    "Midias"
	SET
		genero_midias = f_genero,
		trailer_midias = f_trailer,
		urltrailer_midias = f_urltrailer,
		idademin_midias = f_idademin,
		produtora_midias = f_produtora,
		distribuidora_midias = f_distribuidora,
		sinopse_midias = f_sinopse,
		capa_midias = f_capa,
		tipofisicomidia_midias = f_tipofisicomidia
	WHERE
	    produto_midias = f_idfilme;


	        -- ALTERA O FILME --
	UPDATE
	    "Filmes"
	SET
	    duracao_filmes = f_duracao,
	    formatotela_filmes = f_formatotela
	WHERE
	    midia_filmes = f_idfilme;


	        -- ALTERA OS AUDIOS --
	oldaudios := (SELECT array_agg(audio_audiomidias) FROM "AudioMidias" WHERE midia_audiomidias = f_idfilme); -- Pega os audios atuais

	IF NOT (oldaudios <@ f_audios AND oldaudios @> f_audios) THEN

	    DELETE FROM "AudioMidias" WHERE midia_audiomidias = f_idfilme AND audio_audiomidias IN  -- Deleta os audios removidos
	    (
	        SELECT unnest(oldaudios) EXCEPT SELECT unnest(f_audios)
	    );

	    INSERT INTO "AudioMidias" SELECT f_idfilme, audio FROM unnest(f_audios) AS audio WHERE audio IN -- Insere os novos audios
	    (
	        SELECT unnest(f_audios) EXCEPT SELECT unnest(oldaudios)
	    );

	END IF;

	        -- ALTERA AS LEGENDAS --
	oldlegendas := (SELECT array_agg(legenda_legenmidias) FROM "LegenMidias" WHERE midia_legenmidias = f_idfilme); -- Pega as legendas atuais

	IF NOT (oldlegendas <@ f_legendas AND oldlegendas @> f_legendas) THEN

	    DELETE FROM "LegenMidias" WHERE midia_legenmidias = f_idfilme AND legenda_legenmidias IN -- Deleta as legenda removidas
	    (
	        SELECT unnest(oldlegendas) EXCEPT SELECT unnest(f_legendas)
	    );

	    INSERT INTO "LegenMidias" SELECT f_idfilme, legenda FROM unnest(f_legendas) AS legenda WHERE legenda IN -- Insere as novas legendas
	    (
	        SELECT unnest(f_legendas) EXCEPT SELECT unnest(oldlegendas)
	    );

	END IF;

            -- ALTERA O ELENCO --
    oldelenco := (SELECT array_agg(ator_elencos) FROM "Elencos" WHERE filme_elencos = f_idfilme); -- Pega o elenco atual

    IF NOT (oldelenco <@ f_elenco AND oldelenco @> f_elenco) THEN

        DELETE FROM "Elencos" WHERE filme_elencos = f_idfilme AND ator_elencos IN -- Deleta os atores removidos
        (
            SELECT unnest(oldelenco) EXCEPT SELECT unnest(f_elenco)
        );

        INSERT INTO "Elencos" SELECT f_idfilme, ator FROM unnest(f_elenco) AS ator WHERE ator IN -- Insere os novos atores
        (
            SELECT unnest(f_elenco) EXCEPT SELECT unnest(oldelenco)
        );

    END IF;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Filme';
			f_idfilme := NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Filme';
			f_idfilme := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Filme';
			f_idfilme := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idfilme := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateFilmes"
(
    INOUT integer,varchar(50),money,money,character(3),varchar(14),numeric(6,2),smallint,
    varchar(100),varchar(100),smallint,smallint,smallint,text,oid,smallint,numeric(5,2),
    smallint,smallint[],smallint[],integer[]
)
IS 'Função para alterar filmes';
-- ddl-end --



-- "funcUpdateJogos" --

CREATE OR REPLACE FUNCTION "funcUpdateJogos"
(
    INOUT f_idjogo integer,
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

DECLARE oldaudios smallint[]; oldlegendas smallint[];

BEGIN
		-- ALTERA O PRODUTO --

	UPDATE
	    "Produtos"
	SET
		nome_produtos = f_nome,
		preco_produtos = f_valor,
		custo_produtos = f_custo,
		unidade_produtos = f_unidade,
		barcode_produtos = f_barcode,
		estoque_produtos = f_estoque
	WHERE
	    id_produtos = f_idjogo;


        -- ALTERA A MIDIA --

	UPDATE
	    "Midias"
	SET
		genero_midias = f_genero,
		trailer_midias = f_trailer,
		urltrailer_midias = f_urltrailer,
		idademin_midias = f_idademin,
		produtora_midias = f_produtora,
		distribuidora_midias = f_distribuidora,
		sinopse_midias = f_sinopse,
		capa_midias = f_capa,
		tipofisicomidia_midias = f_tipofisicomidia
	WHERE
	    produto_midias = f_idjogo;


        -- ALTERA O JOGO --

	UPDATE
	    "Jogos"
	SET
	    players_jogos = f_players,
	    online_jogos = f_online,
	    console_jogos = f_console
    WHERE
        midia_jogos = f_idjogo;


        -- ALTERA OS AUDIOS DO JOGO --
    oldaudios := (SELECT audio_audiomidias FROM "AudioMidias" WHERE midia_audiomidias = f_idjogo); -- Pega os audios atuais do jogo

    IF NOT (oldaudios <@ f_audios AND oldaudios @> f_audios) THEN

        DELETE FROM "AudioMidias" WHERE midia_audiomidias = f_idjogo AND audio_audiomidias IN -- Deleta os audios removidos
        (
            SELECT unnest(oldaudios) EXCEPT SELECT unnest(f_audios)
        );

        INSERT INTO "AudioMidias" SELECT f_idjogo, audio FROM unnest(f_audios) AS audio WHERE audio IN -- Insere os audios novos
        (
            SELECT unnest(f_audios) EXCEPT SELECT unnest(oldaudios)
        );

    END IF;


        -- ALTERA AS LEGENDAS DA MIDIA --
    oldlegendas := (SELECT legenda_legenmidias FROM "LegenMidias" WHERE midia_legenmidias = f_idjogo); -- Pega as legendas atuais

    IF NOT (oldlegendas <@ f_legendas AND oldlegendas @> f_legendas) THEN

        DELETE FROM "LegenMidias" WHERE midia_legenmidias = f_idjogo AND legenda_legenmidias IN -- Deleta as legendas removidas
        (
            SELECT unnest(oldlegendas) EXCEPT SELECT unnest(f_legendas)
        );

        INSERT INTO "LegenMidias" SELECT f_idjogo, legenda FROM unnest(f_legendas) AS legenda WHERE legenda IN -- Insere os audios novos
        (
            SELECT unnest(f_legendas) EXCEPT SELECT unnest(oldlegendas)
        );

    END IF;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Jogo';
			f_idjogo := NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatorios ficaram em branco ao tentar alterar Jogo';
			f_idjogo := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Jogo';
			f_idjogo := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idjogo := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateJogos"
(
    INOUT integer,varchar(50),money,money,character(3),varchar(14),numeric(6,2),smallint,
    varchar(100),varchar(100),smallint,smallint,smallint,text,oid,smallint,smallint,boolean,
    smallint,smallint[],smallint[]
)
IS 'Função para alterar Jogos';
-- ddl-end --



-- "funcUpdateOutrosProdutos" --

CREATE OR REPLACE FUNCTION "funcUpdateOutrosProdutos"
(
    INOUT f_idproduto integer,
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

BEGIN

	UPDATE
	    "Produtos"
	SET
		nome_produtos = f_nome,
		preco_produtos = f_valor,
		custo_produtos = f_custo,
		unidade_produtos = f_unidade,
		barcode_produtos = f_barcode,
		estoque_produtos = f_estoque
    WHERE
        id_produtos = f_idproduto;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Produto';
			f_idproduto := NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Produto';
			f_idproduto := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Produto';
			f_idproduto := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idproduto := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateOutrosProdutos"
(
    INOUT integer,varchar(50),money,money,character(3),varchar(14),numeric(6,2)
)
IS 'Função para alterar outros tipos de produtos';
-- ddl-end --



-- "funcUpdateUnidades" --

CREATE OR REPLACE FUNCTION "funcUpdateUnidades"
(
    f_abreviacao character(3),
    INOUT f_newabreviacao character(3),
    f_descricao varchar(10)
)
	RETURNS character(3)
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "Unidades" SET abreviacao_unidades = f_newabreviacao, descricao_unidades = f_descricao
	    WHERE abreviacao_unidades = f_abreviacao;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Unidades';
			f_newabreviacao := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Unidades';
			f_newabreviacao := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Unidades';
			f_newabreviacao := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_newabreviacao := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateUnidades"(character(3),INOUT character(3),varchar(10)) IS 'Função para alterar unidades de produto';
-- ddl-end --



-- "funcUpdateLegendas" --

CREATE OR REPLACE FUNCTION "funcUpdateLegendas" (INOUT f_idlegenda smallint, f_nome varchar(20))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "Legendas" SET nome_legendas = f_nome WHERE id_legendas = f_idlegenda;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Legenda';
			f_idlegenda := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Legenda';
			f_idlegenda := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Legenda';
			f_idlegenda := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idlegenda := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateLegendas"(INOUT smallint,varchar(20)) IS 'Função para inserir legendas de filmes e jogos';
-- ddl-end --



-- "funcUpdateFormatosTela" --

CREATE OR REPLACE FUNCTION "funcUpdateFormatosTela" (INOUT f_idformato smallint, f_descricao varchar(10))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "FormatosTela" SET descricao_formatostela = f_descricao WHERE id_formatostela = f_idformato;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar FormatoTela';
			f_idformato := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar FormatoTela';
			f_idformato := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar FormatoTela';
			f_idformato := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idformato := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateFormatosTela"(INOUT smallint, varchar(10)) IS 'Função para alterar formatos de tela';
-- ddl-end --



-- "funcUpdateGeneros" --

CREATE OR REPLACE FUNCTION "funcUpdateGeneros" (INOUT f_idgenero smallint, f_nome varchar(30))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "Generos" SET nome_genereos = f_nome WHERE id_generos = f_idgenero;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Genero';
			f_idgenero := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Genero';
			f_idgenero := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Genero';
			f_idgenero := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idgenero := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateGeneros"(INOUT smallint,varchar(30)) IS 'Função para alterar generos de filmes e jogos';
-- ddl-end --



-- "funcUpdateAtores" --

CREATE OR REPLACE FUNCTION "funcUpdateAtores" (INOUT f_idator smallint, f_nome varchar(50))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "Atores" SET nome_atores = f_nome WHERE id_atores = f_idator;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Ator';
			f_idator := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Ator';
			f_idator := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Ator';
			f_idator := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idator := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateAtores"(INOUT smallint,varchar(50)) IS 'Função para alterar atores de filmes';
-- ddl-end --



-- "funcUpdateTiposMidia" --

CREATE OR REPLACE FUNCTION "funcUpdateTiposMidia" (INOUT f_idtipomidia smallint, f_descricao varchar(20))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "TiposMidia" SET descricao_tiposmidia = f_descricao WHERE id_tiposmidia = f_idtipomidia;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar TiposMidia';
			f_idtipomidia := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar TiposMidia';
			f_idtipomidia := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar TiposMidia';
			f_idtipomidia := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idtipomidia := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateTiposMidia"(INOUT smallint,varchar(20)) IS 'Função para alterar tipos de mídias';
-- ddl-end --



-- "funcUpdateTiposFisicosMidia" --

CREATE OR REPLACE FUNCTION "funcUpdateTiposFisicosMidia" (INOUT f_idtipofisicomidia smallint, f_descricao varchar(10))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "TiposFisicosMidia" SET descricao_tiposfisicosmidia = f_descricao
	    WHERE id_tiposfisicosmidia = f_idtipofisicomidia;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar TipoFisicoMidia';
			f_idtipofisicomidia := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar TipoFisicoMidia';
			f_idtipofisicomidia := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar TipoFisicoMidia';
			f_idtipofisicomidia := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idtipofisicomidia := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateTiposFisicosMidia"(INOUT smallint,varchar(10)) IS 'Função para alterar tipos fisicos de midias';
-- ddl-end --



-- "funcUpdateDistribuidoras" --

CREATE OR REPLACE FUNCTION "funcUpdateDistribuidoras" (INOUT f_iddistribuidor smallint, f_nome varchar(50))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "Distribuidoras" SET nome_distribuidoras = f_nome WHERE id_distribuidoras = f_iddistribuidor;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Distribuidora';
			f_iddistribuidor := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Distribuidora';
			f_iddistribuidor := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Distribuidora';
			f_iddistribuidor := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_iddistribuidor := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateDistribuidoras"(INOUT smallint,varchar(50)) IS 'Função para alterar distribuidoras';
-- ddl-end --



-- "funcUpdateProdutoras" --

CREATE OR REPLACE FUNCTION "funcUpdateProdutoras" (INOUT f_idprodutora smallint, f_nome varchar(50))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "Produtoras" SET nome_produtoras = f_nome WHERE id_produtores = f_idprodutora;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Produtora';
			f_idprodutora := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao alterar Produtora';
			f_idprodutora := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Produtora';
			f_idprodutora := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idprodutora := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateProdutoras"(INOUT smallint,varchar(50)) IS 'Função para alterar produtoras de midias';
-- ddl-end --


-- "funcUpdateConsoles" --

CREATE OR REPLACE FUNCTION "funcUpdateConsoles" (INOUT f_idconsole smallint, f_nome varchar(10))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "Consoles" SET nome_consoles = f_nome WHERE id_consoles = f_idconsole;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Console';
			f_idconsole := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Console';
			f_idconsole := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Console';
			f_idconsole := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idconsole := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateConsoles"(INOUT smallint,varchar(10)) IS 'Função para alterar consoles';
-- ddl-end --



-- "funcUpdateAudios" --

CREATE OR REPLACE FUNCTION "funcUpdateAudios" (INOUT f_idaudio smallint, f_nome varchar(20))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "Audios" SET nome_audios = f_nome WHERE id_audios = f_idaudio;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Audio';
			f_idaudio := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Audio';
			f_idaudio := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Audio';
			f_idaudio := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idaudio := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateAudios"(INOUT smallint,varchar(20)) IS 'Função para alterar audios das mídias';
-- ddl-end --



-- "funcUpdateTiposMovCaixa" --

CREATE OR REPLACE FUNCTION "funcUpdateTiposMovCaixa"(INOUT f_idtipomovcaixa smallint, f_descricao varchar(10))
	RETURNS smallint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE "TiposMovCaixa" SET descricao_tiposmovcaixa = f_descricao WHERE id_tiposmovcaixa = f_idtipomovcaixa;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar TiposMovCaixa';
			f_idtipomovcaixa := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar TiposMovCaixa';
			f_idtipomovcaixa := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar TiposMovCaixa';
			f_idtipomovcaixa := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idtipomovcaixa := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateTiposMovCaixa"(INOUT smallint,varchar(10)) IS 'Função para alterar tipos de movimento de caixa';
-- ddl-end --



-- "funcUpdateMovsCaixas" --

CREATE OR REPLACE FUNCTION "funcUpdateMovsCaixas"
(
    INOUT f_caixa integer,
    f_valor money,
    f_tipo smallint,
    f_observacao text
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

BEGIN

	UPDATE
	    "MovsCaixas"
	SET
		valor_movscaixas = f_valor,
		tipo_movscaixas = f_tipo,
		observacao_movscaixas = f_observacao
	WHERE
		caixa_movscaixas = f_caixa;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar MovCaixa';
			f_caixa := NULL;
		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos únicos ficaram em branco ao tentar alterar MovCaixa';
			f_caixa := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar MovCaixa';
			f_caixa := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_caixa := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateMovsCaixas"(INOUT integer,money,smallint,text) IS 'Função para alterar movimentos de caixas';
-- ddl-end --



-- "funcUpdateLocacoes" --

CREATE OR REPLACE FUNCTION "funcUpdateLocacoes"
(
    INOUT f_idlocacao integer,
    f_cliente integer,
    f_datadevo date,
    f_valortotal money,
    f_valorpago money,
    f_valordevido money,
    f_observacao text,
    f_midias integer[]
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE oldmidias integer[];

BEGIN

	UPDATE
	    "Locacoes"
	SET
		cliente_locacoes = f_cliente,
		previsaodevolta_locacoes = f_datadevo,
		valortotal_locacoes = f_valortotal,
		valorpago_locacoes = f_valorpago,
		valordevido_locacoes = f_valordevido,
		observacao_locacoes = f_observacao
    WHERE
		id_locacoes = f_idlocacao;


        -- ALTERA AS MÍDIAS --
    oldmidias := (SELECT array_agg(midia_locacoesmidias) FROM "LocacoesMidias" WHERE locacao_locacoesmidias = f_idlocacao); -- Pega as midias atuais

    IF NOT (oldmidias <@ f_midias AND oldmidias @> f_midias) THEN -- If os vetores não são iguais

	    DELETE FROM "LocacoesMidias" WHERE locacao_locacoesmidias = f_idlocacao AND midia_locacoesmidias IN -- Deleta as mídias que não estão no novo vetor
	    (
	        SELECT unnest(oldmidias) EXCEPT SELECT unnest(f_midias)
	    );

        INSERT INTO "LocacoesMidias" SELECT f_idlocacao, m FROM unnest(f_midias) AS m WHERE m IN    -- Insere somente as novas mídias
        (
            SELECT unnest(f_midias) EXCEPT SELECT unnest(oldmidias)
        );

    END IF;


	EXCEPTION

		WHEN NOT_NULL_VIOLATION THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Locação';
			f_idlocacao := NULL;
		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais unique keys foram violadas ao tentar alterar Locação';
			f_idlocacao := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Locacao';
			f_idlocacao := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idlocacao := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateLocacoes"(INOUT integer,integer,date,money,money,money,text,integer[]) IS 'Função para alterar locações';
-- ddl-end --



-- "funcUpdateDevelucoes" --

CREATE OR REPLACE FUNCTION "funcUpdateDevelucoes"
(
    INOUT f_iddevolucao integer,
    f_valorpago money,
    f_devolvidopor varchar(50),
    f_midias integer[]
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE oldmidias integer[];

BEGIN

	UPDATE
        "Devolucoes"
    SET
        valorpago_devolucoes = f_valorpago, devolvidopor_devolucoes = f_devolvidopor
    WHERE
        id_devolucoes = f_iddevolucao;


    -- ALTERA AS MÍDIAS --
    oldmidias := (SELECT array_agg(midia_devolucoesmidias) FROM "DevolucoesMidias" WHERE devolucao_devolucaomidias = f_iddevolucao); -- Pega as midas atuais

    IF NOT (oldmidias <@ f_midias AND oldmidias @> f_midias) THEN -- Testa se as mídias são iguais

        DELETE FROM "DevolucoesMidias" WHERE devolucao_devolucaomidias = f_iddevolucao AND midia_devolucoesmidias IN -- Deleta as mídias removidas
        (
            SELECT unnest(oldmidias) EXCEPT SELECT unnest(f_midias)
        );

        INSERT INTO "DevolucoesMidias" SELECT f_iddevolucao, m FROM unnest(f_midias) AS m WHERE m IN -- Insere somente as midias novas
        (
            SELECT unnest(f_midias) EXCEPT SELECT unnest(oldmidias)
        );

    END IF;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Devolucoes';
			f_iddevolucao := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Devolucoes';
			f_iddevolucao := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Devolucoes';
			f_iddevolucao := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_iddevolucao := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateDevelucoes"(INOUT integer,money,varchar(50),integer[]) IS 'Função para alterar devoluções';
-- ddl-end --


-- "funcUpdateReservas" --

CREATE OR REPLACE FUNCTION "funcUpdateReservas"
(
    INOUT f_idreserva integer,
    f_cliente integer,
    f_datahoraagen timestamp,
    f_midias integer[]
)
	RETURNS integer
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE oldmidias integer[];

BEGIN

	UPDATE
	    "Reservas"
	SET
		cliente_reservas = f_cliente,
		datahoraagen_reservas = f_datahoraagen
	WHERE
        id_reservas = f_idreserva;


    oldmidias := (SELECT array_agg(midia_reservasmidias) FROM "ReservasMidias" WHERE reserva_reservasmidias = f_idreserva); -- Pega as mídias atuais


    IF NOT (oldmidias @> f_midias AND oldmidias <@ f_midias) THEN -- Se a lista de midias (nova e antiga) não forem iguais

        DELETE FROM "ReservasMidias" WHERE reserva_reservasmidias = f_idreserva AND midia_reservasmidias IN -- Deleta as mídias excluidas
        (
            SELECT unnest(oldmidias) EXCEPT SELECT unnest(f_midias)
        );

	    INSERT INTO "ReservasMidias" SELECT f_idreserva, m FROM unnest(f_midias) AS m WHERE m IN -- Insere as novas mídias
	    (
            SELECT unnest(f_midias) EXCEPT SELECT unnest(oldmidias)
	    );

    END IF;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar Reserva';
			f_idreserva := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar Reserva';
			f_idreserva := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar Reserva';
			f_idreserva := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idreserva := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateReservas"(INOUT integer,integer,timestamp,integer[]) IS 'Função para alterar reservas';
-- ddl-end --



-- "funcUpdateMovProdSaidas" --

CREATE OR REPLACE FUNCTION "funcUpdateMovProdSaidas"
(
    INOUT f_idmovproduto bigint,
    f_tipo enumtipomovproduto,
    f_observacao text,
    f_itens tipomovproditem[]
)
	RETURNS bigint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE olditens tipomovproditem[];

BEGIN

	UPDATE
	    "MovProdutos"
	SET
		valortotal_movprodutos = f_valortotal,
		tipo_movprodutos = f_tipo
	WHERE
		id_movprodutos = f_idmovproduto;


    olditens := (SELECT
	                array_agg((produto_movprodutositens, quantidade_movprodutositens, valor_movprodutositens)::tipomovproditem[])
	            FROM
	                "MovProdutosItens" WHERE movproduto_movprodutositens = f_idmovproduto); -- Pega os produtos antigos

    IF NOT (olditens <@ f_itens AND olditens @> f_itens) THEN -- Se as listas de produtos, antiga e a nova não forem iguais

        --- DELETA OS PRODUTOS REMOVIDOS OU COM A QUANTIDADE ALTERADA---
        DELETE FROM
            "MovProdutosItens"
        WHERE
            movproduto_movprodutositens = f_idmovproduto AND (produto_movprodutositens, quantidade_movprodutositens) IN
        (
            SELECT
                oldi.produto_tipomovproditem, oldi.quantidade_tipomovproditem FROM unnest(olditens) AS oldi
            EXCEPT
                SELECT fi.produto_tipomovproditem, fi.quantidade_tipomovproditem FROM unnest(f_itens) AS fi
        );


        --- INSERE APENAS OS NOVOS ITENS OU COM QUANTIDADE ALTERADA ---
	    INSERT INTO
	        "MovProdutosItens"
	    SELECT
	        movprod, i.* FROM unnest(f_itens) AS i WHERE (i.produto_tipomovproditem, i.quantidade_tipomovproditem) IN
	    (
	        SELECT
	            fi.produto_tipomovproditem, fi.quantidade_tipomovproditem FROM unnest(f_itens) AS fi
	        EXCEPT
	            SELECT oldi.produto_tipomovproditem, oldi.quantidade_tipomovproditem FROM unnest(olditens) AS oldi
	    );


        IF f_tipo = 'Venda' OR f_tipo = 'Descarte' THEN

        --- ALTERA O ESTOQUE DOS PRODUTOS QUE FORAM REMOVIDOS DA LISTA ---
	        UPDATE
	            "Produtos"
	        SET
	            estoque_produtos = estoque_produtos + old_item.quantidade_tipomovproditem FROM unnest(olditens) AS old_item
	        WHERE
	            id_produtos = old_item.produto_tipomovproditem AND (old_item.produto_tipomovproditem, old_item.quantidade_tipomovproditem) IN
            (
                SELECT
                    olditem.produto_tipomovproditem, olditem.quantidade_tipomovproditem FROM unnest(olditens) AS olditem
                EXCEPT
                    SELECT newitem.produto_tipomovproditem, newitem.quantidade_tipomovproditem FROM unnest(f_itens) AS newitem
            );


        --- ALTERA O ESTOQUE DOS NOVOS PRODUTOS ---
	        UPDATE
	            "Produtos"
	        SET
	            estoque_produtos = estoque_produtos - item.quantidade_tipomovproditem FROM unnest(f_itens) AS item
	        WHERE
	            id_produtos = item.produto_tipomovproditem AND (item.produto_tipomovproditem, item.quantidade_tipomovproditem) IN
            (
                    SELECT
                        newitem.produto_tipomovproditem, newitem.quantidade_tipomovproditem FROM unnest(f_itens) AS newitem
                    EXCEPT
                        SELECT olditem.produto_tipomovproditem, olditem.quantidade_tipomovproditem FROM unnest(olditens) AS olditem
            );

        END IF;

	END IF;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar MovProdSaida';
			f_idmovproduto := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar MovProdSaida';
			f_idmovproduto := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar MovProdSaida';
			f_idmovproduto := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idmovproduto := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateMovProdSaidas"(INOUT bigint,money,enumtipomovproduto,tipomovproditem[]) IS 'Função para alterar saidas de produtos';
-- ddl-end --



-- "funcUpdateMovProdEntradas" --

CREATE OR REPLACE FUNCTION "funcUpdateMovProdEntradas"
(
    INOUT f_idmovproduto bigint,
    f_valortotal money,
    f_tipomov enumtipomovproduto,
    f_observacao text,
    f_itens tipomovproditem[]
)
	RETURNS bigint
	LANGUAGE plpgsql
	VOLATILE
	COST 100
	AS $$

DECLARE olditens tipomovproditem[];

BEGIN

	UPDATE
	    "MovProdutos"
	SET
		valortotal_movprodutos = f_valortotal,
		tipo_movprodutos = f_tipomov
    WHERE
        id_movprodutos = f_idmovproduto;


	UPDATE
	    "MovProdutosEntradas"
	SET
	    observacao_movprodutosentradas = f_observacao
    WHERE
		movproduto_movprodutosentradas = f_idmovproduto;


	olditens := (SELECT
	                array_agg((produto_movprodutositens, quantidade_movprodutositens, valor_movprodutositens)::tipomovproditem[])
	            FROM
	                "MovProdutosItens" WHERE movproduto_movprodutositens = f_idmovproduto); -- Pega os produtos antigos


	IF NOT (olditens <@ f_itens AND olditens @> f_itens) THEN -- Se as listas de produtos, antiga e a nova não forem iguais

        --- DELETA OS PRODUTOS REMOVIDOS OU COM A QUANTIDADE ALTERADA---
        DELETE FROM
            "MovProdutosItens"
        WHERE
            movproduto_movprodutositens = f_idmovproduto AND (produto_movprodutositens, quantidade_movprodutositens) IN
        (
            SELECT
                oldi.produto_tipomovproditem, oldi.quantidade_tipomovproditem FROM unnest(olditens) AS oldi
            EXCEPT
                SELECT fi.produto_tipomovproditem, fi.quantidade_tipomovproditem FROM unnest(f_itens) AS fi
        );


        --- INSERE APENAS OS NOVOS ITENS OU COM QUANTIDADE ALTERADA ---
	    INSERT INTO
	        "MovProdutosItens"
	    SELECT movprod, i.* FROM unnest(f_itens) AS i WHERE (i.produto_tipomovproditem, i.quantidade_tipomovproditem) IN
	    (
	        SELECT
	            fi.produto_tipomovproditem, fi.quantidade_tipomovproditem FROM unnest(f_itens) AS fi EXCEPT
	        SELECT
	            oldi.produto_tipomovproditem, oldi.quantidade_tipomovproditem FROM unnest(olditens) AS oldi
	    );



        IF f_tipomov = 'Compra' THEN

        --- ALTERA O ESTOQUE DOS PRODUTOS QUE FORAM REMOVIDOS DA LISTA ---
	        UPDATE
	            "Produtos"
	        SET
	            estoque_produtos = estoque_produtos - old_item.quantidade_tipomovproditem FROM unnest(olditens) AS old_item
	        WHERE
	            id_produtos = old_item.produto_tipomovproditem AND (old_item.produto_tipomovproditem, old_item.quantidade_tipomovproditem) IN
            (
                SELECT
                    olditem.produto_tipomovproditem, olditem.quantidade_tipomovproditem FROM unnest(olditens) AS olditem
                EXCEPT
                    SELECT newitem.produto_tipomovproditem, newitem.quantidade_tipomovproditem FROM unnest(f_itens) AS newitem
            );


        --- ALTERA O ESTOQUE DOS NOVOS PRODUTOS ---
	        UPDATE
	            "Produtos"
	        SET
	            estoque_produtos = estoque_produtos + item.quantidade_tipomovproditem FROM unnest(f_itens) AS item
	        WHERE
	            id_produtos = item.produto_tipomovproditem AND (item.produto_tipomovproditem, item.quantidade_tipomovproditem) IN
                (
                    SELECT
                        newitem.produto_tipomovproditem, newitem.quantidade_tipomovproditem FROM unnest(f_itens) AS newitem
                    EXCEPT
                        SELECT olditem.produto_tipomovproditem, olditem.quantidade_tipomovproditem FROM unnest(olditens) AS olditem
                );

        END IF;

	END IF;


	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais chaves únicas foram violadas ao tentar alterar MovProdEntrada';
			f_idmovproduto := NULL;
		WHEN NOT_NULL_VIOLATION  THEN
			RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar alterar MovProdEntrada';
			f_idmovproduto := NULL;
		WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar alterar MovProdEntrada';
			f_idmovproduto := NULL;
	    WHEN OTHERS THEN
	        RAISE NOTICE 'Erro imprevisto';
	        f_idmovproduto := NULL;
END;
$$;

COMMENT ON FUNCTION "funcUpdateMovProdEntradas"(INOUT bigint,money,enumtipomovproduto,integer,text,tipomovproditem[]) IS 'Função para alterar entradas de produtos';
-- ddl-end --

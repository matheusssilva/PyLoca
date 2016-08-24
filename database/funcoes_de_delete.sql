-- "funcDeleteVendas" --

-- DROP FUNCTION IF EXISTS "funcDeleteVendas"(INOUT integer);
CREATE OR REPLACE FUNCTION "funcDeleteVendas"(INOUT f_idvenda integer)
RETURNS integer	LANGUAGE plpgsql VOLATILE COST 100 AS 
$$

    BEGIN

        -- Altera o Estoque --
        WITH vitens AS
        (
            SELECT produto_vendasitens, quantidade_vendasitens FROM "VendasItens" WHERE venda_vendasitens = f_idvenda
        )
        UPDATE
            "Produtos" 
        SET 
            estoque_produtos = estoque_produtos + vi.quantidade_vendasitens
        FROM
            vitens AS vi 
        WHERE 
            id_produtos = vi.produto_vendasitens;


        -- Deleta os itens da venda e a venda--
        DELETE FROM "Vendas" WHERE id_vendas = f_idvenda;


        EXCEPTION

		    WHEN NOT_NULL_VIOLATION  THEN
			    RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar deletar Venda';
			    f_idvenda := NULL;
		    WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			    RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar deletar Venda';
			    f_idvenda := NULL;
	        WHEN OTHERS THEN
	            RAISE NOTICE 'Erro imprevisto';
	            f_idvenda := NULL;
    END;
$$;

COMMENT ON FUNCTION "funcDeleteVendas"(INOUT integer) IS 'Funçao para deletar vendas';
-- --ddl-end --



-- "funcDeleteMovProdEntradas" --

CREATE OR REPLACE FUNCTION "funcDeleteMovProdEntradas"(INOUT f_idmovproduto bigint) 
RETURNS bigint LANGUAGE plpgsql VOLATILE COST 100 AS 
$$
    BEGIN

        IF (SELECT tipo_movprodutos FROM "MovProdutos" WHERE id_movprodutos = f_idmovproduto) = 'Compra' THEN -- Se o tipo do movimento for uma compra

            -- ALTERA O ESTOQUE --
            WITH produtos AS
            (
                SELECT 
                    produto_movprodutositens, quantidade_movprodutositens 
                FROM 
                    "MovProdutosItens" WHERE movproduto_movprodutositens = f_idmovproduto
            )
            UPDATE 
                "Produtos" 
            SET 
                estoque_produtos = estoque_produtos - p.quantidade_movprodutositens FROM produtos AS p  
            WHERE 
                id_produtos = p.produto_movprodutositens;

        END IF;


        -- DELETA A MOVIMENTAÇÃO --
        DELETE FROM "MovProdutos" WHERE id_movprodutos = f_idmovproduto;
        

        EXCEPTION

		    WHEN NOT_NULL_VIOLATION  THEN
			    RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar deletar MovProdutosEntrada';
			    f_idmovproduto := NULL;
		    WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			    RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar deletar MovProdutosEntrada';
			    f_idmovproduto := NULL;
	        WHEN OTHERS THEN
	            RAISE NOTICE 'Erro imprevisto';
	            f_idmovproduto := NULL;
    END;
$$;

COMMENT ON FUNCTION "funcDeleteMovProdEntradas"
(
    INOUT f_idmovprodutos bigint
    
) IS 'Função para deletar entradas de produstos';
-- ddl-end--



-- "funcDeleteMovProdSaidas" --

CREATE OR REPLACE FUNCTION "funcDeleteMovProdSaidas"(INOUT f_idmovproduto bigint) 
RETURNS bigint LANGUAGE plpgsql VOLATILE COST 100 AS 
$$

    DECLARE tipomov enumtipomovproduto;
    
    BEGIN
        
        tipomov := (SELECT tipo_movprodutos FROM "MovProdutos" WHERE id_movprodutos = f_idmovproduto); -- Pega o tipo do movimento
        
        IF tipomov = 'Venda' OR tipomov = 'Descarte' THEN -- Se o tipo do movimento for uma venda ou um descarte

            -- ALTERA O ESTOQUE --
            WITH produtos AS
            (
                SELECT 
                    produto_movprodutositens, quantidade_movprodutositens 
                FROM 
                    "MovProdutosItens" WHERE movproduto_movprodutositens = f_idmovproduto
            )
            UPDATE 
                "Produtos" 
            SET 
                estoque_produtos = estoque_produtos + p.quantidade_movprodutositens FROM produtos AS p  
            WHERE 
                id_produtos = p.produto_movprodutositens;
        
        END IF;


        -- DELETA A MOVIMENTAÇÃO --
        DELETE FROM "MovProdutos" WHERE id_movprodutos = f_idmovproduto;
        

        EXCEPTION

		    WHEN NOT_NULL_VIOLATION  THEN
			    RAISE NOTICE 'Um ou mais campos obrigatórios estão em branco ao tentar deletar MovProdutosSaida';
			    f_idmovproduto := NULL;
		    WHEN INTEGRITY_CONSTRAINT_VIOLATION THEN
			    RAISE NOTICE 'Uma ou mais constraints foram violadas ao tentar deletar MovProdutosSaida';
			    f_idmovproduto := NULL;
	        WHEN OTHERS THEN
	            RAISE NOTICE 'Erro imprevisto';
	            f_idmovproduto := NULL;
    END;
$$;

COMMENT ON FUNCTION "funcDeleteMovProdEntradas"
(
    INOUT f_idmovprodutos bigint
    
) IS 'Função para deletar entradas de produstos';
-- ddl-end--

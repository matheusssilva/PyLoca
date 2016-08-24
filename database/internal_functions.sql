CREATE OR REPLACE FUNCTION "cpf_is_valid" ( f_cpf VARCHAR ( 14 ) ) RETURNS BOOLEAN LANGUAGE plpgsql IMMUTABLE COST 100 
AS 
$BODY$

    DECLARE 
        cpf_cleaned VARCHAR ( 11 );
        cpf_validated VARCHAR ( 11 );
        sum_multiplications INTEGER;
        multplicator INTEGER;

    BEGIN
        
        cpf_cleaned := regexp_replace ( f_cpf, '\W+', '', 'g' );

        IF cpf_cleaned = '12345678909' OR character_length ( cpf_cleaned  ) != 11 THEN
            RETURN FALSE;
        END IF;
 
        cpf_validated := substring ( cpf_cleaned, 1, 9  );

        WHILE character_length ( cpf_validated ) < 11 LOOP
            
            multplicator := 2;
            sum_multiplications := 0;

            FOR i IN REVERSE character_length ( cpf_validated )..1 LOOP
                
                sum_multiplications := sum_multiplications + substring ( cpf_validated, i, 1 )::INTEGER * multplicator;
                multplicator := multplicator + 1;

            END LOOP;

            IF sum_multiplications % 11 >= 2 THEN
                cpf_validated := cpf_validated || 11 - ( sum_multiplications % 11 );
            ELSE
                cpf_validated := cpf_validated || 0;
            END IF;

        END LOOP;

        IF cpf_cleaned = cpf_validated THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;

    END;
$BODY$ 
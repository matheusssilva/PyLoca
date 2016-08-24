--Begin Insert of Address
CREATE OR REPLACE FUNCTION "insertAddress"
(
    f_zipcode character, f_number character varying, f_complement character varying
)
RETURNS INTEGER AS

$BODY$

    DECLARE addr INTEGER;

    BEGIN

        INSERT INTO
            "Address"(zipcode_address, number_address, complement_address)
        VALUES
        (
    	    f_zipcode, f_number, f_complement
        )
        RETURNING id_address INTO addr;

        RETURN addr;

    END;
$BODY$
LANGUAGE plpgsql VOLATILE COST 100;
--End Insert of Address

--Begin Insert Zipcodes
CREATE OR REPLACE FUNCTION "insertZipcodes"
(
    f_zipnumber character, f_state character, f_city character varying, f_neighborhood character varying, f_street character varying
)
RETURNS void AS

$BODY$

    BEGIN
        INSERT INTO "Zipcodes" VALUES (f_zipnumber, f_state, f_city, f_neighborhood, f_street);
    END;

$BODY$
LANGUAGE plpgsql VOLATILE COST 100;
--End Insert Zipcodes

--Begin Insert Clients
CREATE OR REPLACE FUNCTION "insertClients"
(
    f_name varchar(50), f_telephone varchar(14), f_email varchar(100), f_address integer, f_photo oid, f_login varchar(20),
    f_password varchar(32), f_rg varchar(15), f_cpf varchar(11)
)
RETURNS INTEGER AS

$BODY$

    DECLARE person INTEGER;

    BEGIN

        WITH pess AS
    	(
    		INSERT INTO "Persons"
    		(
    			name_persons, telephone_persons, email_persons,	address_persons, photo_persons,	login_persons, password_persons
    		)
            -- Insere a pessoa e retorna o ID
    		VALUES (f_name, f_telephone, f_email, f_address, f_photo, f_login, f_password) RETURNING id_persons
    	)
        -- Insere o cliente e retorna a pessoa_clientes para a variável person
    	INSERT INTO "Clients" SELECT p.id_persons, f_rg, f_cpf FROM pess AS p RETURNING person_clients INTO person;

    	RETURN person;

    END;

$BODY$
LANGUAGE plpgsql VOLATILE COST 100;
--End Insert Clients

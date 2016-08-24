--Begin Update Zipcodes
CREATE OR REPLACE FUNCTION "updateZipcodes"
(
    f_zipnumber character, f_newzipnumber character, f_state character, f_city character varying, f_neighborhood character varying,
    f_street character varying
)
RETURNS void AS

$BODY$

    BEGIN

        UPDATE
            "Zipcodes"
        SET
            zipnumber_zipcodes    = f_newzipnumber,
            state_zipcodes        = f_state,
            city_zipcodes         = f_city,
            neighborhood_zipcodes = f_neighborhood,
            street_zipcodes       = f_street
        WHERE
        zipnumber_zipcodes = f_zipnumber;

    END;

$BODY$
LANGUAGE plpgsql VOLATILE COST 100;
  --End Update Zipcodes


--Begin Update Address
CREATE OR REPLACE FUNCTION "updateAddress"
(
    f_idaddress integer, f_zipcode character, f_number character varying, f_complement character varying
)
RETURNS void AS

$BODY$

    BEGIN

        UPDATE
            "Address"
        SET
            zipcode_address    = f_zipcode,
            number_address     = f_number,
            complement_address = f_complement
        WHERE
            id_address = f_idaddress;

    END;

$BODY$
LANGUAGE plpgsql VOLATILE COST 100;
--End Update Address


--Begin Update Clients
CREATE OR REPLACE FUNCTION "updateClients"
(
    f_idclient integer, f_name varchar(50), f_telephone varchar(14), f_email varchar(100), f_idaddress integer, f_photo oid,
    f_login varchar(20), f_password varchar(32), f_rg varchar(15), f_cpf varchar(11)
)
RETURNS void AS

$BODY$

    BEGIN
            --ALTERA A PESSOA--
        UPDATE
            "Persons" -- Altera o cliente na tabela de pessoas
        SET
            name_persons= f_name,
            telephone_persons = f_telephone,
            email_persons = f_email,
            address_persons = f_idaddress,
            photo_persons = f_photo,
            login_persons = f_login,
            password_persons = f_password
        WHERE
            id_persons = f_idclient;

            --ALTERA O CLIENTE--
        UPDATE
            "Clients"
        SET
            rg_clients = f_rg,
            cpf_clients = f_cpf
        WHERE
            person_clients = f_idclient;

    END;

$BODY$
LANGUAGE plpgsql VOLATILE COST 100;
--End Update Clients

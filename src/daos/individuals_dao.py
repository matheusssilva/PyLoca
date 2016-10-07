"""
This module contains individuals Data Acces Object classes for data persistence
"""

from .dao import EntityDao
from others import inout
from others.dals import PgSqlDal, CMD_TYPE_TEXT, CMD_TYPE_FUNCTION

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class ZipCodeDao(EntityDao):

    def insert(self, zip_code):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['ZipCodes']['insert'], CMD_TYPE_FUNCTION, (
            zip_code.zip_number,
            zip_code.state,
            zip_code.city,
            zip_code.neighborhood,
            zip_code.street
        )
        )

    def update(self, zip_code):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['ZipCodes']['update'], CMD_TYPE_FUNCTION, (
            zip_code.zip_number,
            zip_code.new_zip_number if 'new_zip_number' in vars(
                zip_code) else zip_code.zip_number,
            zip_code.state,
            zip_code.city,
            zip_code.neighborhood,
            zip_code.street
        )
        )

    def delete(self, zip_code):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(
            sql['ZipCodes']['delete'], CMD_TYPE_TEXT, (zip_code.zip_number,))

    def get(self, zip_number=None):
        """
        Return a list of tuples with the data of registers
        """

        sql = inout.get_queries_file()

        if zip_number:
            return PgSqlDal.execute_query(sql['ZipCodes']['getOneOrMore'], CMD_TYPE_TEXT, (zip_number,))
        else:
            return PgSqlDal.execute_query(sql['Zipcodes']['getAll'], CMD_TYPE_TEXT)

        # return [ZipCode(*zpc) for zpc in cursor.fetchall()] if
        # cursor.rowcount > 0 else []


class AddressDao(EntityDao):

    def insert(self, address):
        """
        Insert a Address object in data base and return the current ID
        """

        sql = inout.get_queries_file()

        return PgSqlDal.execute_query(sql['Address']['insert'], CMD_TYPE_FUNCTION, (
            address.zip_code,
            address.number,
            address.complement
        )
        )

    def update(self, address):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Address']['update'], CMD_TYPE_FUNCTION, (
            address.identifier,
            address.zip_code,
            address.number,
            address.complement
        )
        )

    def delete(self, identifier):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(
            sql['Address']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):

        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Address']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Address']['getAll'], CMD_TYPE_TEXT)

        # return [Address(*addr) for addr in cursor.fetchall()] if
        # cursor.rowcount > 0 else []


class ClientDao(EntityDao):

    def insert(self, client):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Clients']['insert'], CMD_TYPE_FUNCTION, (
            client.person.name,
            client.person.telephone,
            client.person.email,
            client.person.address,
            client.person.photo,
            client.person.login,
            client.person.password,
            client.person.is_authorized,
            client.rg,
            client.cpf, 
            client.birth,
        )
        )

    def update(self, client):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Clients']['update'], CMD_TYPE_FUNCTION, (
            client.person.identifier,
            client.person.name,
            client.person.telephone,
            client.person.email,
            client.person.address.identifier,
            client.person.photo,
            client.person.login,
            client.person.password,
            client.person.is_authorized,
            client.rg,
            client.cpf,
            client.birth,
        )
        )

    def delete(self, identifier):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(
            sql['Clients']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):

        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Clients']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Clients']['getAll'], CMD_TYPE_TEXT)


class DependentDao(EntityDao):

    def insert(self, dependent):

        sql = inout.get_queries_file()

        return PgSqlDal.execute_query(sql['Dependents']['insert'], CMD_TYPE_FUNCTION, (
            dependent.person.name,
            dependent.person.telephone,
            dependent.person.email,
            dependent.person.address,
            dependent.person.photo,
            dependent.person.login,
            dependent.person.password,
            dependent.person.is_authorized,
            dependent.guarantor,
        )
        )

    def update(self, dependent):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Dependents']['update'], CMD_TYPE_FUNCTION, (
            dependent.identifier,
            dependent.person.name,
            dependent.person.telephone,
            dependent.person.email,
            dependent.person.address,
            dependent.person.photo,
            dependent.person.login,
            dependent.person.password,
            dependent.person.is_authorized,
            dependent.guarantor,
        )
        )

    def delete(self, identifier):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(
            sql['Dependents']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):

        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Dependents']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Dependents']['getAll'], CMD_TYPE_TEXT)


class FunctionaryDao(EntityDao):

    def insert(self, functionary):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Functionaries']['insert'], CMD_TYPE_FUNCTION, (
            functionary.person.name,
            functionary.person.telephone,
            functionary.person.email,
            functionary.person.address,
            functionary.person.photo,
            functionary.person.login,
            functionary.person.password,
            functionary.person.is_authorized,
            functionary.is_root
        )
        )
    
    def update(self, functionary):
        
        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Functionaries']['update'], CMD_TYPE_FUNCTION, (
            functionary.identifier,
            functionary.person.name,
            functionary.person.telephone,
            functionary.person.email,
            functionary.person.address,
            functionary.person.photo,
            functionary.person.login,
            functionary.person.password,
            functionary.person.is_authorized,
            functionary.is_root
        )
        )

    def delete(self, identifier):
        
        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Functionaries']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):
        
        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Functionaries']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Functionaries']['getAll'], CMD_TYPE_TEXT)

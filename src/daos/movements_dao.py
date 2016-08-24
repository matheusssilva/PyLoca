"""
This module contains movements Data Acces Object classes for data persistence
"""

from others.dals import PgSqlDal, CMD_TYPE_TEXT, CMD_TYPE_FUNCTION
from others import inout
from .dao import EntityDao

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class BookingDao(EntityDao):

    def insert(self, booking):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Bookings']['insert'], CMD_TYPE_FUNCTION, (
            booking.products,
            booking.client,
            booking.functionary,
            booking.value,
            booking.observations,
            booking.date_time_chosen_remove,
            booking.date_time_removed,
        )
        )

    def update(self, booking):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Bookings']['update'], CMD_TYPE_FUNCTION, (
            booking.identifier,
            booking.products,
            booking.value,
            booking.observations,
            booking.date_time_chosen_remove,
            booking.date_time_removed,
            booking.status
        )
        )

    def delete(self, identifier):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(
            sql['Bookings']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):

        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Bookings']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Bookings']['getAll'], CMD_TYPE_TEXT)


class RentDao(EntityDao):

    def insert(self, rent):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Rents']['insert'], CMD_TYPE_FUNCTION, (
            rent.products,
            rent.client,
            rent.functionary,
            rent.value,
            rent.observations,
            rent.value_paid,
        )
        )

    def update(self, rent):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Rents']['update'], CMD_TYPE_FUNCTION, (
            rent.identifier,
            rent.products,
            rent.value,
            rent.observations,
            rent.value_paid,
            rent.status
        )
        )

    def delete(self, identifier):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(
            sql['Rents']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):

        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Rents']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Rents']['getAll'], CMD_TYPE_TEXT)


class DevolutionDao(EntityDao):

    def insert(self, devolution):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Devolutions']['insert'], CMD_TYPE_FUNCTION, (
            devolution.products,
            devolution.client,
            devolution.functionary,
            devolution.value,
            devolution.observations,
            devolution.rent,
            devolution.returned_by
        )
        )

    def update(self, devolution):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Devolutions']['update'], CMD_TYPE_FUNCTION, (
            devolution.identifier,
            devolution.products,
            devolution.value,
            devolution.observations,
            devolution.returned_by
        )
        )

    def delete(self, identifier):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(
            sql['Devolutions']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):

        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Devolutions']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Devolutions']['getAll'], CMD_TYPE_TEXT)


class CashDeskDao(EntityDao):

    def insert(self, cash_desk):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['CashDesks']['insert'], CMD_TYPE_FUNCTION, (
            cash_desk.functionary,
            cash_desk.cash_fund,
            cash_desk.observations,
        )
        )
    
    def update(self, cash_desk):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['CashDesks']['update'], CMD_TYPE_FUNCTION, (
            cash_desk.identifier,
            cash_desk.cash_fund,
            cash_desk.expected_value,
            cash_desk.value_in_cash,
            cash_desk.date_time_closed,
            cash_desk.observations,
            cash_desk.status
        )
        )

    def delete(self, identifier):
        
        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['CashDesks']['delete'], CMD_TYPE_TEXT, (identifier,))
    
    def get(self, identifier=None):
        
        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['CashDesks']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['CashDesks']['getAll'], CMD_TYPE_TEXT)


class CashDeskMovDao(EntityDao):
    
    def insert(self, cash_desk_mov):
        
        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['CashDeskMovs']['insert'], CMD_TYPE_FUNCTION, (
            cash_desk_mov.cash_desk,
            cash_desk_mov.functionary,
            cash_desk_mov.value,
            cash_desk_mov.mov_type,
            cash_desk_mov.observations
        )
        )

    def update(self, cash_desk_mov):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['CashDeskMovs']['update'], CMD_TYPE_FUNCTION, (
            cash_desk_mov.value,
            cash_desk_mov.mov_type,
            cash_desk_mov.observations
        )
        )

    def delete(self, identifier):
        
        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['CashDesksMovs']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):
        
        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['CashDesksMovs']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['CashDesksMovs']['getAll'], CMD_TYPE_TEXT, (identifier,))
            

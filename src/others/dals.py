"""
This module contains Data Access Layer classes for data persistence
"""

from . import dbconnections

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


CMD_TYPE_TEXT = 1
CMD_TYPE_FUNCTION = 2


class PgSqlDal(object):
    """
    Data access layer class for postgresql data base
    """

    @classmethod
    def execute_no_query(cls, command, command_type, parameters=None, must_commit=True, is_test=False):
        """
        Execute queries without returns, command_type parameter must be 
        a CMD_TYPE_FUNCTION or CMD_TYPE_TEXT constants
        """

        with dbconnections.pg_connection(must_commit, is_test) as cursor:
            if command_type == CMD_TYPE_TEXT and parameters is not None:
                cursor.execute(command, parameters)
            elif command_type == CMD_TYPE_TEXT and parameters is None:
                cursor.execute(command)
            elif command_type == CMD_TYPE_FUNCTION and parameters is not None:
                cursor.callproc(command, parameters)
            else:
                cursor.callproc(command)

    @classmethod
    def execute_query(cls, command, command_type, parameters=None, must_commit=True, is_test=False):
        """
        Execute queries with returns, command_type parameter must be 
        a CMD_TYPE_FUNCTION or CMD_TYPE_TEXT constants
        """

        with dbconnections.pg_connection(must_commit, is_test) as cursor:
            if command_type == CMD_TYPE_TEXT and parameters is not None:
                cursor.execute(command, parameters)
            elif command_type == CMD_TYPE_TEXT and parameters is None:
                cursor.execute(command)
            elif command_type == CMD_TYPE_FUNCTION and parameters is not None:
                cursor.callproc(command, parameters)
            else:
                cursor.callproc(command)

            return cursor.fetchall()

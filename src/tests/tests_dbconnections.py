"""
This module contains database connection test classes
"""

import unittest
from others import dbconnections

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class TestPgSqlConnection(unittest.TestCase):

    def test_connection(self):
        """<TestPgSqlConnection> A conexão deve ser estabelecida e o atributo 'closed' do cursor deve ser falso"""

        with dbconnections.pg_connection(must_commit=False, is_test=True) as cursor:
            self.assertFalse(cursor.closed)

    def test_select(self):
        """<TestPgSqlConnection> A consulta deve retornar algum resultado se o SGDB estiver alcançável e disponível"""

        with dbconnections.pg_connection(must_commit=False, is_test=True) as cursor:
            cursor.execute('SELECT tablename FROM pg_tables ORDER BY tablename;')
            self.assertTrue(cursor.fetchall())

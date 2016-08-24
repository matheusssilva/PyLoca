"""
This module contains Data Access Layer test classes
"""

import unittest
from others.dals import PgSqlDal, CMD_TYPE_TEXT, CMD_TYPE_FUNCTION
from others import inout

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class TestPgSqlDal(unittest.TestCase):
    """ <TestPgSqlDal> Teste unitário da classe PgSqlDal do módulo others.dals"""

    def setUp(self):
        self.sql = inout.get_queries_file()

    def test_exec_n_query_text(self):
        """<TestPgSqlDal> O insert na tabela de testes deve ocorrer sem erros e não retornar nada se o SGDB estiver alcançável"""

        ret = PgSqlDal.execute_no_query(
            self.sql['TblTests']['insert'], CMD_TYPE_TEXT, ('Matheus Saraiva',), must_commit=False, is_test=True)

        self.assertIsNone(ret, 'Houve um retorno')

    def test_exec_n_query_text_n_par(self):
        """<TestPgSqlDal> A conslta sem parametros deve ocorrer sem erros e não retornar nada se o SGDB estiver alcançável"""

        ret = PgSqlDal.execute_no_query(
            self.sql['TblTests']['selectWithoutParameter'], CMD_TYPE_TEXT, must_commit=False, is_test=True)

        self.assertIsNone(ret, 'Houve um retorno')

    def test_exec_n_query_func(self):
        """<TestPgSqlDal> A chamada à função "insert_in_tbltests" deve ocorrer sem erros e não retornar nada se o SGDB estiver alcançável"""

        ret = PgSqlDal.execute_no_query(
            self.sql['TblTests']['callFunction'], CMD_TYPE_FUNCTION, ('Matheus Saraiva',), must_commit=False, is_test=True)

        self.assertIsNone(ret, 'Houve um retorno')

    def test_exec_n_query_func_n_par(self):
        """<TestPgSqlDal> A chamada à função sem parâmetros "select_in_tbltests" deve ocorrer sem erros e não retornar nada se o SGDB estiver alcançável"""

        ret = PgSqlDal.execute_no_query(
            self.sql['TblTests']['callFunctionWithoutParameters'], CMD_TYPE_FUNCTION,  must_commit=False, is_test=True)

        self.assertIsNone(ret, 'Houve um retorno')

    def test_exec_query_text(self):
        """<TestPgSqlDal> A consulta deve ocorrer sem erros e ter algum retorno"""

        ret = PgSqlDal.execute_query(
            self.sql['TblTests']['selectWithParameter'], CMD_TYPE_TEXT, (1,), must_commit=False, is_test=True)

        self.assertIsNotNone(ret, 'Não houve um retorno')

    def test_exec_query_text_n_par(self):
        """<TestPgSqlDal> A consulta sem parâmetros deve ocorrer sem erros e ter algum retorno"""

        ret = PgSqlDal.execute_query(
            self.sql['TblTests']['selectWithoutParameter'], CMD_TYPE_TEXT, must_commit=False, is_test=True)

        self.assertIsNotNone(ret, 'Não houve um retorno')

    def test_exec_query_func(self):
        """<TestPgSqlDal> A chamada à função "insert_in_tbltests" deve ocorrer sem erros e ter algum retorno se o SGDB estiver alcançável"""

        ret = PgSqlDal.execute_query(
            self.sql['TblTests']['callFunction'], CMD_TYPE_FUNCTION, ('Matheus Saraiva',), must_commit=False, is_test=True)

        self.assertIsNotNone(ret, 'Não houve um retorno')

    def test_exec_query_func_n_par(self):
        """<TestPgSqlDal> A chamada à função "select_in_tbltests" deve ocorrer sem erros e ter algum retorno se o SGDB estiver alcançável"""

        ret = PgSqlDal.execute_query(
            self.sql['TblTests']['callFunctionWithoutParameters'], CMD_TYPE_FUNCTION, must_commit=False, is_test=True)

        self.assertIsNotNone(ret, 'Não houve um retorno')

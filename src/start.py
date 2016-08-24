#!/usr/bin/env python3

"""
# This modeule contais the start point application
# It can receive the (--test) parameter to run unittests
"""

import unittest
# Biblioteca responsável por manipular argumentos passados via linha de comando
import argparse
from views import application

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


# Cria um objeto ArgumentParser
arg = argparse.ArgumentParser(description='Execution type')

# Adiciona um novo argumento aceito e suas configurações
arg.add_argument('--test', action='store_true',
                 help='Execute unittests')

# Pega or argumentos passados pelo usuário
options = arg.parse_args()


def main():
    application.run()


def run_tests():

    from tests import tests_models, tests_dbconnections, tests_dals

    suit = unittest.TestSuite()
    suit.addTest(unittest.makeSuite(tests_models.TestPerson))
    suit.addTest(unittest.makeSuite(tests_models.TestClient))
    suit.addTest(unittest.makeSuite(tests_dbconnections.TestPgSqlConnection))
    suit.addTest(unittest.makeSuite(tests_dals.TestPgSqlDal))

    return suit

if __name__ == '__main__':
    if options.test:    # Se o atributo 'test' do obojeto Namespace retornado por parse_args() for True
        # O parâmetro [argv] de unittest.main() recebe uma lista com o nome do programa, isso impede
        # que o argumento de linha de comando seja repassado para a funcçõ main() através do
        # sys.argv
        print(__file__)
        unittest.main(defaultTest='run_tests', verbosity=2, argv=['PyLoca'])
    else:
        main()

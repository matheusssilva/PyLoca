"""
This module contains model test classes
"""

import unittest
from models.individuals import Client, Person
from others.exceptions import SuspectEmail, InvalidCpf

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


#   TestCase.assertRaises(exceção_desejada, metodo_ou_função, **parâmetros), testa se uma exceção está sendo lançado nomomento desejado
# TestCase.assertIsInstance(obj, classe, msg), verifica se o objeto criado
# é do tipo desejado


class TestPerson(unittest.TestCase):

    def test_valid_person(self):
        """<TestPerson> Um objeto Person deve ser instanciado sem problemas"""

        person = Person('Matheus', '88878788', 'matheus.saraiva@gmail.com',
                        'Chapecó', None, 'matheusssilva', 'AnyPassword')

        self.assertIsInstance(
            person, Person, 'O objeto criado não é do tipo Person')

    def test_invalid_email(self):
        """<TestPerson> Deve ser levantado um Warning informando que o email de Person é suspeito de ser inválido"""

        self.assertWarns(SuspectEmail, Person, 'Matheus', '88878788',
                         'matheus.saraivagmail.com', 'Chapecó', None, 'matheusssilva', 'AnyPassword')


class TestClient(unittest.TestCase):

    def test_valid_client(self):
        """<TestClient> Um objeto Cliente deve se instanciado sem problemas"""

        person = Person('Matheus', '88878788', 'matheus.saraiva@gmail.com',
                        'Chapecó', None, 'matheusssilva', 'AnyPassword')

        cli = Client(person, '45554', '74715151200')

        # Valido se Cliente foi instanciado corretamente
        self.assertIsInstance(
            cli, Client, 'O objeto criado não é uma instancia de Client')

    def test_invalid_cpf(self):
        """<TestClient> Uma exeção InvalidCpf deve ser levantada informado que o cpf do Client é informado """

        person = Person('Matheus', '88878788', 'matheus.saraiva@gmail.com',
                        'Chapecó', None, 'matheusssilva', 'AnyPassword')

        self.assertRaises(InvalidCpf, Client, person, '45554', '74715151299')

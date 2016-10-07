"""
This model contains individual model classes
"""

import re
import warnings
import datetime
from others.exceptions import InvalidCpf, SuspectEmail, InvalidDatetime

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class ZipCode(object):

    def __init__(self, zip_number, state, city, neighborhood, street):
        self.zip_number = zip_number
        self.state = state
        self.city = city
        self.neighborhood = neighborhood
        self.street = street


class Address(object):

    def __init__(self, zip_code, number, complement):
        self.zip_code = zip_code
        self.number = number
        self.complement = complement


class Person(object):

    def __init__(self, name, telephone1, telephone2, email, address, photo, login, password, is_authorized=True):
        self.name = name
        self.telephone1 = telephone1
        self.telephone2 = telephone2
        self.email = email
        self.address = address
        self.photo = photo
        self.login = login
        self.password = password
        self.is_authorized = is_authorized

    @property
    def email(self):
        return self.__email

    @email.setter
    def email(self, email):
        # A função match(rawString, String) do pacote re, verifica se a string do segundo parâmetro atende as condições definidas pela expressão regular passada como primeiro parâmetro.
        # O método warnings.warn(String, WarningClass, int) emite um aviso com o texto contido no primeiro parâmetro.
        # O segundo parâmetro define o tipo do aviso, que nesse caso é um aviso
        # personalizado. O terceiro parâmetro determina o nivel do aviso, 1 =
        # se deve indicar o local onde warnings.warn() foi definido ou 2 = se
        # deve indicar o local onde a função ou método contendo warnings.warn()
        # foi chamado(a).

        if not re.match(r'^[\w.%-]+@[\w.%-]+\.[a-zA-Z]{2,6}$', email):
            warnings.warn('The email entered does not appear to be valid: %s' %
                          email, SuspectEmail, 2)

        self.__email = email

# class Juridica(Pessoa):
#    @cnpj.setter
#    def cnpj(self, value):
# zip(inter1, inter2) cria uma lista de tuplas, ex.: [(1,2), (3,5), (4,8)], cobinando os elementos de mesma posição, com base
# nos dois iteráveis passados por parâmetro.
# cycle(iterable) cria com base no iterável passado por parâmetro, um iterável infinito, ou seja, que não termina caso seja
# percorrido por um 'for'. Quando o 'for' chega no ultimo elemento ele volta ao primeiro, criando assim um loop infinito.
# cycle(iterable) retorna um iterável infinito, cuja a iteração sobre ele nunca termina, pois os elementos se repetem.
# range(home, end) devolve um iterável que começa em 'home' e termina antes de 'end'.
#        """
#            Valida o CNPJ informado
#
#            ex. fornecedor.cnpj = '79245296000160'
#        """
#
#        if not value.isdigit() and len(value) != 14:
#            raise ValueError('CNPJ Inválido! Deve ser composto por uma string de 14 digitos, sem caracteres especiais')
#
#        cnpj_valido = list(map(int, value[:12]))
#
#        while len(cnpj_valido) < 14:
#            rest = sum(i * x for i, x in zip(cycle(range(2,10)), cnpj_valido[::-1])) % 11
#            cnpj_valido.append(11 - rest if rest >= 2 else 0)
#
#        if ''.join(map(str, cnpj_valido)) == value:
#            self.__cnpj = value
#        else:
#            raise InvalidCnpj(value)


class Client(object):


    def __init__(self, person, rg, cpf, birth):
        self.person = person
        self.rg = rg
        self.cpf = cpf  # Acessando via property
        self.birth = birth # Acessando via property

    @property
    def cpf(self):
        return self.__cpf  # Retornando o atributo privado

    @cpf.setter
    def cpf(self, value):
        # map(função, interador), aplica a função dada em cada um dos elementos do interador
        # enumerate(interador), cria um objeto enumerado com os elementos de um interador, o qual pode ser percorrido
        # ' '.join(), str.join() adiciona um novo caractere a uma string existente

        if not value.isdigit() or len(value) != 11:
            raise ValueError(
                'Invalid CPF! It should consist of a 11-digit string, no special characters')

        valid_cpf = list(map(int, value[:9]))

        while len(valid_cpf) < 11:
            base = len(valid_cpf) + 1
            rest = sum(x * (base - i) for i, x in enumerate(valid_cpf)) % 11
            valid_cpf.append(11 - rest if rest >= 2 else 0)

        if ''.join(map(str, valid_cpf)) == value:
            self.__cpf = value
        else:
            raise InvalidCpf(value)

    @property
    def birth(self):
        return self.__birth

    @birth.setter
    def birth(self, usr_date):
        if datetime.date.today() <= usr_date:
            raise InvalidDatetime(usr_date)
        else:
            self.__birth = usr_date


class Dependent(object):

    def __init__(self, person, guarantor):
        self.person = person
        self.guarantor = guarantor


class Functionary(object):

    def __init__(self, person, is_root=True):
        self.person = person
        self.is_root = is_root

"""
This module contains custom metaclasses
"""

from abc import ABCMeta

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


# Meta classes para uso em com descritores
#
#A meta classe DescMetaClass é usada para criar classes. Seu construtor é chamado para realizar essa criação.
#   Nesse caso, DescMetaClass deve ser definida como meta classe das classes que farão uso dos descritores aqui definidos.
#A classeDescAbcMetaClass tem a mesma finalidade que DescMetaClass. Porém, DescAbcMetaClass é usado como metaclass
#   de classes abstratas, já que herda de ABCMeta.
# O parâmetro 'nome' = É o nome da classe.
#O parâmetro 'bases' = É uma tupla eontendo as classes bases imediatas da classe que será criada.
#O parâmetro 'dic' = É um dicionário contendo a estrutura da classe, ou seja, seus atributos e métodos.
#A função built-in hasattr returna verdadeira se o objeto passado contém um atributo ou método com o nome informado.

class DescAbcMetaClass(ABCMeta):

    """
    Meta classe for descriptiors in abstract classes
    """

    def __init__(cls, name, bases, dic):
        super().__init__(name, bases, dic)

        for key, atrib in dic.items():
            if hasattr(atrib, 'atrib_name'):
                atrib.atrib_name = '__'+ name + key


class DescMetaClass(type):
    """
    Meta classe for descriptiors
    """

    def __init__(cls, name, bases, dic):
        super().__init__(name, bases, dic)

        for key, atrib in dic.items():
            if hasattr(atrib, 'atrib_name'):
                atrib.atrib_name = '__'+ name + key


class Singleton(type):
    """
    Meta classe for singleton classes
    """
    _instance = None

    def __call__(cls, *args, **kwargs):
        #Sobescreve o metodo __call__ de type, armazenando o retorno de type.__call__ no atributo _instance

        if cls._instance is None:
            cls._instance = super().__call__(*args, **kwargs)

        return cls._instance

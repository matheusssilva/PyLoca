"""
This module contains the following custom descriptor classes

OnlyPositiveValue
OnlyPositiveValueOrNoneValue
OnlyGreaterThanZero
NotEmptyContainer
"""

from .exceptions import EmptyContainer, InvalidDatetime
from datetime import datetime

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


# Descritores
#
#__init__ cria o atributo 'atrib_name'. Esse atributo irá armazenar o nome do atributo que irá armazenar o valor.
#getattr() procura um atributo, cujo o nome é passado como string no segundo parâmetro, em um objeto passado
# no primeiro parâmetro
#setattr() seta um valor a um atributo de um objeto. Se o atributo não existir, ele será criado

class OnlyPositiveValue(object):

    """
    Descriptor that blocks negative and null values. 
    Raise a ValueError exception if insert negative or null values
    
    Input eg: -1, -2, -3, None, ....
    """

    def __init__(self):
        self.atrib_name = None

    def __get__(self, instance, owner):
        return getattr(instance, self.atrib_name)

    def __set__(self, instance, value):
        if value is not None and value >= 0:
            setattr(instance, self.atrib_name, value)
        else:
            raise ValueError('It Cannot be a negative value')


class OnlyPositiveOrNoneValue(object):
    """
    Descriptor that blocks negative values but acept null values
    Raise a ValueError exception if insert negative values
    
    Input eg: -1, -2, -3, ....
    """

    def __init__(self):
        self.atrib_name = None

    def __get__(self, instance, owner):
        return getattr(instance, self.atrib_name)

    def __set__(self, instance, value):
        if value is None or value >= 0:
            setattr(instance, self.atrib_name, value)
        else:
            raise ValueError('It Cannot be a negative value')


class OnlyGreaterThanZero(object):
    """
    Descriptor that blocks less than or equal to zero and null values.
    Raise a ValueError exception if insert values less than or equal to zero or null
    
    Input eg: 0, -1, -2, -3, None, ....
    """

    def __init__(self):
        self.atrib_name = None

    def __get__(self, instance, owner):
        return getattr(instance, self.atrib_name)

    def __set__(self, instance, value):
        if value is not None and value > 0:
            setattr(instance, self.atrib_name, value)
        else:
            raise ValueError('The value must be greater than zero')


class NotEmptyContainer(object):
    """
    Descriptor that blocks empty containers.
    Raise a EmptyContainer if insert empty list.
    """

    def __init__(self):
        self.atrib_name = None

    def __get__(self, instance, owner):
        return getattr(instance, self.atrib_name)

    def __set__(self, instance, container):
        if not len(container):
            raise EmptyContainer(container)
        else:
            setattr(instance, self.atrib_name, container)



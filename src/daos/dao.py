"""
This module contains Abstract Base Class for Data Access Objects class
"""

from abc import ABCMeta, abstractmethod

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class EntityDao(object, metaclass=ABCMeta):

    @abstractmethod
    def insert(self, entitie):
        pass

    @abstractmethod
    def update(self, entitie):
        pass

    @abstractmethod
    def delete(self, identifier):
        pass

    @abstractmethod
    def get(self, identifier=None):
        pass

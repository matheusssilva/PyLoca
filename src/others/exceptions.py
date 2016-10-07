"""
This module contais the following custom exceptions and Warnings

InvalidCpf
SuspectEmail (Warning)
EmptyCaontainer
InvalidDate
IntersectionFalse
"""

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class InvalidCpf(Exception):
    def __init__(self, cpf):
        self.cpf = cpf
        super().__init__()

    def __str__(self):
        return 'The informed CPF is invalid: %s'%self.cpf


class SuspectEmail(UserWarning):
    """
    Suspect email warning
    
    Base:   UserWarning
    """

class EmptyContainer(Exception):
    def __init__(self, container):
        self.container = container
        super().__init__()

    def __str__(self):
        return 'The container passed is empty: len( ) = %i'%len(self.container)


class InvalidDatetime(Exception):
    def __init__(self, usr_datetime):
        self.usr_datetime = usr_datetime
        super().__init__()

    def __str__(self):
        return 'The informed date is invalid %s'%str(self.usr_datetime)


class IntersectionFalse(Exception):
    """
    Intersection conteiners exception
    
    Invalid input eg. [1, 6, 8, 9] [10, 3, 5, 7]
    Valid input eg. [1, 6, 8, 9] [10, 3, 9, 8]
    """
    def __str__(self):
        return 'Error at the intersection of containers. One or more items do not correspond'

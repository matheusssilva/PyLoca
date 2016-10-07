"""
This moule contains movement model classes 
"""

from enum import Enum
from abc import abstractmethod
from others.exceptions import InvalidDate
from others.metaclasses import DescMetaClass, DescAbcMetaClass
from others.descriptors import NotEmptyContainer, OnlyPositiveValue, OnlyPositiveOrNoneValue

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class Transaction(object, metaclass=DescAbcMetaClass):
    """
    Transaction is a abstract base class for all transaction types
    """

    products = NotEmptyContainer()  # Descriptor, class attribute
    value = OnlyPositiveValue()  # Descriptor, class attribute

    @abstractmethod
    def __init__(self, products, client, functionary, date_time, value,
                 observations):
        self.products = products
        self.client = client
        self.functionary = functionary
        self.date_time = date_time
        self.value = value
        self.observations = observations


class Booking(Transaction):
    """
    Bookings class

    It should receive a namedtuple as the first parameter.
    This first parameter should to contain the parameters of the base class (Transaction).
    """

    Status = Enum('Status', 'Active, Finalized, Cancelled')  # Enumeration

    def __init__(self, transaction, date_time_chosen_remove, date_time_removed, status=Status.Active):
        super().__init__(transaction.products, transaction.client, transaction.functionary,
                         transaction.date_time, transaction.value, transaction.observations)

        self.date_time_chosen_remove = date_time_chosen_remove
        self.date_time_removed = date_time_removed
        self.status = status

    @property
    def date_time_chosen_remove(self):
        return self.__date_time_chosen_remove  # Retornando atributo privado

    @date_time_chosen_remove.setter
    def date_time_chosen_remove(self, usr_date_ime):
        if usr_date_ime <= self.date_time:
            raise InvalidDate(usr_date_ime)
        else:
            self.__date_time_chosen_remove = usr_date_ime

    @property
    def status(self):
        return self.__status.value

    @status.setter
    def status(self, value):
        self.__status = value


class Rent(Transaction):
    """
    Rents class

    It should receive a namedtuple as the first parameter.
    This first parameter should to contain the parameters of the base class (Transaction).
    """

    Status = Enum('Status', 'Active, Finalized, Cancelled')
    value_paid = OnlyPositiveValue()  # Descriptor, class attribute

    def __init__(self, transaction, value_paid, status=Status.Active):
        super().__init__(transaction.products, transaction.client, transaction.functionary,
                         transaction.date_time, transaction.value, transaction.observations)

        self.value_paid = value_paid  # Acessando via descriptors
        self.status = status

    @property
    def status(self):
        return self.__status.value

    @status.setter
    def status(self, value):
        self.__status = value


class Devolution(Transaction):
    """
    Devolution class

    It should receive a namedtuple as the first parameter.
    This first parameter should to contain the parameters of the base class (Transaction).
    """

    def __init__(self, transaction, rent, returned_by):
        super().__init__(transaction.products, transaction.client, transaction.functionary,
                         transaction.date_time, transaction.value, transaction.observations)

        self.rent = rent
        self.returned_by = returned_by


class CashDesk(object, metaclass=DescMetaClass):

    # Custom enumeration
    Status = Enum('Status', {'Opened': True, 'Closed': False})

    expected_value = OnlyPositiveValue()  # Descriptor, class attribute
    cash_fund = OnlyPositiveValue()  # Descriptor, class attribute
    value_in_cash = OnlyPositiveOrNoneValue()  # Descriptor, class

    def __init__(self, date_time_opened, functionary, cash_fund, expected_value, value_in_cash, date_time_closed, observations, status=Status.Opened):
        self.date_time_opened = date_time_opened
        self.functionary = functionary
        self.cash_fund = cash_fund  # Acessando via descriptor
        self.expected_value = expected_value  # Acessando via descriptor
        self.value_in_cash = value_in_cash  # Acessando via descriptor
        self.date_time_closed = date_time_closed  # Acessando via property
        self.observations = observations
        self.status = status

    @property
    def date_time_closed(self):
        return self.__date_time_closed

    @date_time_closed.setter
    def date_time_closed(self, usr_date_time):
        if usr_date_time is not None and usr_date_time < self.date_time_opened:
            raise InvalidDate(usr_date_time)
        else:
            self.__date_time_closed = usr_date_time

    @property
    def status(self):
        return self.__status

    @status.setter
    def status(self, value):
        self.__status = value


class CashDeskMovs(object, metaclass=DescMetaClass):

    value = OnlyPositiveValue()  # Descriptor, class attribute

    def __init__(self, cash_desk, functionary,  value, type_move, date_time, observations):
        self.cash_desk = cash_desk
        self.functionary = functionary
        self.value = value  # Acessando via descriptor
        self.type_move = type_move
        self.date_time = date_time
        self.observations = observations

"""
This mopdule contains commodity model classes
"""

from enum import Enum
from abc import abstractmethod
from others.descriptors import OnlyPositiveValue
from others.metaclasses import DescAbcMetaClass, DescMetaClass

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class Product(object, metaclass=DescAbcMetaClass):
    """
    Class of others products and base class of all product types
    """

    price = OnlyPositiveValue()  # Descriptor, class attribute
    cost = OnlyPositiveValue()  # Descriptor, class attribute

    @abstractmethod
    def __init__(self, bar_code, name, price, cost, stock):
        self.bar_code = bar_code
        self.name = name
        self.price = price
        self.cost = cost
        self.stock = stock


class InfoMedia(object, metaclass=DescMetaClass):
    """
    InfoMedia is complement class of Media class
    """

    minimum_age = OnlyPositiveValue()  # Descriptor, class attribute

    def __init__(self, genre, minimum_age, producer, distributor, subtitles,
                 audios, synopsis, fisic_type):
        self.genre = genre
        self.minimum_age = minimum_age
        self.producer = producer
        self.distributor = distributor
        self.subtitles = subtitles
        self.audios = audios
        self.synopsis = synopsis
        self.fisic_type = fisic_type


class Media(Product):
    """
    Abstract media class

    It should receive a namedtuple as the first parameter.
    This first parameter should to contain the parameters of the base class (Product).
    """

    Status = Enum('Status', 'Available, Rented, Reserved')
    score = OnlyPositiveValue()  # Descriptor, class attribute

    @abstractmethod  # Inherited his father's metaclass
    def __init__(self, product, score, local_trailer, web_trailer, cover, info_media, status=Status.Available):
        super().__init__(product.name, product.price,
                         product.cost, product.bar_code, product.stock)
        self.score = score
        self.local_trailer = local_trailer
        self.web_trailer = web_trailer
        self.cover = cover
        self.info_media = info_media
        self.status = status

    @property
    def status(self):
        return self.__status.value

    @status.setter
    def status(self, valor):
        self.__status = valor


class Movie(Media):
    """
    Movies class

    It should receive a namedtuple as the first parameter.
    This first parameter should to contain the parameters of the base class (Media).
    """

    duration = OnlyPositiveValue()  # Descriptor, class attribute

    def __init__(self, media, cast, duraction, screen_format):
        super().__init__(media.product, media.score, media.local_trailer,
                         media.web_trailer, media.cover, media.info_media)
        self.cast = cast
        self.duraction = duraction
        self.screen_format = screen_format


class Game(Media):
    """
    Games class

    It should receive a namedtuple as the first parameter.
    This first parameter should to contain the parameters of the base class (Media).
    """

    players = OnlyPositiveValue()  # Descritor, class attribute

    def __init__(self, media, players, is_online, console):
        super().__init__(media.product, media.score, media.local_trailer,
                         media.web_trailer, media.cover, media.info_media)
        self.players = players
        self.is_online = is_online
        self.console = console

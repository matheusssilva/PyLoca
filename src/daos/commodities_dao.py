"""
This module contains commodities Data Acces Object classes for data persistence
"""

from others.dals import PgSqlDal, CMD_TYPE_TEXT, CMD_TYPE_FUNCTION
from others import inout
from .dao import EntityDao

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


class UnitDao(EntityDao):

    def insert(self, unit):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(
            sql['Units']['insert'], CMD_TYPE_TEXT, (unit.abreviation, unit.description))

    def update(self, unit):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Units']['update'], CMD_TYPE_TEXT, (
            unit.abreviation,
            unit.new_abreviation if 'new_abreviation' in vars(
                unit) else unit.abreviation,
            unit.description
        )
        )

    def delete(self, identifier):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(
            sql['Units']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):

        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Units']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Units']['getAll'], CMD_TYPE_TEXT)


class MovieDao(EntityDao):

    def insert(self, movie):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Movies']['insert'], CMD_TYPE_FUNCTION, (
            movie.bar_code,
            movie.name,
            movie.price,
            movie.cost,
            movie.unit,
            movie.stock,
            movie.score,
            movie.local_trailer,
            movie.web_trailer,
            movie.cover,
            movie.info_media.genre,
            movie.info_media.minimum_age,
            movie.info_media.producer,
            movie.info_media.distributor,
            movie.info_media.subtitles,
            movie.info_media.audios,
            movie.info_media.synopsis,
            movie.info_media.fisic_type,
            movie.cast,
            movie.duraction,
            movie.screen_format,
            movie.status
        )
        )
       
    def update(self, movie):
        
        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Movies']['update'], CMD_TYPE_FUNCTION, (
            movie.identifier,
            movie.bar_code,
            movie.name,
            movie.price,
            movie.cost,
            movie.unit,
            movie.stock,
            movie.score,
            movie.local_trailer,
            movie.web_trailer,
            movie.cover,
            movie.info_media.genre,
            movie.info_media.minimum_age,
            movie.info_media.producer,
            movie.info_media.distributor,
            movie.info_media.subtitles,
            movie.info_media.audios,
            movie.info_media.synopsis,
            movie.info_media.fisic_type,
            movie.cast,
            movie.duraction,
            movie.screen_format,
            movie.status
        )
        )
        
    def delete(self, identifier):
        
        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Movies']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):
        
        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Movies']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Movies']['getAll'], CMD_TYPE_TEXT)


class GameDao(EntityDao):
    
    def insert(self, game):

        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Games']['insert'], CMD_TYPE_FUNCTION, (
            game.bar_code,
            game.name,
            game.price,
            game.cost,
            game.unit,
            game.stock,
            game.score,
            game.local_trailer,
            game.web_trailer,
            game.cover,
            game.info_media.genre,
            game.info_media.minimum_age,
            game.info_media.producer,
            game.info_media.distributor,
            game.info_media.subtitles,
            game.info_media.audios,
            game.info_media.synopsis,
            game.info_media.fisic_type,
            game.players,
            game.is_online,
            game.console,
            game.status
        )
        )
       
    def update(self, game):
        
        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Games']['update'], CMD_TYPE_FUNCTION, (
            game.identifier,
            game.bar_code,
            game.name,
            game.price,
            game.cost,
            game.unit,
            game.stock,
            game.score,
            game.local_trailer,
            game.web_trailer,
            game.cover,
            game.info_media.genre,
            game.info_media.minimum_age,
            game.info_media.producer,
            game.info_media.distributor,
            game.info_media.subtitles,
            game.info_media.audios,
            game.info_media.synopsis,
            game.info_media.fisic_type,
            game.players,
            game.is_online,
            game.console,
            game.status
        )
        )
        
    def delete(self, identifier):
        
        sql = inout.get_queries_file()

        PgSqlDal.execute_no_query(sql['Games']['delete'], CMD_TYPE_TEXT, (identifier,))

    def get(self, identifier=None):
        
        sql = inout.get_queries_file()

        if identifier:
            return PgSqlDal.execute_query(sql['Games']['getOneOrMore'], CMD_TYPE_TEXT, (identifier,))
        else:
            return PgSqlDal.execute_query(sql['Games']['getAll'], CMD_TYPE_TEXT)
    
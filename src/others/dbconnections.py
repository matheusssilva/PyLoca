"""
This module catains functions that returns database connections
"""

from contextlib import contextmanager
import psycopg2.pool
from others.inout import get_configs_file

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"

# psycopg2 é a api para conexão com bancos de dados PostgreSQL. psycopg2.pool contem classes para construção de pool de co-
#   nexões. A classe SimpleConnectionPool constroi um pool para conexões only-one thread.
# SimpleConnectionPool.getconn() retorna um objeto do tipo Connection, com a conexão já ativa. Connection.cursor() devolve um
#   objeto Cursor que é usado para executar os comandos SQL.


@contextmanager
def pg_connection(must_commit=True, is_test=False):
    """
    PostgreSQL Connection

    Return a psycopg2.cursor object
    The connection is closed after use

    Example:
        cursor = pg_connection()
        cursor.execute('select * from any_table')
    """

    conf = get_configs_file()

    database = conf['dbconnection']['database'] if not is_test else 'tests'

    connection_pool = psycopg2.pool.SimpleConnectionPool(
        1,
        5,
        host=conf['dbconnection']['host'],
        port=int(conf['dbconnection']['port']),
        database=database,
        user=conf['dbconnection']['user'],
        password=conf['dbconnection']['dbpassword'],
        connect_timeout=conf['dbconnection']['connect_timeout'])

    con = None  # Connection
    cur = None  # Cursor

    try:
        con = connection_pool.getconn()
        cur = con.cursor()
        yield cur

        if must_commit:
            con.commit()
    except psycopg2.Error:
        if con is not None:
            con.rollback()
        raise
    finally:
        if cur is not None and not cur.closed:
            cur.close()
        if con is not None and not con.closed:
            connection_pool.putconn(con, close=True)

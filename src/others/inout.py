"""
This module contains functions for I/O operations
"""

import json
import configparser

__author__ = "Matheus Saraiva"
__email__ = "matheus.saraiva@gmail.com"
__phone__ = "55 49 88070350"
__copyright__ = "2016, The PyLoca Project "
__version__ = "0.0.1"
__license__ = "GPL3"


#   configparser é um pacote que contém classes para manipulação de arquivos de configuração similares aos arquivos .INI do
# windows. ConfigParser.read(file) abre o arquivo de configuração informado e retorna uma lista com chaves e valores.
#   Para acessar o conteúdo usa-se uma sintaxe similar as listas: variable[dominio][chave].
#   ConfigParser é a classes que gera o objeto para manipular os arquivos. Defina o parâmetro 'interpolation' como None, para de-
# sabilitar a interpolação (https://docs.python.org/3.4/library/configparser.html#interpolation-of-values)
#   O modulo json contem classes para manipular arquivos JSON. A função  json.load() lê um arquivo no formato JSON e devolve
# um objeto iterável com os dados contidos no arquivo JSON.


def get_configs_file(file_name):
    """Returns a list of the configuration file content"""

    confp = configparser.ConfigParser()
    confp.read(file_name)
    return confp

def set_configs_file(file_name, configs):
    
    confp = get_configs_file(file_name)

    for section in configs:
        if section not in confp:
            confp[section]={}
        for key in configs[section]:
            confp[section][key]=configs[section][key]
            
    with open(file_name, 'w') as conf_file:
        confp.write(conf_file)

def get_queries_file():
    """Returns a list of the queries file content"""

    with open('queries.json') as sql:
        return json.load(sql)

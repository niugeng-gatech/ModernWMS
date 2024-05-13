# find the varibales name within the files with name ending in "entity.cs" and varibales type are defined as "decimal"
from cast.application import ApplicationLevelExtension, ReferenceFinder
from cast.analysers import log
import os

class SQLType(ApplicationLevelExtension):
    
        def __init__(self):
            self.sqltypes = {}
            self.sqltype = []
            self.sqltype = ['int','integer','tinyint','smallint','mediumint','bigint','float','double','decimal','numeric','real','bit','date','time','year','datetime','timestamp','char','varchar','nchar','nvarchar','text','tinytext','mediumtext','longtext','binary','varbinary','blob','tinyblob','mediumblob','longblob','enum','set']
    
        def start_application(self, application):
            log.info('Starting application')
    
        def end_application(self, application):
            log.info('Ending application')
            for obj in application.objects():
                if obj.get_name().endswith('.sql'):
                    for ref in obj.get_children():
                        if ref.get_name().endswith('.sql'):
                            self.extract_sqltype(ref)
                if obj.get_name().endswith('.cs'):
                    for ref in obj.get_children():
                        if ref.get_name().endswith('.cs'):
                            self.extract_cs(ref)
            self.compare()
    
        def extract_sqltype(self, obj):
            for line in obj.get_file().read().split('\n'):
                for sqltype in self.sqltype:
                    if sqltype in line:
                        if obj.get_name() not in self.sqltypes:
                            self.sqltypes[obj.get_name()] = []
                        self.sqltypes[obj.get_name()].append(line)
    
        def extract_cs(self, obj):
            for line in obj.get_file().read().split('\n'):
                if 'public' in line:
                    if 'decimal' in line:
                        if obj.get_name() not in self.sqltypes:
                            self.sqltypes[obj.get_name()] = []
                        self.sqltypes[obj.get_name()].append(line)
    
        def compare(self):
            for key in self.sqltypes:
                log.info('File: ' + key)
                for line in self.sqltypes[key]:
                    log.info('Line: ' + line)

def get_extensions():
    return [SQLType()]

get_extensions()
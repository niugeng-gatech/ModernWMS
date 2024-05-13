#!/usr/bin/python
import sqlite3
conn = sqlite3.connect("D:/Geng/ModernWMS/backend/ModernWMS/wms.db")
c = conn.cursor()

print("Starting extract job..")
with open('CreateTables.sql', 'w') as f:
    for tabledetails in c.execute("SELECT * FROM sqlite_master WHERE type='table'"):
        print("Extracting CREATE statement for " + (str(tabledetails[1])))
        print(tabledetails)
        f.write(str(tabledetails[4].replace('\n','') + ';\n'))
c.close()
# -*- coding: utf-8 -*-
"""
Created on Sat Jul 28 09:28:43 2018

"""
import sys
sys.path.append('E:\GitHub\ProfessorPitch\SQLite3')
import sqlite3

conn = sqlite3.connect('Customer.db')
c = conn.cursor()
#CReate Table in SQLIte DB

rows = [('2018-06-02','johnny123',54857,'payments','2018-06-04','2018-06-03'),
          ('2018-05-03','',10257,'payments','2018-05-04','2018-05-03'),
          ('2018-05-07','alexis543',32145,'troubleshooting','2018-05-09','2018-05-08'),
          ('2018-05-17','lolli0989',67402,'features','2018-05-19','2018-05-17'),
          ('2018-06-11','pikl8172',800014,'information','2018-06-15','2018-06-14'),
          ('2018-05-25','wes6152',552536,'payments','2018-05-31','2018-05-28'),
          ('2018-06-12','kevi0918',774025,'troubleshooting','2018-06-15','2018-06-14'),
          ('2018-06-20','leep620',20356,'sales','2018-06-22','2018-06-21')
          ]
c.executemany('insert into careInteractions values (?,?,?,?,?,?)', rows) 
conn.commit()

##End create statement
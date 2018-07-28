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

tb_create = """CREATE TABLE careInteractions
       			(ticketDate,userName,repID, reasonCode,
                   updateDate,ticketCloseDate)"""
c.execute(tb_create) 
conn.commit()

##End create statement
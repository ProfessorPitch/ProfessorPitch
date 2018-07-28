# -*- coding: utf-8 -*-
"""
Created on Sat Jul 28 09:28:43 2018

"""
import sys
sys.path.append('E:\GitHub\ProfessorPitch\SQLite3')
import sqlite3

conn = sqlite3.connect('Customer.db')
c = conn.cursor()

##End create statement
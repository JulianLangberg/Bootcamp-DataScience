import pymysql

conexion = pymysql.connect(host='localhost',
                           database = 'henry_m3',
                           user= 'root',
                           password='1234')

cursor = conexion.cursor()

cursor.execute("SELECT * FROM cliente_venta")

for elemento in cursor:
   print(elemento)

conexion.close()
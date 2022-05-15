import random
import numpy as np

class JuegoCartas(object):
    def __init__(self):
        self.__mazo = []
        
    def crearPila(self):
        self.__mazo = list(range(1,21))
          
    
    def jugar(self):
        self.crearPila()
        random.shuffle(self.__mazo)
        cant_sac = int(input("Ingresar la cantidad de cartas que desea sacar:"))
        carta_sacadas = []
        suma_total = 0
        puntos = 10
        # 50 es la suma de las cartas que no debe superar para ganar.
        while suma_total < 50:
            carta_sacada = self.__mazo.pop()
            carta_sacadas.append(carta_sacada)
            suma_total = np.array(carta_sacadas).sum()
        num_cartas = len(carta_sacadas)-1

        if (int(cant_sac) == int(num_cartas)):
            print("Felicitaciones! Ganaste 10 puntos.")
        if (int(cant_sac) < int(num_cartas)): 
            puntos -= num_cartas - cant_sac
            print("Felicitaciones! Ganaste",puntos,"puntos.")   
        if (int(cant_sac) > int(num_cartas)):
            print("Perdiste! Tus cartas han superado la suma de 50, no ganas puntos")
        print("Las cartas que salieron para superar 50 fueron",len(carta_sacadas),":",carta_sacadas,"sumando",suma_total)   


j=JuegoCartas()
j.jugar()
            
    
        


import streamlit as st 

import pandas as pd
# Libraries
from PIL import Image
import datetime
import plotly.express as px
import plotly.graph_objects as go
import numpy as np

#import matplotlib.pyplot as plt
from scipy.signal import savgol_filter


header1 = st.container()
#dataset = st.container()
mod1 = st.container()


# Empezamos con CSV.

#file = '/content/drive/MyDrive/Colab Notebooks/Motor_Vehicle_Collisions-Crashes1.csv'
file = 'Motor_Vehicle_Collisions-Crashes1.csv'
df3 = pd.read_csv(file)
df_p = df3
#ETL


with header1:
    st.title("Siniestralidad vial en NYC: análisis descriptivo y su impacto en la economía")
#####    image = Image.open('/content/drive/MyDrive/Colab Notebooks/images/portada_nyc_car_crash.jpg')

#####    st.image(image, caption='NYC - Car crash') 


    st.markdown("En la presente investigación se utilizará información oficial sobre siniestralidad vial recolectada desde https://opendata.cityofnewyork.us/, información climatológica del National Centers for Environmental Information en https://www.ncei.noaa.gov/, y los costos económicos generados surgen de investigaciones presentadas en https://injuryfacts.nsc.org/ ")
    st.markdown("Equipo de trabajo:")
    st.markdown("Arnone, Miguel")
    st.markdown("Langberg, Julian")
    st.markdown("Ojeda, Guillermo Agustín")
    st.markdown("Villaraga, Carolina")
with mod1:
    st.title("A total NYC, EEUU paso por distintas etapas durante la pandemia")
    st.markdown("En el gráfico se observa como la cantidad de camas utilizadas para COVID-19 llego a varios picos en distintos años, pero con impactos diferentes en la cantidad de muertes")

## TRAIGO TABLAS Y HAGO GRAFICO INTRODUCTORIO 

df_p = df3
df_evolutivo = df_p[['crash_date','number_of_persons_injured','number_of_persons_killed']]
df_evolutivo.sort_values(by=['crash_date'])

df_evolutivo = df_evolutivo.groupby('crash_date')[['number_of_persons_injured','number_of_persons_killed']].sum().reset_index()
df_evolutivo['Lastimados_media_movil']=savgol_filter(df_evolutivo['number_of_persons_injured'], 51, 3)
df_evolutivo['Muertos_media_movil']=savgol_filter(df_evolutivo['number_of_persons_killed'], 51, 3)

df2018 = df_evolutivo[df_evolutivo['crash_date'] > '2018-01-01' ]

x = df2018['crash_date']

## Grafico evolutivo




st.subheader( '- Prepararse para tener Staff médico de reserva, la falta de estos recursos humanos tiene un efecto directo en la cantidad de muertes.')
st.subheader( '- Mayor dispoibilidad de camas para momentos pico, teniendo en cuenta que esta enfermedad atacó con más fuerza un grupo etario.')
st.subheader( '- Aunque la utilización de camas alcanzó, en los momentos de máxima demanda hubo faltante en Illinois y Washington')


import streamlit as st
import pandas as pd
# Libraries
from PIL import Image
import datetime
import plotly.express as px
import plotly.graph_objects as go
import numpy as np


header1 = st.container()
#dataset = st.container()
mod1 = st.container()


# Empezamos con CSV.
file = 'COVID-19_Reported_Patient_Impact_and_Hospital_Capacity_by_State_Timeseries.csv'
df = pd.read_csv(file)
#ETL
# me quedo con las columnas que voy a utilizar
df.drop(df.columns.difference(['state','date','critical_staffing_shortage_today_yes','inpatient_beds','inpatient_beds_used','inpatient_beds_used_covid','staffed_adult_icu_bed_occupancy','staffed_icu_adult_patients_confirmed_and_suspected_covid','staffed_icu_adult_patients_confirmed_covid','staffed_icu_adult_patients_confirmed_covid','total_adult_patients_hospitalized_confirmed_covid','total_pediatric_patients_hospitalized_confirmed_and_suspected_covid','total_staffed_adult_icu_beds','inpatient_beds_utilization','inpatient_beds_utilization_numerator','inpatient_beds_utilization_denominator','percent_of_inpatients_with_covid','percent_of_inpatients_with_covid_numerator','percent_of_inpatients_with_covid_denominator','inpatient_bed_covid_utilization','inpatient_bed_covid_utilization_numerator','inpatient_bed_covid_utilization_denominator','adult_icu_bed_covid_utilization','adult_icu_bed_covid_utilization_numerator','adult_icu_bed_covid_utilization_denominator',' adult_icu_bed_utilization','deaths_covid','all_pediatric_inpatient_bed_occupied','all_pediatric_inpatient_beds','staffed_icu_pediatric','patients_confirmed_covid','staffed_pediatric_icu_bed_occupancy','total_staffed_pediatric_icu_beds']), axis=1, inplace=True)
# ordeno y transfrmo campo date
df['date']=pd.to_datetime(df['date'])
df = df.sort_values('date',ascending=True)

with header1:
    st.title("Covid-19 en Estados Unidos: análisis del impacto en el sistema de salud")
    image = Image.open('coronavirUS.jpg')

    st.image(image, caption='US - Coronavirus Pandemic') 


    st.markdown("En la presente investigación se utilizara información oficial recolectada desde Healthdata.gov, y el paper de investigación 'Hospital length of stay among COVID-19-positive patients', https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8259605/ (USA), para conocer la duración promedio de una internación")
    st.markdown("Lic. Julian Langberg")
with mod1:
    st.title("A total país, EEUU paso por distintas etapas durante la pandemia")
    st.markdown("En el gráfico se observa como la cantidad de camas utilizadas para COVID-19 llego a varios picos en distintos años, pero con impactos diferentes en la cantidad de muertes")

# hago campo total país, para introducción del análisis
# agrupo por fecha
df_TotalPais_used_bed_covid = df.groupby('date',as_index=False)[['inpatient_bed_covid_utilization_numerator','adult_icu_bed_covid_utilization_numerator','deaths_covid']].sum()
# ordeno por fecha
df_TotalPais_used_bed_covid = df_TotalPais_used_bed_covid.sort_values('date',ascending=True)
#cambio nombres
df_TotalPais_used_bed_covid['Camas ocupadas COVID']=df_TotalPais_used_bed_covid['inpatient_bed_covid_utilization_numerator']
df_TotalPais_used_bed_covid['Camas ocupadas COVID ICU']=df_TotalPais_used_bed_covid['adult_icu_bed_covid_utilization_numerator']
df_TotalPais_used_bed_covid['Muertes COVID']=df_TotalPais_used_bed_covid['deaths_covid']

# Grafico introductorio, ocupación de camas, camas ICU y acumulado de muertes a TOTAL PAIS.

fig = px.line(df_TotalPais_used_bed_covid,x = df_TotalPais_used_bed_covid['date'],
                y=['Camas ocupadas COVID','Camas ocupadas COVID ICU','Muertes COVID'], 
                title='Evolución COVID-19 - United States', width=800, height=550,
                labels= {'date':'Fechas','value':'Cantidad'})

fig.add_trace(
    go.Scatter(x=list(df_TotalPais_used_bed_covid.date), y=list(df_TotalPais_used_bed_covid['Camas ocupadas COVID'])
                , name='Cantidad de camas COVID'))
# Add range slider
fig.update_layout(
    xaxis=dict(
        rangeselector=dict(
            buttons=list([
                dict(count=1,
                     label="1m",
                     step="month",
                     stepmode="backward"),
                dict(count=6,
                     label="6m",
                     step="month",
                     stepmode="backward"),
                dict(count=1,
                     label="YTD",
                     step="year",
                     stepmode="todate"),
                dict(count=1,
                     label="1y",
                     step="year",
                     stepmode="backward"),
                dict(step="all")
            ])
        ),
        rangeslider=dict(
            visible=True
        ),
        type="date"
    )
)

# Plot!
st.plotly_chart(fig, use_container_width=True)



st.markdown('La mayor cantidad de muertes diarias se observa en el comienzo de la pandemia')
fig2 = px.line(df_TotalPais_used_bed_covid,x = df_TotalPais_used_bed_covid['date'],
                y=df_TotalPais_used_bed_covid['deaths_covid'], 
                title='Evolución COVID-19 - United States', width=800, height=550,
                labels= {'date':'Fechas',
                        'inpatient_beds_used_covid':'Camas ocupadas COVID-19'})

fig2.add_trace(
    go.Scatter(x=list(df_TotalPais_used_bed_covid.date), y=list(df_TotalPais_used_bed_covid['deaths_covid']),name = 'deaths_covid'))
# Add range slider
fig2.update_layout(
    xaxis=dict(
        rangeselector=dict(
            buttons=list([
                dict(count=1,
                     label="1m",
                     step="month",
                     stepmode="backward"),
                dict(count=6,
                     label="6m",
                     step="month",
                     stepmode="backward"),
                dict(count=1,
                     label="YTD",
                     step="year",
                     stepmode="todate"),
                dict(count=1,
                     label="1y",
                     step="year",
                     stepmode="backward"),
                dict(step="all")
            ])
        ),
        rangeslider=dict(
            visible=True
        ),
        type="date"
    )
)
st.plotly_chart(fig2, use_container_width=True)


st.markdown('Calculadora de internaciones a total país entre dos fechas')
promedio_internacion = 7.18
init = st.date_input(
     "Seleccionar fecha de inicio",
     datetime.date(2020, 1, 1))
fin = st.date_input(
     "Seleccionar último dia de análisis",
     datetime.date(2020, 1, 1))




calc_inter = df_TotalPais_used_bed_covid[(df_TotalPais_used_bed_covid['date'].dt.date > pd.to_datetime(init)) & (df_TotalPais_used_bed_covid['date'].dt.date < pd.to_datetime(fin))].sort_values('date',ascending=True)

calc_inter = round(calc_inter['inpatient_bed_covid_utilization_numerator'].sum()/promedio_internacion,0)
st.write('La candidad de internaciones entre:', init, 'y',fin,'fue de ',calc_inter)


st.title("Los Estados también sufrieron de manera heterogénea el impacto de la pandemia")


df_mapa= df.groupby('state',as_index=False)[['inpatient_bed_covid_utilization_numerator']].sum()
df_mapa['inpatient_bed_covid_utilization_numerator']=round(df_mapa['inpatient_bed_covid_utilization_numerator']/promedio_internacion,0)
df_mapa.rename(columns = {'inpatient_bed_covid_utilization_numerator':'Cantidad_Internaciones'}, inplace = True)
dashfig1 = px.choropleth(df_mapa,locations = df_mapa['state'], locationmode='USA-states',scope='usa',color = 'Cantidad_Internaciones')
dashfig1.update_layout(title_text = 'Internaciones de COVID-19 por Estado',geo_scope='usa')

st.plotly_chart(dashfig1, use_container_width=True)




st.title("En los primeros 6 meses del 2020, NY, CA, FL, TX e IL fueron los Estados con mayor ocupación hospitalaria.")

promedio_internacion = 7.18
# seleccionar periodo de Lockdown
df_2020EJ = df[(df['date'].dt.date > pd.to_datetime('2020-01-01')) & (df['date'].dt.date < pd.to_datetime('2020-07-01'))].sort_values('date',ascending=True)
#agrupar por estado y sumar valores de utilizacion de camas covid
df_EJ_acum = df_2020EJ.groupby('state',as_index=False)[['inpatient_bed_covid_utilization_numerator']].sum()
# dividirlo por el promedio de dias que esta internado cada persona
df_EJ_acum['inpatient_bed_covid_utilization_numerator']=round(df_EJ_acum['inpatient_bed_covid_utilization_numerator']/promedio_internacion,0)
# ordenarlo y seleccionar el top 5
df_EJ_acum=df_EJ_acum.sort_values('inpatient_bed_covid_utilization_numerator', ascending=False)
internaciones_acum_top = df_EJ_acum.head()

 
fig3 = px.bar(internaciones_acum_top, x = "state", y = "inpatient_bed_covid_utilization_numerator",
         title='Máxima cantidad de camas utilizadas',
        labels= {'state':'Estados',
                        'inpatient_bed_covid_utilization_numerator':'Ocupación hospitalaria (camas)'})

st.plotly_chart(fig3, use_container_width=True)


mod2 = st.container()
with mod2:
    st.title("En el comienzo de la pandemia, New York fue el Estado con el sistema de salud más comprometido")
    st.markdown("La ciudad de NY atrae visitantes de todo el mundo, y fue la puerta de entrada del COVID-19 a EEUU")

image = Image.open('NY-Epicenter.png')

st.image(image, caption='New York City Region Is Now an Epicenter of the Coronavirus Pandemic')  


# 2 - Analice la ocupación de camas (Común) por COVID en el Estado de Nueva York durante la cuarentena establecida e indique:
#Intervalos de crecimiento y decrecimiento
#Puntos críticos (mínimos y máximos) La cuarentena en NY fue entre 22/03/2020 al 13/06/2020
df_NY = df[(df['date'].dt.date > pd.to_datetime('2020-03-21')) & (df['date'].dt.date < pd.to_datetime('2020-06-14'))]
df_NY=df_NY[df_NY['state']=='NY'].sort_values('date',ascending=True)
fig4 = px.line(df_NY,x = df_NY['date'],y=df_NY['inpatient_bed_covid_utilization_numerator'], 
                title='Evolución camas COVID - Nueva York durante el Lockdown', width=800, height=550,
                labels= {'date':'Fechas',
                        'inpatient_bed_covid_utilization_numerator':'Camas ocupadas COVID-19'})
#Creo lineas verticales
fig4.add_vline(x='2020-04-14', line_width=3, line_dash="dash", line_color="green")             
fig4.add_vrect(x0="2020-04-14", x1="2020-06-13", 
              annotation_text="Máximo 14-04-2020, luego comienza descenso de internaciones", annotation_position="top left",
              annotation=dict(font_size=14, font_family="Times New Roman"),
              fillcolor="green", opacity=0.25, line_width=0)        

st.plotly_chart(fig4, use_container_width=True)   



st.title("Las Intensive Care Units (ICU) fueron la última linea de batalla, con pacientes que necesitaban ser intubados para sobrevivir")


df_2020 = df[(df['date']> pd.to_datetime('2020-01-01')) & (df['date'] < pd.to_datetime('2021-01-01'))].sort_values('date',ascending=True)
df_2020_acum = df_2020.groupby('state',as_index=False)[['adult_icu_bed_covid_utilization_numerator']].sum()

promedio_internacion_icu = 12.34
df_2020_acum['adult_icu_bed_covid_utilization_numerator']=round(df_2020_acum['adult_icu_bed_covid_utilization_numerator']/promedio_internacion_icu,0)
df_2020_acum=df_2020_acum.sort_values('adult_icu_bed_covid_utilization_numerator', ascending=False)
internaciones_acum_top = df_2020_acum.head()

fig5 = px.bar(internaciones_acum_top, x = "state", y = internaciones_acum_top["adult_icu_bed_covid_utilization_numerator"],
         title='Cantidad de camas ICU utilizadas',
        labels= {'state':'Estados',
                        'adult_icu_bed_covid_utilization_numerator':'Cant. de camas ICU utilizadas'})
st.plotly_chart(fig5, use_container_width=True)



# maxima utilización de ICU en 2020
df_2020_ICU = df_2020.sort_values('adult_icu_bed_covid_utilization_numerator', ascending=False) 
# me quedo con un único valor (y maximo) por Estado
df_2020_ICU_porc = df_2020_ICU.drop_duplicates(['state'], keep='first').sort_values('adult_icu_bed_covid_utilization', ascending=False).head(5)
df_2020_ICU_porc['adult_icu_bed_covid_utilization']=round(df_2020_ICU_porc['adult_icu_bed_covid_utilization']*100,1)

fig6 = px.bar(df_2020_ICU_porc, x = "state", y = "adult_icu_bed_covid_utilization",
         title='TOP 5: máximo porcentaje (%) de camas ICU utilizadas en 2020',
        labels= {'state':'Estados',
                        'adult_icu_bed_covid_utilization_numerator':'Máximo porcentaje de camas ICU utilizadas'})
st.plotly_chart(fig6, use_container_width=True)

st.markdown("La mayoria de las camas UCI fueron utilzadas para pacientes con COVID-19 en el período en análisis")
st.title("En los puntos de mayor demanda de cama UCI, esta superó la cantidad disponible")

df_icu = df.sort_values('adult_icu_bed_covid_utilization', ascending=False) 
df_ICU_ST = df_icu.drop_duplicates(['state'], keep='first').sort_values('adult_icu_bed_covid_utilization', ascending=False)
df_ICU_ST[['state','date','adult_icu_bed_covid_utilization']].sort_values('adult_icu_bed_covid_utilization', ascending=False)
df_ICU_ST['adult_icu_bed_covid_utilization']=round(df_ICU_ST['adult_icu_bed_covid_utilization']*100,1)
df_ICU_ST_mean = df.groupby('state',as_index=False)[['adult_icu_bed_covid_utilization']].mean()
header = ['state','adult_icu_bed_covid_utilization_mean']
df_ICU_ST_mean.columns = header
df_ICU_ST_mean['adult_icu_bed_covid_utilization_mean']=round(df_ICU_ST_mean['adult_icu_bed_covid_utilization_mean']*100,1)
df_ICU_ST = pd.merge(df_ICU_ST,df_ICU_ST_mean,on='state',how='left')
df_ICU_graph=df_ICU_ST[['state','date','adult_icu_bed_covid_utilization','adult_icu_bed_covid_utilization_mean']]

states=df_ICU_graph['state']
df_ICU_graph.drop(df_ICU_graph.tail(39).index,inplace=True)

fig7 = go.Figure(data=[
    go.Bar(name='% máximo camas ICU por COVID', x=states, y=df_ICU_graph['adult_icu_bed_covid_utilization']),
    go.Bar(name='% promedio camas ICU por COVID', x=states, y=df_ICU_graph['adult_icu_bed_covid_utilization_mean'])
])
# Change the bar mode
fig.update_layout(barmode='group',title='Utilización camas UCI (%)')
st.plotly_chart(fig7, use_container_width=True)

#st.write(df_ICU_graph.head(15))

st.markdown("La pandemia no impactó fuertemente en los grupos etarios pediátricos")
#st.title("En los puntos de mayor demanda de cama UCI, esta superó la cantidad disponible")

df_2020['total_pediatric_patients_hospitalized_confirmed_and_suspected_covid'].replace(np.nan,0)

df_2020_acum_ped = df_2020.groupby('state',as_index=False)[['total_pediatric_patients_hospitalized_confirmed_and_suspected_covid']].sum()


df_2020_acum_ped['total_pediatric_patients_hospitalized_confirmed_and_suspected_covid']=round(df_2020_acum_ped['total_pediatric_patients_hospitalized_confirmed_and_suspected_covid']/promedio_internacion,0)
df_2020_acum_ped=df_2020_acum_ped.sort_values('total_pediatric_patients_hospitalized_confirmed_and_suspected_covid', ascending=False)
internaciones_acum_top_ped = df_2020_acum_ped.head()

figped = px.bar(internaciones_acum_top_ped, x = "state", y = "total_pediatric_patients_hospitalized_confirmed_and_suspected_covid",
         title='TOP 5 Estados con mayor cantidad de internaciones pediatricas',
        labels= {'state':'Estados',
                        'total_pediatric_patients_hospitalized_confirmed_and_suspected_covid':'Cant. internaciones pediátricas'})
st.plotly_chart(figped, use_container_width=True)

st.markdown("NY, CA, TX y FL tuvieron la mayor cantidad de muertos en el 2021")

df_2021 = df[(df['date']> pd.to_datetime('2021-01-01')) & (df['date'] < pd.to_datetime('2022-01-01'))].sort_values('date',ascending=True)
df_2021_muertos = df.groupby('state',as_index=False)[['deaths_covid']].sum()
df_2021_muertos = df_2021_muertos.sort_values('deaths_covid', ascending=False)

states=df_2021_muertos['state'].head(15)

fig7 = go.Figure(data=[
    go.Bar(name='% máximo camas ICU por COVID', x=states, y=df_2021_muertos['deaths_covid'])])
fig7.update_layout(title='Cantidad de muertos por Estado')

st.plotly_chart(fig7, use_container_width=True)




st.title("¿Qué relación presenta la falta de personal médico, con la cantidad de muertes por covid durante el año 2021?")
st.markdown("Mediante un análisis de correlación, podemos responder esta pregunta")


corr_staff_death = round(df_2021[['critical_staffing_shortage_today_yes','deaths_covid']].corr(),2)

st.write(corr_staff_death)
from scipy import stats
correlation_coef, p_value = stats.pearsonr(df_2021['critical_staffing_shortage_today_yes'],df_2021['deaths_covid'])

st.write('El coeficiente de correlación entre la falta de staff médico y muertes por covid es de')
st.write(round(correlation_coef,2))

st.write('El coeficiente p_value entre la falta de staff médico y muertes por covid es de:')
st.write(p_value)

image = Image.open('correlation.png')

st.image(image, caption='Pearson Correlation') 


df_deaths = df[['date','deaths_covid']].sort_values('date', ascending=False)
df_deaths = df_deaths.groupby(pd.Grouper(key='date', axis=0,freq='M'))[['deaths_covid']].sum().sort_values('deaths_covid', ascending=False).reset_index().head(5)

df_beds = df[['date','inpatient_bed_covid_utilization_numerator']]
df_beds=df_beds.groupby(pd.Grouper(key='date', axis=0,freq='M'))[['inpatient_bed_covid_utilization_numerator']].sum().sort_values('inpatient_bed_covid_utilization_numerator', ascending=False).reset_index().head(5)
worst_month = pd.merge(df_deaths,df_beds,on='date',how='left')
worst_month = worst_month.dropna()

st.title("¿Cuál fue el peor mes de la pandemia?")
str(worst_month['date'])
st.write(worst_month)

image = Image.open('hospital_campana1.jpg')

st.image(image) 

st.subheader( '- Prepararse para tener Staff médico de reserva, la falta de estos recursos humanos tiene un efecto directo en la cantidad de muertes.')
st.subheader( '- Mayor dispoibilidad de camas para momentos pico, teniendo en cuenta que esta enfermedad atacó con más fuerza un grupo etario.')
st.subheader( '- Aunque la utilización de camas alcanzó, en los momentos de máxima demanda hubo faltante en Illinois y Washington')


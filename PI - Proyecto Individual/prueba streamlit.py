import streamlit as st
import pandas as pd
# Libraries
import datetime
import plotly.express as px

header1 = st.container()
#dataset = st.container()
mod1 = st.container()
mod2 = st.container()

# Empezamos con CSV.
file = 'COVID-19_Reported_Patient_Impact_and_Hospital_Capacity_by_State_Timeseries.csv'
df = pd.read_csv(file)
df.drop(df.columns.difference(['state','date','critical_staffing_shortage_today_yes','inpatient_beds','inpatient_beds_used','inpatient_beds_used_covid','staffed_adult_icu_bed_occupancy','staffed_icu_adult_patients_confirmed_and_suspected_covid','staffed_icu_adult_patients_confirmed_covid','staffed_icu_adult_patients_confirmed_covid','total_adult_patients_hospitalized_confirmed_covid','total_pediatric_patients_hospitalized_confirmed_and_suspected_covid','total_staffed_adult_icu_beds','inpatient_beds_utilization','inpatient_beds_utilization_numerator','inpatient_beds_utilization_denominator','percent_of_inpatients_with_covid','percent_of_inpatients_with_covid_numerator','percent_of_inpatients_with_covid_denominator','inpatient_bed_covid_utilization','inpatient_bed_covid_utilization_numerator','inpatient_bed_covid_utilization_denominator','adult_icu_bed_covid_utilization','adult_icu_bed_covid_utilization_numerator','adult_icu_bed_covid_utilization_denominator',' adult_icu_bed_utilization','deaths_covid','all_pediatric_inpatient_bed_occupied','all_pediatric_inpatient_beds','staffed_icu_pediatric','patients_confirmed_covid','staffed_pediatric_icu_bed_occupancy','total_staffed_pediatric_icu_beds']), axis=1, inplace=True)
df['date']=pd.to_datetime(df['date'])
df = df.sort_values('date',ascending=False)
df_TotalPais_used_bed_covid = df.groupby('date',as_index=False)[['inpatient_bed_covid_utilization_numerator','adult_icu_bed_covid_utilization_numerator','deaths_covid']].sum()

with header1:
    st.title("Covid-19 en Estados Unidos: análisis del impacto en el sistema de salud")
    st.markdown("En la presente investigación se utilizara información oficial recolectada desde Healthdata.gov")

with mod1:
    st.title("A total país, EEUU paso por distintas etapas durante la pandemia")
    st.markdown("En el gráfico se obsera como la cantidad de camas utilizadas para COVID-19 llego a varios picos en distintos años, pero con impactos diferentes en la cantidad de muertes")
fig = px.line(df_TotalPais_used_bed_covid,x = df_TotalPais_used_bed_covid['date'],
                y=['inpatient_bed_covid_utilization_numerator','adult_icu_bed_covid_utilization_numerator','deaths_covid'], 
                title='Evolución COVID-19 - United States', width=800, height=550,
                labels= {'date':'Fechas',
                        'inpatient_bed_covid_utilization_numerator':'Camas ocupadas COVID-19'})

fig.add_trace(
    go.Scatter(x=list(df_TotalPais_used_bed_covid.date), y=list(df_TotalPais_used_bed_covid['inpatient_bed_covid_utilization_numerator'])
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

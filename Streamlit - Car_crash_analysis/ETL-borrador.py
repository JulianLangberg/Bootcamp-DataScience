############## ETL 
columns= ['crash_date','number_of_persons_killed','contributing_factor_vehicle']
df_motivos1 = df_p[['crash_date','number_of_persons_killed','contributing_factor_vehicle_1']]
df_motivos1.columns = columns 
df_motivos2 = df_p[['crash_date','number_of_persons_killed','contributing_factor_vehicle_2']]
df_motivos2.columns = columns
df_motivos3 = df_p[['crash_date','number_of_persons_killed','contributing_factor_vehicle_3']]
df_motivos3.columns = columns
df_motivos4 = df_p[['crash_date','number_of_persons_killed','contributing_factor_vehicle_4']]
df_motivos4.columns = columns


df_motivos_def = pd.concat([df_motivos1,df_motivos2],axis=0)
df_motivos_def = df_motivos_def.replace('Unspecified', np.nan)

df_motivos_def = df_motivos_def.dropna(axis=0)
df_motivos_def['lockdown']= pd.to_datetime(df_motivos_def['crash_date']).apply(lambda x : DateCovid(x))
df_motivos_def['week_day']=pd.to_datetime(df_motivos_def['crash_date']).dt.dayofweek
df_motivos_def['week_day'].replace([0,1,2,3,4,5,6],['0-lunes','1-martes','2-miércoles','3-jueves','4-viernes','5-sábado','6-domingo'],inplace=True)
df_motivos_def['season']= pd.to_datetime(df_definitivo['crash_date']).dt.month.apply(lambda x : MonthToSeason(x))
df_motivos_grouped = df_motivos_def.groupby('contributing_factor_vehicle').agg({'crash_date': ['count'], 'number_of_persons_killed': ['sum'] }).reset_index()
df_motivos_grouped.columns = ['contributing_factor_vehicle','number_of_crashes','number_of_persons_killed']
2
df_motivos_grouped = df_motivos_grouped.sort_values(by=['number_of_crashes'], ascending = True)
df_motivos_grouped_aux = df_motivos_grouped.tail(15)
############# PRE
motivos_pre = df_motivos_def[df_motivos_def['lockdown']=='1pre-Lockdown']
df_motivos_grouped_pre = motivos_pre.groupby('contributing_factor_vehicle').agg({'crash_date': ['count'], 'number_of_persons_killed': ['sum'] }).reset_index()
df_motivos_grouped_pre.columns = ['contributing_factor_vehicle','number_of_crashes','number_of_persons_killed']
df_motivos_grouped_pre = df_motivos_grouped_pre.sort_values(by=['number_of_crashes'], ascending = True)
df_motivos_grouped_aux_pre  = df_motivos_grouped_pre.tail(15)

############## POST
motivos_post = df_motivos_def[df_motivos_def['lockdown']=='3post-Lockdown']
df_motivos_grouped_post = motivos_post.groupby('contributing_factor_vehicle').agg({'crash_date': ['count'], 'number_of_persons_killed': ['sum'] }).reset_index()
df_motivos_grouped_post.columns = ['contributing_factor_vehicle','number_of_crashes','number_of_persons_killed']
df_motivos_grouped_post = df_motivos_grouped_post.sort_values(by=['number_of_crashes'], ascending = True)
df_motivos_grouped_aux_post  = df_motivos_grouped_post.tail(15)

############# POST LOCKDOWN-INVIERNO
motivos_post_winter = df_motivos_def[(df_motivos_def['lockdown']=='3post-Lockdown') & (df_motivos_def['season']=='1-winter')]
df_motivos_grouped_post_winter = motivos_post_winter.groupby('contributing_factor_vehicle').agg({'crash_date': ['count'], 'number_of_persons_killed': ['sum'] }).reset_index()
df_motivos_grouped_post_winter.columns = ['contributing_factor_vehicle','number_of_crashes','number_of_persons_killed']
df_motivos_grouped_post_winter = df_motivos_grouped_post_winter.sort_values(by=['number_of_crashes'], ascending = True)
df_motivos_grouped_post_winter  = df_motivos_grouped_post_winter.tail(15)

############## POST LOCKDOWN-VIERNES
motivos_post_viernes = df_motivos_def[(df_motivos_def['lockdown']=='3post-Lockdown') & (df_motivos_def['week_day']=='4-viernes')]
df_motivos_grouped_post_viernes = motivos_post_viernes.groupby('contributing_factor_vehicle').agg({'crash_date': ['count'], 'number_of_persons_killed': ['sum'] }).reset_index()
df_motivos_grouped_post_viernes.columns = ['contributing_factor_vehicle','number_of_crashes','number_of_persons_killed']
df_motivos_grouped_post_viernes = df_motivos_grouped_post_viernes.sort_values(by=['number_of_crashes'], ascending = True)
df_motivos_grouped_aux_post_viernes  = df_motivos_grouped_post_viernes.tail(15)

############### ETL
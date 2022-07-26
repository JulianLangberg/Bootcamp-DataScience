![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Reducción de la Dimensionalidad

El objetivo es <b>reducir la cantidad de features</b> en un dataset y puede servir para:

* Reducir el input en un modelo de regresión o clasificación
* Compresión de archivos
* Visualización
* Detectar features relevantes en datasets

Algunos de los métodos de reducción de dimensionalidad son:

* PCA: Principal Component Analysis (usa SVD)
* MDS: Multidimensional scaling
* t-SNE: t-distributed Stochastic Neighbor Embedding
* Auto-Encoders (Se hace con Redes Neuronales)
* LDA: Linear Discriminant Analysis (si hay etiquetas de clases)

## SVD – Descomposición en Valor Singular

Es un método de álgebra lineal que nos permite representar cualquier matriz en términos de la multiplicación de otras 3 matrices.

<img src="../_src/assets/SVD1.jpg" height="200"><br>

Es parte del corazón de muchos algoritmos numéricos (por ejemplo solución de sistemas lineales y pseudoinversa). En Machine Learning se utiliza para “reducir” adecuadamente la matriz M de datos, es decir, pasar de tener muchos features a tener menos, pero que sean lo más representativos posible.

<img src="../_src/assets/SVD2.jpg" height="200"><br>

Se puede demostrar algebraicamente que a toda matriz M se puede escribir como U x ∑ x V 

<img src="../_src/assets/SVD3.jpg" height="200"><br>

Se quiere una nueva matriz B que reemplace a M, que tenga menos columnas (menos features). 
Tomando solo los r  valores principales (elementos en la diagonal de Sigma) de valor más grande, podemos construir una matriz B que sea una “buena” reducción de M.

<img src="../_src/assets/SVD2.jpg" height="200">
<img src="../_src/assets/SVD4.jpg" height="200"><br>

* Matriz completa: es la M original, tiene toda la información.
* Matriz truncada: Se pierde información. Pero si se toma un valor de r adecuado, M’ es muy parecida a M. Construimos una matriz B mas chica que M, esta es la matriz con la que vamos a trabajar.

<img src="../_src/assets/SVD5.jpg" height="400"><br>

<img src="../_src/assets/SVD6.jpg" height="300"><br>

Si tenemos un dataset de 10 usuarios y 5 películas. Cada usuario puso un valor entre 0 a 5 a cada película.

Buscamos una matriz B más con menos columnas que M. Proponemos usar un valor de r =2 es decir que B será de 10 x 2:

<img src="../_src/assets/SVD7.jpg" height="300"><br>

Usaremos solo los 2 valores singulares más grandes de Sigma:

<img src="../_src/assets/SVD8.jpg" height="300"><br>
<img src="../_src/assets/SVD9.jpg" height="300"><br>

Ahora cada Usuario estará identificado por dos features X y Z. Notemos que los primeros 6 usuarios tienen un valor de módulo alto de X y bajo de Z. En los otros 4, se da al revés. 
Los features encontrados corresponden a los géneros.

Pasamos de identificar a cada usuario con un puntaje al género de las películas en lugar de a las películas en sí, pasamos de 5 a 2 features. 

Cuanta información se pierde por usar B en lugar de M?

<img src="../_src/assets/SVD10.jpg" height="200"><br>
<img src="../_src/assets/SVD11.jpg" height="300"><br>

### SVD – Hiperparámetro r

1) Para elegir el valor de r se puede mirar la distancia entre M y M’
<img src="../_src/assets/SVD12.jpg" height="100"><br>

El método de SVD garantiza que elegimos los mejores r vectores (combinaciones de features) para minimizar esta diferencia.
<img src="../_src/assets/SVD13.jpg" height="500"><br>

2) Tener algún criterio sobre el peso relativo de los valores singulares seleccionados respecto a la suma de todos. (Es más costoso, hay que calcular todos los valores singulares)

3) Gráficamente también se puede evaluar el mejor valor de r. Por ejemplo, si el espacio original tiene 2 coordenadas, 2 features. Esto sirve para definir la posición de todas las instancias del dataset (cada punto azul).
SVD nos da dos nuevos vectores, el 1er y 2do vector singular. Si usamos ambos como coordenadas, podemos definir perfecto la posición de cada punto.<br>
<img src="../_src/assets/SVD14.jpg" height="200"><br>

Veamos qué pasa si ahora sólo usamos el primer vector singular para definir los puntos:<br>
<img src="../_src/assets/SVD15.jpg" height="200"><br>

## PCA – Análisis de Componente Principal

* PCA es el método de reducción de dimensionalidad más utilizado. Es similar a SVD truncado, la diferencia está en:
  * PCA = Centrar datos + SVD truncado
* Debemos sustraer la media de cada columna de Features antes de aplicar SVD truncado.
* Matemáticamente, se puede llegar por otro camino (Matriz de covarianza)
* Tiene una interpretación muy intuitiva: 
  * Componentes Principales --> Direcciones de máxima varianza
  1) La primer componente principal está en la dirección donde los datos presentan varianza máxima. 
  2)  La segunda componente principal está la segunda dirección en términos de la varianza, y así sucesivamente. 

Enlaces recomendados:

* Principal Component Analysis (PCA), Step-by-Step (https://www.youtube.com/watch?v=FgakZw6K1QQ)
* Analisis de componentes principales (https://www.youtube.com/watch?v=AniiwysJ-2Y)

Tabla de analogías

| PCA | SVD |
| :-- | --: |
| Numero de componentes | Rango R |
| Componentes principales | Vectores singulares por derecha |
| Autovalores | Valores singulares  |
| Maximiza Varianza | Minimiza Distancia  |

## Sistemas de Recomendación

Es muy común encontrar en diversas plataformas, recomendaciones de productos para consumo, en base al producto seleccionado:<br>
<img src="../_src/assets/sistemas_recomendacion1.jpg" height="300"><br>

* Existen usuarios e ítems. Los usuarios prefieren algunos ítems por sobre otros.
* Ejemplo: Usuarios de Netflix y Películas. De 1 a 5 estrellas.
* El objetivo del sistema de recomendación es poblar la matriz de utilidad de una manera inteligente y bajo los requisitos que imponga cada entorno.<br>
<img src="../_src/assets/sistemas_recomendacion2.jpg" height="200"><br>
* Por ejemplo, Netflix tiene 150 millones suscriptores y 5 mil películas. La matriz tiene 750 mil millones de espacios, de los cuales la mayoría están vacíos.
* Cuando buscamos recomendar, interesa más recomendar ítems que van a gustar que aquellos que no van a gustar.
* En algunos casos, interesa mostrar a los usuarios novedades. 
* Algunas veces, ni siquiera hay calificaciones, solamente si vio o no (o escuchó, leyó, compró, etc.).
* Históricamente, las recomendaciones se hacían por medio de crítica de expertos, listas de favoritos, listas de clásicos, más populares, recientes, etc. Hoy las recomendaciones son específicas para cada usuario.

### Es posible diferenciar dos formas de hacer las recomendaciones:

1) Pedir a los usuarios que puntúen los ítems.
  * Los usuarios no suelen hacerlo
  * Si lo hacen, puede estar sesgado (gente que prefiere puntuar cosas que no le gustan a puntuar cosas que sí, etc.).
2) Inferir a partir de acciones
  * Ejemplo: compra muchas cosas de camping → le gusta el camping, aire libre, etc.
  * ¿Qué pasa con las cosas que no le gustan?

<img src="../_src/assets/sistemas_recomendacion3.jpg" height="300"><br>
<img src="../_src/assets/sistemas_recomendacion4.jpg" height="300"><br>

### Filtro basado en contenido:

1) Para cada ítem, debemos construir un perfil. 
    * Casos sencillos: información fácilmente disponible. Películas: director, género, actores, año, etc.
    * Casos complejos: Debemos extraer features de los ítems. Noticias: hay que usar la batería de herramientas de NLP (tf-idf, etc.)
2) Idealmente, también hay que construir un perfil de qué cosas le gustan al usuario.
3) Usamos una métrica de distancia para encontrar ítems similares.
    * Índice Jaccard
    * Distancia coseno
4) Recomendamos 

### Filtro colaborativo:

1) Se debe llenar la matriz de utilidad, por ejemplo con técnicas de clusterización para encontrar grupos de usuarios similares. De esos usuarios similares, los que tengan algún faltante en un ítem, se lo completa con, por ejemplo, el promedio del cluster.
2) Descomposición UV:<br>
<img src="../_src/assets/sistemas_recomendacion5.jpg" height="150"><br>
<img src="../_src/assets/sistemas_recomendacion6.jpg" height="300"><br>

#### ¿Cómo encontrar los valores para U y V?

* Utilizando una métrica para minimizar. En general, RMSE para los valores no nulos de la matriz.
* Se comienza en algún lugar al azar.
* Se busca el mínimo de la función de costo. Es el problema que resuelve el descenso por gradiente.

Un modelo híbrido, que utilice en paralelo ambos métodos, en ocasiones puede ser lo más adecuado<br>
<img src="../_src/assets/sistemas_recomendacion7.jpg" height="400"><br>

## Puesta en Producción

<img src="../_src/assets/puesta_en_produccion.jpg" height="400"><br>

Es necesario tener en cuenta algunos aspectos importantes a la hora de la puesta en producción:

1) Acceso
2) Compatibilidad (Lenguajes, Hardware, Librerías, etc.)
3) Escalabilidad


En un esquema Cliente – Servidor, existe el concepto de API (Application Programming Interface), que consiste en una librería con una serie de funciones que nos permiten comunicarnos con el servidor.

El Servidor, puede estar alojado en:
* Una red local o Intranet
* Nube o Internet

## Pipelines

Desde la carga de los datos con los que vamos a trabajar hasta la salida del modelo, solemos aplicar una serie de pasos encadenados uno detrás del otro. A este camino se le llama “flujo de trabajo” (Workflow). 
Por ejemplo, para un problema de NLP, el flujo podría esta compuesto por las siguientes acciones:<br>
<img src="../_src/assets/pipeline.jpg" height="200"><br>
Notemos que tanto los datos del Training Set como los del Test Set deben realizar este mismo recorrido.

Un Pipeline es un único objeto que permite empaquetar todas estas acciones que van del preprocesamiento de los datos a la predicción del modelo.

Ventajas:

* Simplifica el proceso y aumenta la reproducibilidad
* Evita cometer errores (como saltarse algún preprocesamiento o mezclar datos del training set con datos del test set)
* Simplifica la implementación de cross-validation y la elección de hiperparámetros.<br>

<img src="../_src/assets/pipeline2.jpg" height="300"><br>

Ejemplo:
```python
from sklearn.feature_extraction.text import CountVectorizer,TfidfTransformer
from sklearn.svm import LinearSVC
from sklearn.pipeline import Pipeline

X_train,X_test,y_train,y_test = make_my_dataset()

vect = CountVectorizer()
tfidf = TfidfTransformer()
clf = LinearSVC()

pipeline = Pipeline([('vect',vect),('tfidf',tfidf),('clf',clf)])
pipeline.fit(X_train,y_train)
y_preds = pipeline.predict(X_test)
```

### Enlaces recomendados:

* API de IBM Watson (https://cloud.ibm.com/apidocs/natural-language-understanding?code=python)
* Documentación IBM Watson (https://cloud.ibm.com/apidocs/natural-language-understanding?code=python)
* Pandas como Interfaz SQL (https://cloud.ibm.com/apidocs/natural-language-understanding?code=python)
* Towards Data Science. (https://towardsdatascience.com/)
* Kaggle (https://towardsdatascience.com/)
* Two Minutes Papers (https://www.youtube.com/user/keeroyz)
* Medium Machine Learning (https://medium.com/topic/machine-learning)

## Homework

![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Aprendizaje No supervisado

Llamamos Aprendizaje No Supervisado a los métodos para trabajar con datos (instancias) que no tienen asociados una etiqueta, una clase o un valor. 
A diferencia del Aprendizaje Supervisado, el objetivo principal ya no pasa por predecir la etiqueta, sino por encontrar patrones en el set de datos.
Clustering y Reducción de la Dimensionalidad, son dos las técnicas principales
Se utiliza para encontrar agrupaciones, características conjuntas o patrones en los datos.

## Clustering

Dado un set de datos, nuestro objetivo será encontrar grupos (clusters) en los cuales las instancias pertenecientes sean parecidas (estén “cerca”).

<img src="../_src/assets/clustering.jpg" height="300"><br>

### Algunas de sus aplicaciones son:

* Investigación de mercado
* Sistemas de recomendación
* Medicina 
* Biología (genética y especies)

### Y algunos de los algoritmos para hacer Clustering son:

* K-means
* DBSCAN
* Hierarchical Clustering (aglomerativo)
* Fuzzy C-Means (como K-means pero permite superposición)
* GMM: Gaussian Mixture Models (supone distribución gaussiana)

## K-Means

El objetivo es separar los datos en <b>k clusters</b>, donde k es un número dado, ubicando a las instancias que estén dentro de una región cercana dentro de un mismo cluster.
Es necesario encontrar un número k de centros (<b>centroides</b>), uno por cada cluster, de manera tal que <b>la distancia entre los centros y los datos más cercanos sea la mínima posible</b>. 
Luego cada instancia se identifica en el grupo del centroide más cercano.

<img src="../_src/assets/k-means.jpg" height="300"><br>

Consiste en un algoritmo iterativo hasta llegar al resultado:

1) Se inicializan los k Centroides. La ubicación inicial puede ser aleatoria o con algún criterio.
2) Encontrar el centroide más cercano. Se asigna cada instancia al centroide más cercano (el significado de “cercano” puede cambiar, es un hiper parámetro)
3) Actualizar los centroides. La nueva posición del centroide es el promedio de las posiciones de las instancias en ese cluster (de acá viene el means).
4) Repetir pasos 2 y 3. Se repiten los updates hasta que la posición del centroide ya no varíe.

<img src="../_src/assets/k-means2.jpg" height="350"><br>

[K-Means Clustering] (https://www.naftaliharris.com/blog/visualizing-k-means-clustering/)

## DBSCAN

DBSCAN = Density-Based Spatial Clustering of Applications with Noise.

El objetivo es <b>Identificar un número arbitrario de clusters</b>. Los clusters estarán definidos por densidad de puntos. Puede haber puntos que no pertenezcan a ningún cluster, es decir, <b>ruido (noise) ó outliers</b>.
Se recorre todo el dataset y se va identificando las zonas de puntos densamente pobladas como pertenecientes a un mismo cluster. 
Los puntos aislados serán reconocidos como ruido.

<img src="../_src/assets/dbscan.jpg" height="350"><br>

Consiste en un algoritmo iterativo hasta llegar al resultado:

1) Se define una distancia epsilon (parámetro) como la vecindad de un punto. Se elige un número de puntos mínimos de para considerar un cluster minPoints (parámetro). 
2) Luego se realiza el siguiente proceso sobre todos los puntos del dataset:
  1) Se toma un punto no visitado aleatoriamente. Se identifica si el punto es un <b>core</b>, es decir, si tiene minPoints en su vecindario. Si tiene pero no alcanza a minPoins se lo llama <b>border</b> y si no tiene ninguno, se lo llama <b>noise</b>. Este punto se marca como visitado.
  2) Si es un core o border y ninguno de sus vecinos fue visitado antes, por lo que no tienen cluster, se le asigna un nuevo <b>cluster</b>, pero si alguno sus vecinos  ya fue visitado y tiene asignado un cluster, se le asigna el mismo.
  3) Este proceso se repite hasta que todos los puntos hayan sido visitados.<br>
<img src="../_src/assets/dbscan2.jpg" height="200"><br>

<img src="../_src/assets/dbscan3.jpg" height="350"><br>

[DBSCAN Clustering] (https://www.naftaliharris.com/blog/visualizing-dbscan-clustering/)

Cuadro comparativo K-Means y DBSCAN:

| K-Means | DBSCAN  |
| :------ | -----:  |
| Muy Rápido  | Es computacionalmente más costoso |
| No tiene parámetros | Hay que elegir bien los parámetros  |
| Fácil de asignar nuevas instancias  | |
| Hay que definir el número de clusters | No hay que elegir el número de clusters |
| Sólo funciona bien con clusters tipo esferas  | Detecta cualquier forma de clusters |
| Sensible a outliers | Determina automáticamente los outliers  |
| | No anda bien si hay clusters de diferentes densidades |


## Evaluación de Modelos de Clustering

## Distancia Media al Centroide

Se busca una medida para la validación e interpretación de clusters en un dataset. 
Para esto, se busca cuál es la distancia media de cada dato al centroide más cercano:

<img src="../_src/assets/distancia_media.jpg" height="100"><br>

En el algorimto K-Means, se busca una medida para evaluar que tan bien resulta el clustereo dado el número de K utilizado:

<img src="../_src/assets/distancia_media2.jpg" height="100"><br>

### Inercia

El valor de inercia, es la distancia media total. El K óptimo implica buscar donde esta el ‘codo’ de la curva. El valor de inercia siempre desciende con el número de clusters.
En sklearn, uego de entrenar el modelo, la variable ‘model.inertia_’ tiene esa información.

<img src="../_src/assets/distancia_media3.jpg" height="300"><br>

### Silohuette

Es una medida para la validación e interpretación de clusters en un dataset (para cualquier método de clustering).
El objetivo, es medir qué tan parecidos son los datos con su propio cluster (<b>cohesión</b>) en comparación con qué tan parecidos son a otros clusters (<b>separación</b>).

<img src="../_src/assets/silohuette.jpg" height="150"><br>

* s(i): es el valor de silhouette para el dato i. 
* a(i): distancia media del dato i con el resto de su cluster
* b(i): dIstancia media del dato i con el cluster más cercano

Esto da una medida para cada dato de qué tan bien está ubicado en los clusters. Para una medida de todo el conjunto, se toma la media de todos los s(i).

Resultados: se suele mirar el perfil de todos los datos, buscamos que sea parejo:

<img src="../_src/assets/silohuette2.jpg" height="300"><br>
<img src="../_src/assets/silohuette3.jpg" height="300"><br>
<img src="../_src/assets/silohuette4.jpg" height="300"><br>
<img src="../_src/assets/silohuette5.jpg" height="300"><br>

## Homework
![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Modelos y Algoritmos

En este punto del curso, con los temas vistos, pudimos ver de cerca el proceso de limpieza, normalización y análisis de datos, en el que interactúan conceptos de probabilidad y estadística con diferentes métodos de tratamiento sobre los datos y sus fallas.

Como resultado de este proceso, deberíamos tener un conjunto de datos listo para ser abordado por alguno de los algoritmos de Machine Learning, cuyo propósito es entender la naturaleza del problema y las patrones subyacentes que deberán ser asimilados o «aprendidos» para realizar una clasificación o una predicción.

* Basado en un determinado numero de ejemplos en caso de supervisión, o agrupando por similitud.
* Se busca generalizar, aprender conceptos a partir de un conjunto de ejemplos y sus características. Cuantos más ejemplos, probablemente sea más fácil la tarea.
* Son robustos sistemas de regresión, capaces de ajustarse a una altísima dimensionalidad y una enorme complejidad, difícil de entender.
* El aprendizaje inductivo consiste en construir un modelo general a partir de información específica (instancias).
* El Sesgo Inductivo de un algoritmo de aprendizaje es el conjunto de afirmaciones que el algoritmo utiliza para construir un modelo.
  * Forma de las hipótesis (número y tipo de parámetros).
  * Características del funcionamiento del algoritmo (cómo recorre el espacio de hipótesis para elegir un único modelo).
) Como principio metodológico, ante igualdad de condiciones (por ejemplo, igual desempeño), debemos elegir al modelo más simple porque esperamos que generalice mejor.

A diferencia de los Sistemas Expertos, el Aprendizaje Automático convierte datos en métodos, extrayendo conocimiento de los datos.
Utilizando algoritmos en dos partes:
* Aprendizaje (Entrenamiento)
* Resolución (Cálculo de la predicción o de la clasificación)

### Trabajo con algoritmos

Como resultado del proceso de Limpieza de Datos se debe tener en claro qué datos se tienen y formar un set confiable, una vez que eso se logró, podemos continuar con los siguientes pasos:

1) Selección del algoritmo: Elegir por diferentes criterios el que se va a emplear y testear.
2) Entrenamiento: Conforme al algoritmo escogido y los datos que se tienen hay que ver
si el entrenamiento da resultados.
3) Evaluación de Calidad: Se utilizan métricas y métodos para decidir si el algoritmo es adecuado o se debe cambiar, como así también si es preciso ajustar sus hiperparámetros.
4) Ajuste de hiperparámetros: Se los modifica según el tipo de situación, los datos y las métricas arrojadas durante y tras el entrenamiento realizado. Volver al paso 2.
5) Objetivos y Métricas: Si se está satisfecho, fin de la tarea y modelo entrenado, si no es así, debemos volver al paso 1.

### Clasificación de los algoritmos

Por la manera de aplicación.
* Supervisado: Una empresa cuenta con un dataset de datos crediticios de clientes y una de las columnas dice si es precavido ofrecerle un préstamo o no (variable objetivo).
El algoritmo deberá encontrar qué tienen en común ambos grupos (aprender), para poder predecir automáticamente si conviene o no dar un préstamo a un nuevo cliente.
* No supervisado: En este caso no contamos con la variable objetivo, por lo que no hay datos de entrenamiento y test.
El algoritmo deberá agrupar las instancias por sí solo, extrayendo nuevas variables que expliquen los datos. Se busca explorar el dato.

Por el tipo de tarea a realizar.
* Clasificación: El dato que jamás vi, ¿pertenece a la clase A o B? Basado en un determinado número de ejemplos en caso de supervisión, o agrupando por similitud. Se busca generalizar para clasificar.
* Regresión: Ante un nuevo dato, ¿puedo predecir una de las variables en base a otra/s? Se busca generalizar para predecir.
Por el tipo de modelo subyacente.
* Búsqueda de anomalías: Se puede extraer patrones y agrupar los datos,  pero existen valores que se alejan de esos patrones, o puntos medios o de mayor distribución de ocurrencia y se denominan Outliers.
* Aprendizaje reforzado: Similar al aprendizaje por recompensa, si una acción llevó a un caso de éxito, entonces se refuerza esa acción.

Por el tipo de modelo subyacente
* Generativo: Aprende la distribución conjunta de probabilidad: p(x,y)
* Discriminativo: Aprende la distribución condicional de probabilidad: p(y|x)

Por ejemplo, si contamos con estos datos:

<img src="../_src/assets/generativo_discriminativo.jpg"  height="200">

## Arbol de Decisión

Este algoritmo divide el conjunto de datos en subconjuntos en forma sucesiva hasta obtener nodos en que la totalidad de sus elementos pertenecen a un mismo valor de la lasificación. La división está basada en el criterio más significativo para diferenciar los elementos:

* Disminuir la Entropía / Ganancia de Información.
* Gain Ratio: corrige la preferencia de ganancia de información por atributos con demasiados valores.
* Coeficiente o Impureza de Gini: Apunta a que que las muestras obtenidas en la subdivisión sean lo más “puras” posibles. Es decir, tengan instancias de una sola de las clases.

Los árboles generalizan muy bien a problemas multiclase y de regresión.

La disminución de entropía y la impureza de Gini son conceptos muy parecidos:

* Que cada nodo tenga la menor cantidad de clases distintas.
* El índice Gini busca disminuir la desigualdad entre los elementos de la clase.
* Cada nuevo nodo a su vez es separado en nuevos nodos secundarios, hasta llegar a la condición de fin, que puede ser profundidad o cantidad mínima de elementos en cada nodo.
* Hay un procedimiento estadístico que cuantifica la pureza de las muestras.

Tomemos de ejemplo el caso de las mediciones de las dos especies de polillas. Queremos analizar esos datos para que, ante una nueva medición, se pueda predecir de qué especie se trata.

<img src="../_src/assets/arbol_decision_polillas_tabla.jpg"  height="400">

Como se puede ver, no es posible trazar dos líneas rectas que dividan perfectamente las clases, entonces el algoritmo buscará minimizar ese error.

<img src="../_src/assets/arbol_decision_polillas.jpg"  height="200">

Se comienza construyendo una pregunta por cada columna y evaluando cuál deja mejor separadas las instancias:

<img src="../_src/assets/arbol_decision_polillas_tabla2.jpg"  height="400">
<img src="../_src/assets/arbol_decision_preg1.jpg"  height="200">

<img src="../_src/assets/arbol_decision_polillas_tabla3.jpg"  height="400">
<img src="../_src/assets/arbol_decision_preg2.jpg"  height="200">

¿Cuál de las dos preguntas separó mejor las clases?

1) En primer lugar, se calcula la impureza de Gini de la muestra:

Gini inicial = 1 - (proporción de Luna)2 - (proporción de Emperador)2

Son 14 instancias, 8 Luna y 6 Emperador:

Gini inicial = 1 - (8/14)2 - (6/14)2 = 0.4898

Casos extremos:
* Si la muestra tiene solamente miembros de una clase, entonces Gini = 1 - (proporción única clase)2 = 0
* Si la muestra tiene mitad y mitad: Gini = 1 - (1/2)2 - (1/2)2 = 0.5

2) Se calcula la Impureza Gini luego de hacer cada pregunta. Para eso se hace un promedio ponderado de las impurezas resultantes en cada hoja, por pregunta.

<img src="../_src/assets/arbol_decision_preg3.jpg"  height="300">

3) Se elige el atributo con índice de impureza mas pequeño, dado que el Gini Inicial es de 0,4898 mientras que el Gini de Envergadura es 0.3869 y el de Masa es 0.4571, el elegido es el de Envergadura.

4) Si consideramos que las instancias ya están clasificadas suficientemente bien, se finaliza. Sino, seguimos construyendo el árbol de forma iterativa, tomando como muestra inicial la muestra de cada hoja y realizando los pasos 1 a 4.

Finalmente, el árbol de decisión tendría la siguiente forma, con profundidad 2:

<img src="../_src/assets/arbol_decision_final.jpg"  height="300">

| Ventajas | Desventajas |
| :---      |  ---: |
| Simple de entender, interpretar y visualizar. Esto es una gran ventaja, también, al momento de comunicar nuestro trabajo.      | Poder de generalización relativamente bajo en muchas circunstancias. |
| Entrenamiento rápido.   | Desempeño inferior a modelos más modernos. |
| ¡Muchas implementaciones y variantes! | ¡Muchas implementaciones y variantes! |
| Modelo base para modelos más complejos (Random Forest, XGBoost, etc.). |   |

[Enlace recomendado] (https://www.youtube.com/watch?v=z-EtmaFJieY)

## Parámetros e hiperparámetros

En los distintos modelos vamos a tener valores de ajuste sobre el algoritmo, algunos de los cuales podremos modificarlos manualmente y llamamos hiperparámetro, en el caso de este árbol de decisión, será su profundidad, que es 2 en este caso, la cantidad de elementos en que se puede dividir un nodo o el criterio de subdivisión (Gini o Entropía).
Por otra parte, existen valores de ajuste que son resultado del proceso interno del algoritmo, como por ejemplo los valores 45 y 750 del caso, esos no se ajustan manualmente y se denominan parámetros.

## Fronteras de decisión

En los distintos modelos, podemos tener visualmente la distribución de los datos y también el resultado del proceso de aplicación algoritmo.
Tomando el caso del ejemplo, podemos observar las líneas de división de ambas especies, aplicando las dos preguntas tenemos los cuadrantes, uno de los cuales pertenecen a Emperador y los otros a Luna.

<img src="../_src/assets/fronteras_decision.jpg"  height="300">
 
## K-Vecinos más cercanos (KNN)

Dada una nueva instancia de la cual no conocemos la etiqueta objetivo, vamos a asumir que su etiqueta será igual a la de las instancias “vecinas” en el conjunto de datos que tenemos.
Por ejemplo, si tenemos los features X1 y X2, y además un tercer feature que es la clase, que puede ser A o B.
Dada una instancia nueva de la que no se conoce su clase, se recurre a sus vecinos más cercanos para clasificarla y K es la cantidad de vecinos que se evalúan para saber la clase de la nueva instancia.

<img src="../_src/assets/k-vecinos2.jpg" height="300">

* K es el hiperparámetro
* Si tomamos K = 3, entonces vamos a clasificar la nueva instancia como de clase B, ya que habrá dos instancias de B y una de A.
* Si tomamos K = 6, entonces vamos a clasificar la nueva instancia como de clase A, ya que habrán cuatro instancias de A y dos de B.
* No hay una receta para elegir K de antemano, depende del problema. Normalmente la solución es probar varios valores y ver cual modelo se desempeña mejor.
* Puede ser muy importante reescalar los valores de los features, por ejemplo llevando a escala de z-score, antes de usar este modelo.
* El valor que se elija para K va a ser determinante para el desempeño del modelo.

<img src="../_src/assets/k-vecinos3.jpg" height="200">

Con variables numéricas se resuelve mediante distancia Euclideana, pero no es la única, también puede hacerse mediante la distancia de Manhattan o la de Minkowski:

<img src="../_src/assets/k-vecinos_Formula.jpg" height="100">

Con variables categóricas se resuelve mediante distancia de Hamming, diferencia entre los caracteres de las palabras:

<img src="../_src/assets/k-vecinos_Formula2.jpg" height="100">

[Enlace recomendado] (https://shapeofdata.wordpress.com/2013/05/07/k-nearest-neighbors/)

| Ventajas | Desventajas |
| :---      |  ---: |
| Simple de entender, interpretar y visualizar. Esto es una gran ventaja, también, al momento de comunicar nuestro trabajo. | Lento para clasificar. |
| Entrenamiento rápido. Esta etapa consiste simplemente en “recordar” los datos. | Ocupa mucho espacio en el disco (tiene que guardar todo el set de entrenamiento). |

## Homework
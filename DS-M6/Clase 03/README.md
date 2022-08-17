![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Regresión Polinómica

* Utiliza un polinomio de grado n, con n>= 2.
* Lo más habitual es utilizar hasta n=4. Más allá se corre el riesgo de caer en un sobre ajuste del modelo a los datos, hecho conocido como overfitting o sobreadaptación. Lo que consiste en un modelo que se ajusta excelente a los datos conocidos pero no tiene buen desempeño con los nuevos casos.
* La regresión polinómica selecciona la función con menor error cuadrático medio.
* Veamos ejemplo de los valores de una propiedad con una función cuadrática (grado 2)

<img src="../_src/assets/regresion_polinomica.jpg" height="200">

## Regresión Logística

* Es un caso particular de la regresión lineal, y consiste en que el resultado será binario, es decir, 0 o 1. Por eso su nombre.
* También se la denomina Sigmoide, la cual es de uso común en redes neuronales.

<img src="../_src/assets/regresion_sigmoide_formula.jpg" height="50">
<img src="../_src/assets/regresion_sigmoide.jpg" height="200">

## Regresión con K-Vecinos

Consiste en predecir la variable buscada en función al promedio ponderado de las instancias vecinas más cercanas.

En el ejemplo de los valores de las propiedades:
* La nueva instancia es Loan=142.000, queriendo predecir HPI.
* Si K=1, entonces es directamente el valor de la instancia más cercana, es decir 264.
* Si K=3, será el promedio de los HPI de las 3 instancias más cercanas, es decir 180.7
* Notar que las distancias podrían hacerse en base a Loan y Age juntas.

<img src="../_src/assets/regresion_k-vecinos.jpg" height="200">

[Enlace recomendado] (https://www.saedsayad.com/k_nearest_neighbors_reg.htm)

## Regrsión con Árbol de Decisión

* El resultado de cada nodo, será la variable destino, dada en función de la/s variable/s utilizadas para entrenar.
* En cada nodo, se usa reducción de desvío estándar de Y.
* Una hoja devuelve el promedio de Y sobre las instancias de la hoja.
* Como hiperparámetro se usó la profundidad 2.

<img src="../_src/assets/regresion_arbol.jpg" height="300">

[Enlace recomendado] (https://www.youtube.com/watch?v=zvUOpbgtW3c)

## Medición de Error en problemas de Regresión

1) MAE (Error absoluto medio):
  * Se suman las distancias entre el valor en y real, y el predicho. Aunque esos errores tienen distinto signo. Si sumamos sin considerar eso, podría suceder que se cancelen.
  * Sumando los valores absolutos, queda resuelto ese problema:
  * Sin embargo ahora, a mayor cantidad de muestras el error se hace mayor.
<img src="../_src/assets/regresion_mae.jpg" height="300">
<br>
2) MSE (Error cuadrático medio):
  * Si se calcula el promedio de la suma de errores entre la predicción de un punto y su valor real, pero este error elevado al cuadrado.
  * Lo que se obtiene es error cuadrático medio, y la línea que lo minimice será la propuesta por la regresión.
<img src="../_src/assets/regresion_mse.jpg" height="300">
* Por ejemplo, aproximar el valor de una propiedad por su superficie.
<img src="../_src/assets/regresion_lineal_2.jpg" height="100">
Si la regresión es multivariable será un polinomio  de R^n de la forma:
* y = ax^1 + bx^2 + … + zx^n + c 

## Evaluación de Modelos

La intención es evaluar si el modelo está aprendiendo o no de los datos. Una manera de hacerlo es verificar su desempeño frente a nuevas instancias. Pero, ¿por qué necesitamos nuevas instancias y no usamos, simplemente, las instancias que usamos para entrenar?

<img src="../_src/assets/evaluacion_modelos.jpg" height="180"><br>
* ¿Qué está pasando en cada una de las 3 situaciones?
* ¿Cuál de las 3 líneas separa mejor las cruces de los círculos?

Es claro que la opción “c” separa mejor debido a que tiene una adaptación mayor a los datos, esto se denomina overfitting o sobreajuste.
Por su parte, la opción “a” es la que peor reproduce la frontera entre ambos grupos, por el contrario presenta baja adaptación a los datos o underfitting.

<img src="../_src/assets/evaluacion_modelos2.jpg" height="200"><br>
[Enlace recomendado] (https://www.nature.com/articles/s41598-017-10324-y)

Un ajuste intermedio suele ser el apropiado, ya que los datos que tenemos son de entrenamiento y sabemos que tendremos que analizar datos que no se conocen. Entonces un ajuste muy alto puede ser contraproducente.
Muchos modelos son muy flexibles y, de esas dos situaciones, en general tendremos que preocuparnos más por el overfitting o sobreajuste.

<img src="../_src/assets/evaluacion_modelos3.jpg" height="200"><br>

En el flujo de trabajo se emula una situación donde el modelo es entrenado con ciertos datos y luego es evaluado con datos nuevos.

* Se separa una porción de los datos: En ocasiones esta separación no es al azar, sino que tiene un cierto criterio, esto depende del problema.
* Se evalúa el desempeño del modelo sobre los datos de entrenamiento.
* Luego, se evalúa sobre los datos que restan, que van a oficiar de esos datos que el modelo “nunca vio” y son nuevos.
* En todos los entornos de desarrollo de Machine Learning existe una función que hace la tarea de separación de los datos. En Scikit-Learn, la función se llama train_test_split().

* En Árboles de Decisión, el overfitting se controla principalmente con el hiperparámetro de profundidad.
  * Evitando construir el árbol más allá de cierta profundidad.
  * Construir el árbol entero, y luego “podar” las ramas cuando ello mejore la performance sobre los datos separados.
* En K-Vecinos el valor de K es determinante:
  * Si K=1 es lo mismo que simplemente tomar a la instancia más cercana como idéntica.
  * Si K es cercano al número de instancias es como tomar al promedio de la mayoría como la predicción o clasificación.
*En Regresiones polinómicas, si el grado es demasiado alto, se forma una curva que se ajusta demasiado a los datos de entrenamiento.

## Validación Cruzada

¿Cómo podemos evaluar si el modelo está aprendiendo o no de nuestros datos?
Una forma práctica de evaluar si nuestro modelo aprendió o no de nuestro datos es observar su desempeño frente a nuevas instancias.

En nuestro flujo de trabajo, tendremos que emular una situación donde el modelo es entrenado con ciertos datos y luego es evaluado con datos nuevos. 
* Train Test Split:
  * Separo los datos en dos conjuntos, Train y Test.
  * Entreno con los datos de Train
  * Evalúo el desempeño del modelo los datos de Test.

Evaluar el desempeño del sobreajuste de Test tiene varios usos:
* Obtenemos una evaluación realista del desempeño de nuestros modelos.
* Nos permite seleccionar el modelo que mejor desempeña sobre nuestros datos.

Pero Machine Learning involucra un proceso altamente iterativo. En general, entrenamos muchos modelos, ya sea de distinto tipo o variando hiperparámetros.

A medida que entrenamos nuevos modelos, puede ocurrir que un modelo tenga una buena performance en el conjunto de Test por azar.
Podemos creer que estamos seleccionando el mejor modelo disponible cuando en realidad estamos seleccionando un modelo mediocre. 
¿Se puede hacer mejor?

<img src="../_src/assets/validacion_cruzada.jpg" height="200"><br>

Separamos los datos con los que contamos en datos de entrenamiento y datos de prueba. 
Se entrena con los datos de entrenamiento y se mide la performance con los datos de prueba.

<img src="../_src/assets/validacion_cruzada2.jpg" height="150"><br>

El objetivo de la validación cruzada es obtener una evaluación de performance de nuestro modelo que sea independiente de la partición en entrenamiento y prueba de los datos.

Haciendo muchas particiones esperamos que la medida de performance sea independiente de la partición de los datos.

<img src="../_src/assets/validacion_cruzada3.jpg" height="200"><br>

### K-fold Cross Validation:

Es importante notar, que cada dato aparece una sola vez en los datos de prueba y k-1 en los datos de entrenamiento.

<img src="../_src/assets/validacion_cruzada_k-fold.jpg" height="200"><br>

1) Desordenar los datos
2) Separar en K folds (muestras) del mismo tamaño
3) Para cada fold que separamos:
	1) Elegir la fold como Test set, y las K-1 folds restantes como Train set. 
	2) Entrenar y evaluar el modelo. 
	3) Guardar el resultado de la evaluación y descartar el modelo.
4) Obtener una medida de performance del modelo como el promedio de las K evaluaciones obtenidas en (3). También es una buena práctica incluir una medida de la varianza de las métricas obtenidas porque nos da una noción de cuanto puede afectar haber elegido un grupo de datos de Test u otro.

Comparando muchos modelos con K-fold Cross Validation:

<img src="../_src/assets/validacion_cruzada_k-fold2.jpg" height="200"><br>

Conclusiones sobre K-fold Cross Validation:

* La validación cruzada es un procedimiento de remuestreo que se utiliza para evaluar modelos de aprendizaje automático en una muestra de datos limitada.
* El hiperparámetro más importante es k que se refiere al número de grupos en que se dividirá una muestra de datos dada.
* Es un método popular porque es fácil de entender y porque generalmente resulta en una estimación menos sesgada o menos optimista de la habilidad del modelo que otros métodos, como una simple división de train / test.
* ¡No siempre hay que separar al azar! En algunos casos (por ejemplo, predicción con series de tiempo), la validación cruzada toma otra forma.
* La validación cruzada está íntimamente relacionada con la optimización de hiperparámetros.

### Validación Cruzada Aleatoria

En este caso, cada dato puede aparecer más de una vez en el conjunto de prueba.

<img src="../_src/assets/validacion_cruzada_aleatoria.jpg" height="200"><br>

1) Se hace un train/test split para separar dos conjuntos: uno de desarrollo (dev, también llamado train) y uno de Held-Out (también llamado a veces test):

| Desarrollo  | Held-Out  |
| :---      |  ---: |
|Experimentación con atributos, algoritmos e hiperparámetros  | Estimación realista de performance  |

2) Dentro del conjunto de desarrollo, se hacen todas las pruebas que consideremos necesarias y evaluamos los modelos resultantes usando validación cruzada. Se elige el modelo a partir del desempeño en estos datos (y las otras condiciones que consideremos para el problema, como exhaustividad, Navaja de Ockham, etc.).

* Navaja de Okham: Ante igualdad de condiciones, la explicación más sencilla suele ser la más probable

3) Se evalúa el desempeño del modelo elegido en el conjunto de Held-Out. Es el desempeño que se reporta.

<img src="../_src/assets/validacion_cruzada_aleatoria2.jpg" height="250"><br>

Es muy importante, tanto que viene en todos los entornos de desarrollo de Machine Learning:

En Scikit-Learn:
- (https://scikit-learn.org/stable/modules/cross_validation.html)
- (https://scikit-learn.org/stable/modules/classes.html#module-sklearn.model_selection)

## Curvas de Validación

En general, el desempeño de un modelo depende de muchos hiperparámetros. Pero a veces hay uno que es el más importante, el que predomina sobre el resto. 
Para elegir el valor de ese hiperparámetro - y también caracterizar mejor el desempeño de nuestro modelo -, es útil obtener las curvas de validación.
Una curva de validación nos muestra el desempeño del modelo, tanto en el conjunto de entrenamiento como de testeo, en función de un hiperparámetro. 
Como en general el hiperparámetro que variemos va a modificar la “complejidad” del modelo (profundidad en árboles, vecinos en KNN, etc.), también nos sirve para diagnosticar overfitting y underfitting.
Es importante evaluar los modelos desde el punto de vista del problema que queremos resolver, y no quedarse únicamente en una medida de desempeño estadística.
La curva de validación, nos muestra el desempeño en función de los hiperparámetros, tanto para los datos de entrenamiento como los de prueba.

<img src="../_src/assets/curvas_validacion.jpg" height="250"><br>

## Datasets Desbalanceados

Un dataset balanceado es aquel que tiene - aproximadamente - la misma proporción de instancias de cada clase. Por ejemplo, en el caso binario, alrededor de 50:50 (1:1) de cada clase.
Un dataset desbalanceado es aquel que tiene muchas instancias de una clase y muy pocas de la otra, dificultando el entrenamiento. 
Por ejemplo,  en el caso binario, 90:10, 99:1, y peor.
La realidad es que un poco de desbalance de clases es de esperar y no afecta a nuestro análisis.
Pero bajo ciertas problemáticas, suelen haber datasets muy desbalanceados:
* Detección de fraudes
* Diagnóstico médico
* Falla en cadena de producción

<img src="../_src/assets/falla_cadena_produccion.jpg" height="250"><br>

Ante un dataset desbalanceado, hay que tener cuidado especialmente con:
* Cómo se entrenan los modelos
* Qué métricas se usan para evaluarlos

Existe un concepto denominado la paradoja de la exactitud que consiste en que dada una situación, donde la ocurrencia de un evento es de muy baja probabilidad, asumir siempre que no va a pasar va a dar una exactitud muy alta, aunque en sí mismo el modelo sea malo.

* Por ejemplo, asumir que la caída de nieve en Buenos Aires en cualquier momento, simplemente no va a ocurrir.

Ante un dataset con esta característica se pueden tomar diversas acciones:

1) Revisar la posibilidad de conseguir nuevos datos
2) Utilizar otra métrica que no sea la exactitud. Utilizar Matriz de Confusión, Precisión y Exhaustividad (recall) suelen ser las primeras opciones, pero hay más cosas por evaluar. ¿Un Falso Positivo tiene el mismo costo que un Falso Negativo?
3) Hacerle al dataset un remuestreo:
	* Oversampling: generar nuevas instancias de la clase minoritaria, ya sea copiando 	instancias preexistentes, o generando instancias sintéticas.
	* Undersampling: eliminar instancias de la clase sobrerrepresentada.
4) Probar diferentes modelos (modelos de ensamble suelen ser buenos) y/o agregarle peso a la clase subrepresentada (fácil desde Scikit-Learn).

La <b>exactitud</b> del modelo es básicamente el número total de predicciones correctas dividido por el número total de predicciones. <br>
La <b>precisión</b> de una clase define qué tan confiable es el resultado cuando el modelo responde que un punto pertenece a esa clase.  <br>
La <b>exhaustividad (recall)</b> de una clase expresa qué tan bien el modelo es capaz de detectar esa clase.  <br>
La <b>puntuación F1</b> de una clase viene dada por la media armónica de precisión y recuperación, combina la precisión y la exhaustividad (recall) de una clase en una métrica.

Para una clase dada, las diferentes combinaciones de exhaustividad (recall) y precisión tienen los siguientes significados:

	* alta exhaustividad + alta precisión: el modelo maneja perfectamente la clase	
	* baja exhaustividad + alta precisión: el modelo no puede detectar bien la clase pero es muy 	confiable cuando lo hace
	* alta exhaustividad + baja precisión: la clase está bien detectada pero el modelo también incluye 	puntos de otras clases
	* baja exhaustividad + baja precisión: el modelo maneja mal la clase

## Matriz de Confusión

Un examen médico tiene una probabilidad de detección de 0.99 y una probabilidad de Falso Positivo de 0.01. El objetivo del Test es detectar una enfermedad de relativa baja prevalencia, que solo la tiene una persona en mil. Luego de hacer el examen a 100000 personas y completar la matriz de confusión (es decir, calcular, en promedio, cuántos aciertos esperan obtener, cuántos Falsos Negativos, FP y Verdaderos Negativos).

¿Cuál es la probabilidad de que una persona tenga la enfermedad si el examen dio positivo?

<img src="../_src/assets/matriz_confusion.jpg" height="100"><br>

<img src="../_src/assets/matriz_confusion2.jpg" height="200"><br>

Entonces, ¿Cuál es la probabilidad de que una persona tenga la enfermedad si el examen dio positivo?

<img src="../_src/assets/matriz_confusion3.jpg" height="200"><br>

## Teorema de Bayes

¿Cuál es la probabilidad de que una persona tenga la enfermedad si el examen dio positivo? 
Usamos el Teorema de Bayes:

<img src="../_src/assets/teorema_bayes.jpg" height="250"><br>

* El Teorema de Bayes tiene en cuenta automáticamente la prevalencia de las clases.
* Dada una clasificación Binaria entre C+ y C-, llamamos X a los atributos, la formulación más general del problema de clasificación es:
  * P(C+|X)  =  P(X|C+) P(C+) / P(X) y P(C-|X) = P(X|C-) P(C-) / P(X)
* En general, es muy difícil formular de manera completa este problema. Necesitaríamos saber de qué tipo de distribución tiene cada feature, cómo están correlacionados, etc

Dados dos eventos A y B:
* P(A) es la probabilidad del evento A
* P(B) es la probabilidad del evento B
* P(A|B) es la probabilidad condicional del evento A dado que ocurrió B (No implica causalidad)
* P(B|A) es la probabilidad condicional del evento B dado que ocurrió A (No implica causalidad)
* Si P(A|B) = P(A) y P(B|A) = P(B), los eventos son independientes.

En general, P(A|B) ≠ P(B|A). 
Para obtener uno dado el otro, necesitamos el Teorema de Bayes:

<img src="../_src/assets/teorema_bayes2.jpg" height="100"><br>

* Explica como uno debe cambiar sus creencias, teniendo en cuenta nueva evidencia.
* Con la probabilidad total a partir de las probabilidades del suceso A (probabilidad de que llueva o de que haga buen tiempo) deducimos la probabilidad del suceso B  (que ocurra un accidente).
* Con el teorema de Bayes, a partir de que ha ocurrido el suceso B, deducimos las probabilidades del suceso A.

## Naive Bayes

Este modelo está basado en el Teorema de Bayes con un supuesto de independencia entre los predictores. Naive Bayes supone que la presencia de una característica particular en una clase no está relacionada con la presencia de ninguna otra característica.
Por ejemplo, una fruta puede considerarse una manzana si es roja, redonda y de aprox. 3” de diámetro. Incluso si estas características dependen unas de otras o de la existencia de otras características, todas estas propiedades contribuyen independientemente a la probabilidad de que esta fruta sea una manzana y por eso se conoce como "ingenua".
El modelo Naive Bayes es fácil de construir y particularmente útil para conjuntos de datos muy grandes.

Tomando como ejemplo un conjunto de datos sobre el clima y la variable "Jugar". Debemos clasificar si los jugadores jugarán o no según las condiciones climáticas.

<img src="../_src/assets/naive_bayes.jpg" height="250"><br>
<img src="../_src/assets/naive_bayes2.jpg" height="200"><br>

Tenemos que la probabilidad de que esté nublado es de 0.29, mientras que la probabilidad de jugar es de 0.64.

La pregunta que nos hacemos es: ¿Los jugadores jugarán si hay sol?

A continuación, se usa la ecuación Bayesiana para calcular la probabilidad a posteriori para cada clase. La clase con la probabilidad a posteriori más alta es el resultado de la predicción.

P(Yes | Sunny) = P( Sunny | Yes) * P(Yes) / P (Sunny)

P (Sunny |Yes) = 3/9 = 0.33
P(Sunny) = 5/14 = 0.36
P( Yes)= 9/14 = 0.64

P (Yes | Sunny) = 0.33 * 0.64 / 0.36 = 0.60

Nos queda que 0.6 es la probabilidad de que jueguen, si hay sol.

| Ventajas  | Desventajas  |
| :---      |  ---: |
|Es fácil de entender y rápido. | Suposición de variables independientes. En la vida real es casi imposible que obtengamos un conjunto de variables completamente independientes.  |
| Funciona bien en la predicción de clases múltiples. | Para las variables numéricas, supone una distribución Normal o Gaussiana, lo que implica un supuesto fuerte. |
| Cuando se asume la independencia, un clasificador Naive Bayes funciona mejor en comparación con otros modelos como la regresión logística y necesita menos datos de entrenamiento. |  |
| Funciona bien en el caso de variables de entrada categóricas. |   |

### Naive Bayes Multidimensional

* Ejemplo para 4 atributos:<br>
<img src="../_src/assets/naive_bayes_multidimensional.jpg" height="50"><br>
* Para n atributos:<br>
<img src="../_src/assets/naive_bayes_multidimensional2.jpg" height="50"><br>
* Fórmula general de Naive Bayes:<br>
<img src="../_src/assets/naive_bayes_multidimensional3.jpg" height="50"><br>

## Scores

La Matríz de Confusión tiene toda la información respecto del desempeño del algoritmo en relación a los casos reales, pero… ¿cómo se llega a la decisión de etiquetar en cada caso? ¿qué grado de certeza tiene el algoritmo?
Por ejemplo, dado un modelo de vecinos más cercanos, con K = 10.
En este caso, de 10 vecinos, 7 son amarillos, por lo que la etiqueta correspondiente sería amarilla.
Lo mismo ocurrirá cuando haya más de 5 vecinos de color amarillo. Si, en cambio, hay menos de 5 vecinos de color amarillo, la etiqueta pasa a ser gris.

<img src="../_src/assets/scores.jpg" height="400"><br>

Entonces, de una instancia que tiene 10 vecinos amarillos, podemos estar más seguros que la etiqueta correspondiente es amarrilla que una instancia que solamente tiene 6 vecinos.
Cuando miramos solamente las etiquetas asignadas, esta información la perdemos.
Sin embargo, es posible generar un Score que represente cuan seguro está el modelo de la etiqueta.
Este razonamiento se puede hacer con (casi) todos los modelos que usemos. En el fondo, lo que un modelo hace para asignar etiquetas es generar un score y poner el umbral a la mitad.
En Scikit-Learn, todos los modelos vienen con un método, predict_proba(X), que calcula los scores.
Si bien a primer orden estos scores pueden ser interpretados como probabilidades, la realidad es que no lo son, porque no están Calibrados. Lo que sí podemos usar son los Rankings que generan.

## Curva ROC

La decisión de clasificar un elemento es parte del algoritmo, esa elección puede estar fundada bajo diferentes niveles de certidumbre, pero ¿se podría obtener otros resultados si modificamos el umbral mediante el cual el algoritmo decide para clasificar?
Continuando con el ejemplo del test de enfermedad, se puede decir que en función del umbral habrá una variación de exhaustividad. Si el umbral es alto, la exhaustividad disminuye, porque se es muy “estricto” a la hora de identificar un caso positivo. Por el contrario, si se disminuye, la exhaustividad aumenta, porque el criterio para definir un positivo es muy “laxo”.
Es importante notar que a medida que se mueve el umbral, cambia la cantidad de Verdaderos positivos, Falsos positivos, Falsos Negativos y Verdaderos Negativos. 

<img src="../_src/assets/curva_roc.jpg" height="150"><br>

Para cuantificar esa variación, se establece:

<img src="../_src/assets/curva_roc2.jpg" height="150"><br>

La Curva ROC es un gráfico que muestra esa relación y representa el rendimiento de un modelo de clasificación en todos los umbrales.
* TPR: Tasa de Verdaderos Positivos
* FPR: Tasa de Falsos Positivos

Reducir el umbral de clasificación clasifica más elementos como positivos, por lo que aumentarán tanto los Falsos positivos como los Verdaderos positivos.

<img src="../_src/assets/curva_roc3.jpg" height="200"><br>

Debido a que la curva ROC es difícil de calcular, a menudo es más habitual trabajar con la AUC, área bajo la curva, que da una medición agregada del rendimiento en todos los umbrales de clasificación posibles. Una forma de interpretar el AUC es como la probabilidad de que el modelo clasifique un ejemplo positivo aleatorio más alto que un ejemplo negativo aleatorio.

<img src="../_src/assets/curva_roc4.jpg" height="200"><br>

¿Qué valor de umbral es mejor? 
Esto va a depender del problema, si se quiere favorecer precisión o exhaustividad.
Pero al área bajo la curva es un  indicador de cuán bueno es nuestro modelo independientemente de eso.

<img src="../_src/assets/curva_roc5.jpg" height="200"><br>

* Una curva ROC (Receiver Operating Characteristic) es una representación gráfica que ilustra la relación entre TPR y el FPR de un sistema clasificador para diferentes puntos de corte. NO confundir con una curva Precision-Recall.
* Se puede usar para generar estadísticos que resumen el rendimiento o la efectividad de un clasificador. El indicador más utilizado en muchos contextos es el área bajo la curva ROC o AUC (AUC- Área Bajo la Curva).
* Dato histórico: fue desarrollada por ingenieros eléctricos en la II Guerra Mundial, para medir la eficacia de la detección de objetos enemigos en el campo de batalla mediante señales de radar. Su uso está muy extendido en medicina para validar técnicas diagnósticas. 

Veamos este ejemplo, con pocos casos y observemos los valores de precisión y exhaustividad (recall) con un umbral de decisión de 0.5:

<img src="../_src/assets/umbral.png" height="400"><br>

¿Qué pasa si subimos el umbral de decisión de 0.5 a 0.75?

<img src="../_src/assets/umbral75.png" height="400"><br>

Notar cómo cambian los valores en la matríz de confusión, y esta acción aumenta el valor de precisión desde un 0.67 inicial a 0.75:
* TP / (TP + FP) = 3 / (3 + 1) = 0.75<br>
<img src="../_src/assets/umbral75matriz.png" height="200"><br>

¿Y qué pasa ahora si bajamos el umbral de decisión de a 0.2?

<img src="../_src/assets/umbral20.png" height="400"><br>

Notar cómo cambian los valores en la matríz de confusión, y esta acción aumenta el valor de exhaustividad desde un 0.8 inicial a 1:
* TP / (TP + FN) = 5 / (5 + 0) = 1<br>
<img src="../_src/assets/umbral20matriz.png" height="200"><br>

Implementación en Scikit-Learn:

<img src="../_src/assets/curva_roc6.jpg" height="200"><br>
<img src="../_src/assets/curva_roc7.jpg" height="200"><br>

## Optimización de Hiperparámetros

* ¿Cómo elegimos los mejores hiperparámetros para nuestro problema?
* ¿Qué es mejor, exactitud, precisión o exhaustividad? ¿Área bajo la curva ROC?
* Primero, se debe definir una métrica a optimizar. Una vez que se sabe cuál métrica optimizar, hay que probar los distintos valores de hiperparámetros.
* Se debe hacer una búsqueda exhaustiva. Es decir probando con todos los valores de los hiperparámetros que podamos y eligiendo la mejor combinación. Éste método se llama Grid Search (“búsqueda de cuadrícula”). 
* ¿Por ejemplo, si tenemos dos hiperparámetros, a y b, que pueden tomar valores a = {1,2} y b = {3,4}

<img src="../_src/assets/grid_search.jpg" height="200"><br>

Grid Search consiste en:

1) Elegir los valores que puede tomar cada hiperparámetro
2) Armar las combinaciones “todos con todos” → Armar la grilla
3) Recorrer la grilla entrenando el modelo para cada combinación y evaluarlo.
4) Elegir los hiperparámetros que definen el mejor modelo.

¿Cómo evaluar el modelo?

Al estar probando MUCHOS modelos, podría suceder que uno se desempeñe muy bien en el conjunto de Train simplemente por azar. 
Por esto ,es muy importante evaluar cada modelo creado por Grid Search con Validación Cruzada en el conjunto de entrenamiento. <br>
<b>Grid Search y Validación Cruzada suelen venir juntos.</b>

### Random Search

Si por ejemplo, se tienen cinco hiperparámetros y cinco valores para probar por hiperparámetro, el tamaño de la grilla comienza a crecer.
Además, para cada modelo se debe hacer la Validación Cruzada.
Este proceso puede ser computacionalmente muy demandante.
Random Search explora opciones y combinaciones al azar, de manera menos “ordenada”. En muchas circunstancias, esto es más eficiente, tanto desde el punto de vista de performance del modelo como de desempeño computacional.

<img src="../_src/assets/grid_search3.jpg" height="150"><br>

Conclusiones:

1) Es necesario definir una métrica a optimizar (exactitud, precisión, RMSE, ROC AUC, etc.)
2) Un modelo (regresor o clasificador)
3) Una grilla de hiperparámetros. Depende del tipo de modelo utilizado.
4) Un método para buscar o muestrear los candidatos
Grid Search: Plantea opciones y explora todas las combinaciones
Random Search: explora opciones y combinaciones al azar.
5) Crear un modelo lo antes posible, en cualquier caso, un modelo fallido muchas veces da tanta información sobre el proceso real como uno válido

## Homework
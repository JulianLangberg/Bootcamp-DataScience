![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Sesgo y Varianza

No es posible construir un modelo “perfecto” debido a que nunca podría estar libre de errores.

Comprender cómo son - y cómo influyen - las diferentes fuentes de errores nos ayudará a mejorar el proceso de ajuste de datos, lo que resultará en mejores modelos y, adicionalmente, también evitará el sobreajuste (overfitting) y falta de ajuste (underfitting).

El error de predicción para cualquier algoritmo de Machine Learning se puede dividir en tres partes:

* Error irreducible (ruido)
* Error de bias (sesgo)
* Error de varianza

### El error irreducible:

* No se puede reducir
* Se lo conoce como Ruido
* Proviene de factores como: 
  * Variables desconocidas que influyen en el mapeo de las variables de entrada a la variable de 	salida.
	* Un conjunto de características incompletos
	* Un problema mal enmarcado

No importa cuán bien esté el modelo, los datos tendrán cierta cantidad de ruido o un error irreductible que no se puede eliminar.
En cambio, <b>los errores de sesgo y varianza se pueden reducir porque se derivan de la elección del algoritmo de entrenamiento y del modelo.</b>

<img src="../_src/assets/sesgo_varianza.jpg" height="250"><br>

### El error de sesgo:

* El sesgo es el error que introducimos al intentar explicar un problema del mundo real al que le correspondería un modelo complejo con un modelo bastante más simple. 
* En general, modelos más flexibles y más complejos, implican menos sesgo.

Bajo BIAS:
Sugiere menos suposiciones sobra la forma de la función objetivo:
  * Árbol de Decisión
  * K-Vecinos más cercanos
  * Support Vector Machine

Alto BIAS:
Sugiere más suposiciones sobra la forma de la función objetivo:
  * Regresión Lineal
  * Análisis discriminante lineal
  * Regresión Logística

### El error de varianza:

* La varianza es la cantidad en la que cambiaría la predicción de haber entrenado el modelo con un conjunto de datos diferente.
* Por ejemplo, un modelo que se ajuste mucho a unos datos sufrirá una varianza considerable al cambiar dichos datos, y viceversa.

Baja Varianza:
Sugiere pequeños cambios en la estimación de la función objetivo con el conjunto de datos de la capacitación:
* Regresión Lineal
* Análisis Discriminado Lineal
* Regresión Logística
Alta Varianza:

Sugiere grandes cambios en la estimación de la función objetivo con el conjunto de datos de la capacitación:
* Árbol de Decisión
* K-Vecinos más cercanos
* Support Vector Machine

Observar el efecto del sesgo y la varianza sobre la predicción de un modelo, donde los puntos sobre la diana son diferentes ejecuciones del mismo.

<img src="../_src/assets/sesgo_varianza2.jpg" height="400"><br>

Los algoritmos de baja varianza (alto bias) tienden a ser menos complejos, con una estructura subyacente simple o rígida.
Entrenan modelos que son consistentes, pero inexactos en promedio. Estos incluyen algoritmos paramétricos o lineales, como la regresión lineal y Naive Bayes.

<img src="../_src/assets/sesgo_varianza3.jpg" height="200"><br>

Los algoritmos de bajo bias (alta varianza) tienden a ser más complejos, con una estructura subyacente flexible.
Entrenan modelos que son exactos en promedio pero inconsistentes. Estos incluyen algoritmos no lineales o no paramétricos, como árboles de decisión y k-vecinos más cercanos.

<img src="../_src/assets/sesgo_varianza4.jpg" height="200"><br>

Cuanto más flexible sea el modelo, la varianza  aumentará, y el sesgo disminuirá.
Por lo tanto, debemos prestar atención a estas características, ya que pueden introducir mucho ruido en nuestro modelo y, por lo tanto, hacerlo menos exacto. 
Con un análisis de ambos podemos evaluar el rendimiento del modelo.
Comprender el bias y la varianza es fundamental para comprender el comportamiento de los modelos de predicción, pero en general lo que realmente importa es el error general, no la descomposición específica. El punto ideal para cualquier modelo es el nivel de complejidad en el que el aumento en el bias es equivalente a la reducción en la varianza.

<img src="../_src/assets/sesgo_varianza5.jpg" height="250"><br>

En el gráfico, si nos movemos de izquierda a derecha:
* Aumenta la complejidad del modelo
* Baja el sesgo y aumenta la varianza. 
* Hasta que llega un momento en el que el error en los datos de test empieza a aumentar mientras que el de entrenamiento sigue disminuyendo. <b>Ese punto mínimo de error en los datos de test nos indica el nivel de complejidad óptimo para nuestro modelo.</b>

<img src="../_src/assets/sesgo_varianza6.jpg" height="250"><br>

Conclusiones:

* Modelo sesgado: No logra capturar la forma de los datos. En general, tiene desempeño muy similar en el set de entrenamiento y de validación. Asociado al underfitting.
* Modelo con mucha varianza: Demasiado ajustado a los datos . Tiene desempeño muy bueno en el set de entrenamiento y malo en el de validación. Asociado al overfitting.
* Curva de validación/complejidad: Score en función de la complejidad. Sirve para ver regiones de baja complejidad (sesgo, underfitting) y demasiada complejidad (alta varianza, overfitting)
* Curva de aprendizaje: Score en función de la cantidad de datos. Sirve para ver, dado un modelo fijo, cómo reacciona a distintos tamaño del dataset. En particular, útil para diagnosticar alta varianza o modelo muy complejo (dado el tamaño de nuestro dataset).

Enlaces recomendados:
* https://medium.com/appliedai-de/bias-variance-e4502eb4ad5
* https://elitedatascience.com/bias-variance-tradeoff

## Support Vector Machine

El siguiente gráfico representa dos grupos de puntos de clases distintas, que se intenta separar:

<img src="../_src/assets/svm.jpg" height="300"><br>

Para hacerlo, la solución más sencilla puede ser con una recta, sin embargo, existen infinitas rectas posibles que separan perfectamente los grupos de datos. Además, el mejor criterio para seleccionar una de esas rectas, es escoger una línea que capture el patrón general en los datos de entrenamiento, así cabe una buena posibilidad de que separe bien los datos de prueba ó nunca vistos.

Es necesario entonces: 
* Buscar rectas que clasifiquen correctamente los datos de entrenamiento.
* Entre todas estas rectas, elegir la que tenga la mayor distancia <b>d</b>, a los puntos más cercanos a ella.

Los puntos más cercanos que identifican esta recta se conocen como <b>vectores de apoyo</b> (Support Vectors). Y la región que definen alrededor de la línea se conoce como el <b>Margen</b>.

<img src="../_src/assets/svm2.jpg" height="300"><br>

Los datos que pueden ser separados por una recta (o en general, un <b>hiperplano</b>) se conocen como datos linealmente separables. El hiperplano actúa como un clasificador lineal. <b>SVM es extensible para n dimensiones</b>. En este caso, la recta de decisión se transformó en un <b>plano de decisión</b>, por tratarse de un problema de <b>3 dimensiones</b>.

<img src="../_src/assets/svm3.jpg" height="300"><br>

En la realidad, los datos NO suelen ser separables con una recta. Aunque tampoco se quiere descartar por completo al clasificador lineal, ya que parece adecuado para el problema, excepto por algunos puntos erróneos.

<img src="../_src/assets/svm4.jpg" height="300"><br>

En SVM, se puede especificar cuántos errores estamos dispuestos a aceptar mediante un parámetro llamado C, lo que permite dictaminar la relación entre:
* Tener un amplio margen.
* Clasificar correctamente la mayor cantidad de puntos de entrenamiento, dar un valor más alto de C implica que se esperan menos errores en los datos de entrenamiento.

<img src="../_src/assets/svm5.jpg" height="500"><br>

* Se puede observar como la línea se inclina a medida que aumenta el valor de C. 
* A valores altos, intenta acomodar las etiquetas de la mayoría de los puntos rojos presentes en la parte inferior derecha de los gráficos. 
* Esto probablemente no es lo que queremos para los datos de prueba. 
* El primer gráfico con C=0,01 parece captar mejor la tendencia general, aunque adolece de una menor precisión en los datos de entrenamiento en comparación con los valores más altos de C.

<img src="../_src/assets/svm6.jpg" height="300"><br>

* No siempre es posible separar los datos con una recta, plano o hiperplano. En esos casos es posible aumentar la dimensionalidad de los datos, agregando nuevas dimensiones que permitan aplicar clasificadores lineales.
* En este caso, no podemos separar los datos con un recta, entonces lo que hacemos es aumentar de 2 a 3 dimensiones, mediante una proyección a un nuevo espacio de 3D.
* Lo mejor posible con la recta del ejemplo, es un 75% de precisión en los datos de entrenamiento

Esto se puede resolver entonces, agregando una dimensión más a los datos, por ejemplo de alguna de las siguientes formas:

<img src="../_src/assets/svm7.jpg" height="100"><br>

Ahora, los datos proyectados con la nueva variable, sí pueden quedar separados:

<img src="../_src/assets/svm8.jpg" height="200"><br>

Para conocer el nuevo límite de separación, se mapea el hiperplano al espacio original.
* La forma del límite de separación en el espacio original depende de la proyección. 
* En el espacio proyectado, esto es siempre un hiperplano.
* Cuando se mapea de vuelta al espacio original, el límite de separación ya no es una recta. Esto también es cierto para los vectores de margen y de soporte. 
* En cuanto a nuestra intuición visual, tienen sentido en el espacio proyectado.

Entonces...
1) Para datos linealmente separables, SVM trabaja muy bien.
2) Para los datos que son casi linealmente separables, SVM puede funcionar bastante bien usando el valor correcto de C.
3) Para los datos que no son linealmente separables, podemos proyectar los datos a un espacio en el que sean perfectamente/casi linealmente separables, lo que reduce el problema a 1 ó 2.

Una gran parte de lo que hace que SVM sea universalmente aplicable es proyectar a dimensiones superiores. Y aquí es donde entran los <b>kernels</b>…

Un Kernel es una forma de calcular el <b>producto punto</b> de dos vectores x e y en algún espacio de características (posiblemente de mayor dimensionalidad), por lo que las funciones del kernel a veces se denominan “producto punto generalizado”.

Supongamos que tenemos un mapeo que trae nuestros vectores a algún espacio de características.
Un kernel es una función K que corresponde a este producto punto.			

Ejemplo: Definimos un mapeo polinómico a un espacio 3D:

<img src="../_src/assets/svm9.jpg" height="100"><br>

Entonces la función kernel asociada es:

<img src="../_src/assets/svm10.jpg" height="50"><br>

Normalmente no se define una proyección específica para los datos. En su lugar, se selecciona entre kernels disponibles, ajustándolos en algunos casos, para encontrar el que mejor se adapte.
Por supuesto que nada nos impide definir nuestros propios kernels, o realizar la 
proyección nosotros mismos, pero en muchos casos no es necesario. 

<img src="../_src/assets/svm11.jpg" height="200"><br>

Entonces, por ejemplo, creamos una tercer variable que esté dada por la función X elevado al cuadrado, lo cual, como puede verse, logra separar las dos clases…

<img src="../_src/assets/svm12.jpg" height="200"><br>

En el siguiente ejemplo, tenemos que la función x*y es la que mejor separa los puntos rojos de los azules:

<img src="../_src/assets/svm13.jpg" height="200"><br>

Algunos Kernels disponibles:

<img src="../_src/assets/svm14.jpg" height="250"><br>

Implementación con Scikit-Learn:

<img src="../_src/assets/svm15.jpg" height="300"><br>

### ¿Qué pasa si tenemos más de dos clases en SVM?

* En un problema con K clases, resolvemos K problemas binarios.
* Cada SVM está entrenada para separar una clase del resto de los patrones.
* Para una nueva instancia x, se corren los K clasificadores y se retorna la clase que tenga una función de decisión con el valor más alto (la clase con mayor confianza).

<img src="../_src/assets/svm16.jpg" height="300"><br>

Conclusiones:

SVM es un algoritmo de aprendizaje supervisado que se propone encontrar el hiperplano que mejor separe los datos, tal que se maximice el margen. 

* Hiperparámetros: C y Kernels.
* Ventajas: 
	* Eficaz en espacios de alta dimensión (incluso cuando son más que el número de instancias!).
	* Eficiente en memoria (sólo los vectores de soporte definen el hiperplano frontera).
	* Los kernels lo hacen muy versátil.
* Desventajas: 
	* Al usar kernels, hay que tener mucho cuidado de no caer en overfitting.
	* Funciona bien sólo para clasificación.

Enlaces recomendados: 
* [Support Vector Machines: A Visual Explanation with Sample Python Code] (https://www.youtube.com/watch?v=N1vOgolbjSc)
* (https://medium.com/datadriveninvestor/support-vector-machines-ae0ff2375479)
* (https://towardsdatascience.com/kernel-function-6f1d2be6091)
* (https://medium.com/@sitarzkonrad/interactive-3d-k-means-clustering-in-jupyter-1038470f687e)

## Estimación de grandes números

Con frecuencia nos encontramos con la necesidad de hacer una estimación, aún contando con poca información concreta del problema. 
Si bien se puede tener un cierto conocimiento del dominio, cuando hay pocos datos disponibles, una estimación aceptable es una tarea difícil. Sin embargo, hay conceptos matemáticos que pueden servir de herramienta para abordar este tipo de problemas y, a la vez, amigarse con las incertezas y los errores.
Imaginemos un frasco que se encuentra lleno de monedas de un peso, que a priori
no podemos contar, pero queremos saber
la cantidad de monedas que hay dentro.
Estudios demuestran que si planteamos la situación de estimar la cantidad de monedas del frasco a un cierto número de personas, sin más información que la simple visualización del frasco lleno, tendremos subyacente en esos datos un valor aceptablemente cercano a la cantidad real.
Se puede usar el valor promedio, la mediana
o el valor modal, pero si observamos cierta asimetría en la distribución de los datos, es decir, un sesgo o desbalance en la distribución del valor elegido, existe un valor que es más representativo y que logra llevar los datos a una distribución Normal o Gaussiana.

<img src="../_src/assets/grandes_numeros.jpg" height="150"><br>

Si en lugar de usar el dato tal y como está, usamos la potencia de diez que se acerca al valor de ese dato, es decir, lo llevamos a escala logarítmica, nos encontramos con el concepto de media geométrica y en esa escala podemos tener un valor más adecuado.
Para el ejemplo, usamos una distribución Gamma simulando las posibles respuestas de 2000 personas. Mostramos su histograma y el histograma de los logaritmos, y, por último, comparamos los valores medios obtenidos.

<img src="../_src/assets/media_geometrica.jpg" height="250"><br>

* En física se denomina problema de Fermi, a problemas que involucran el cálculo de cantidades que parecen imposibles de estimar dada la <b>limitada información disponible</b>. Fermi era conocido por su habilidad para hacer buenos cálculos a partir de datos escasos o nulos, y existen problemas diseñados para enseñar análisis dimensional y cálculo de estimaciones, mostrando la importancia de <b>identificar claramente las hipótesis</b> utilizadas. Estas estimaciones usan números que sean <b>potencia de 10</b>.
* Se conoce como <b>sabiduría de las masas</b> al hecho de que juntando las estimaciones
de muchas personas, en el resultado
global haya una aproximación adecuada a la realidad.
* En Machine Learning este concepto se aplica en metodologías conocidas como <b>Ensambles</b> (Random forest, boosting, bagging), que consisten en juntar el resultado de muchos <b>estimadores débiles</b>, para aportar un resultado final óptimo.

Enlaces recomendados:
* https://www.youtube.com/watch?v=n98BhnwWmsc
* https://www.youtube.com/watch?v=0YzvupOX8Is

## Ensambles

Consiste en entrenar muchos modelos y quedarse con el de mejor rendimiento, es decir, el que mejor clasifique.
Sin embargo, si todos los modelos son muy parecidos, no van a agregar mucha información nueva en la votación. 
Se necesitan modelos diferentes entre sí, poco correlacionados. 
Los modelos pueden ser diferentes entre sí por una variedad de razones:

* Puede haber diferencia en la población de datos
* Puede haber una técnica de modelado utilizada diferente
* Puede haber una hipótesis diferente

<img src="../_src/assets/ensambles.jpg" height="200"><br>

## Ensambles - Bagging

El Bagging es una de las técnicas de construcción de conjuntos que también se conoce como Agregación Bootstrap (Muestreo con reemplazo de las instancias).
1) Dada una muestra de datos, se extraen varias muestras, <b>bootstrapped</b>
2) Esta selección se realiza de manera aleatoria.
3) Una vez que forman las muestras bootstrapped, se entrenan los modelos de manera separada. En general, estos modelos serán <b>modelos con mucha varianza</b>.
4) La predicción de salida final se combina en las proyecciones de todos los submodelos.

<img src="../_src/assets/ensambles_bagging.jpg" height="250"><br>

<img src="../_src/assets/ensambles_bagging2.jpg" height="250"><br>

## Ensambles – Random Forest

Uno de los problemas que hay con el árbol de decisión es que si se le da la profundidad suficiente, el árbol tiende a “memorizar” las soluciones en vez de generalizar el aprendizaje, es decir, hace overfitting.
Para evitar esto, se crean muchos árboles para que trabajen en conjunto, la salida de cada uno se contará como “un voto” y la opción más votada será la respuesta del “Bosque Aleatorio”.
La aleatoriedad está en la selección del valor k de características para cada árbol y en la cantidad de muestras que usaremos para entrenar cada uno.

<img src="../_src/assets/random_forest.jpg" height="300"><br>

Si pocos atributos ó features son predictores fuertes, todos los árboles se van a parecer entre sí. Esos atributos terminarán cerca de la raíz para todos los conjuntos generados con bootstrap.
Random Forest es igual a bagging, pero en cada nodo, hay que considerar sólo un subconjunto de m atributos elegidos al azar (random feature selection).

Funcionamiento:
1) Se seleccionan k features de las m totales (siendo k menor a m) y se crea un árbol de decisión con esas k features.
2) Se crean n árboles variando siempre la cantidad de k features
3) Se guarda el resultado de cada árbol obteniendo n salidas.
4) Se calculan los votos obtenidos para cada “clase” seleccionada y se considera a la más votada como la clasificación final del “bosque”.

Conclusiones:
* Random Forest es robusto frente a outliers y ruido.
* Provee buenos estimadores de error (oob_score) e importancia de variables
* Entrenar muchos árboles puede llevar mucho tiempo, pero es fácilmente paralelizable.
* No funciona bien con conjuntos pequeños de datos.

Enlaces recomendados:
* https://medium.com/ml-research-lab/ensemble-learning-the-heart-of-machine-learning-b4f59a5f9777
* https://becominghuman.ai/ensemble-learning-bagging-and-boosting-d20f38be9b1e
* https://www.aprendemachinelearning.com/random-forest-el-poder-del-ensamble/

## Ensambles – Boosting

Se entrena una secuencia de modelos donde se da más peso a los ejemplos que fueron clasificados erróneamente por iteraciones anteriores. 
Al igual que con bagging, las tareas de clasificación se resuelven con una mayoría ponderada de votos, y las tareas de regresión se resuelven con una suma ponderada para producir la predicción final.

<img src="../_src/assets/ensambles_boosting.jpg" height="600"><br>

Ejemplo: Se plantea un problema de clasificación binaria con 10 elementos de entrenamiento, 5 positivos y 5 negativos:
El algoritmo va a iterar hasta lograr una separación aceptable de las clases…<br>
<img src="../_src/assets/ensambles_boosting1.jpg" height="300"><br>
El primer clasificador débil, genera una recta vertical. A la derecha de la recta, se considera que todos los ejemplos son negativos, mientras que a la izquierda son positivos. 
La recta clasifica mal a tres positivos.<br>
<img src="../_src/assets/ensambles_boosting2.jpg" height="300"><br>
Ahora los tres ejemplos mal clasificados aparecen de un mayor tamaño que el resto de los ejemplos. 
Esto simboliza que dichos ejemplos tendrán una mayor importancia al momento de seleccionar el clasificador débil de la segunda iteración.<br>
<img src="../_src/assets/ensambles_boosting3.jpg" height="300"><br>
El segundo clasificador débil, es otra recta vertical colocada más hacia la derecha, se equivoca también en tres ejemplos, ya que clasifica mal ejemplos negativos. <br>
<img src="../_src/assets/ensambles_boosting4.jpg" height="300"><br>
Para la tercera iteración los ejemplos negativos mal clasificados tienen ahora el mayor tamaño, es decir, tendrán mayor importancia en la siguiente iteración.<br>
<img src="../_src/assets/ensambles_boosting5.jpg" height="300"><br>
En la tercera iteración el clasificador débil resultante es una recta horizontal, como se puede observar en el cuadro de la derecha. 
Este clasificador se equivoca en la clasificación de un ejemplo negativo y dos positivos, que de igual forma aparecen encerrados en un círculo.<br>
<img src="../_src/assets/ensambles_boosting6.jpg" height="300"><br>
Finalmente, se ilustra el clasificador fuerte que resulta de crear un ensamble con tres clasificadores débiles. La forma en que se utilizan estos tres clasificadores débiles es mediante una decisión por mayoría. 
Al clasificar un nuevo ejemplo, le preguntamos a cada uno de los tres clasificadores débiles su opinión. Si la mayoría opina que el nuevo ejemplo es positivo, pues entonces la decisión del clasificador fuerte será que es un ejemplo positivo. <br>
<img src="../_src/assets/ensambles_boosting7.jpg" height="300"><br>

### Ensambles – XG Boost, Extreme Gradient Boosting

* XGBoost es un algoritmo que recientemente ha dominado el aprendizaje automático y sobre todo las competiciones de Kaggle (para datos estructurados). 
* XGBoost es una implementación de árboles de decisión potenciados por el algoritmo de descenso por gradiente, diseñado para aumentar la velocidad y mejorar el rendimiento.
* XGBoost es una librería de software que se puede descargar e instalar y luego acceder desde una variedad de interfaces: CLI, C++, Python, R, Julia, etc.
* No sólo tiene buena performance computacional, también posee un muy buen desempeño con el manejo de los datos.

Características principales:
* Paralelización de la construcción de árboles utilizando todos los núcleos de la CPU durante el entrenamiento.
* Computación distribuida para el entrenamiento de modelos muy grandes utilizando clusters de máquinas.
* Computación "fuera de núcleo" para conjuntos de datos muy grandes que no caben en la memoria.
* Optimización de caché de estructuras de datos y algoritmos para aprovechar al máximo el hardware.

Instalación: sudo pip install xgboost

Ejemplos: https://github.com/tqchen/xgboost/tree/master/demo/guide-python<br>

<img src="../_src/assets/ensambles_boosting8.jpg" height="200"><br>

## Ensambles – Bagging vs. Boosting

| Bagging | Boosting  |
| :------ | -------:  |
| Modelos entrenados de manera independiente. | Bastantes modelos entrenados enfocados en mejorar las fallas de los anteriores. |
| Resuelve promediando los N modelos. | Promedio pesado de los N modelos (su peso depende de su performance). |
| Enfocado en <b>reducir la Varianza</b>. Ayuda a prevenir overfitting. | Enfocado en <b>reducir el Sesgo</b>. En casos puede causar overfitting.  |
| Se suele usar con modelos de bajo Sesgo y alta varianza.  | Se suele usar con modelos de baja varianza y alto sesgo.  |
| Fácilmente paralelizable. | No se puede paralelizar fácilmente. |

Enlaces recomendados:
* https://machinelearningmastery.com/gentle-introduction-xgboost-applied-machine-learning/
* https://towardsdatascience.com/understanding-random-forest-58381e0602d2
* https://towardsdatascience.com/ensemble-methods-bagging-boosting-and-stacking-c9214a10a205

## Ensambles – Stacking

Se crea una función de ensamble que combina los resultados de varios modelos base, en uno sólo. 
Los modelos de nivel de base se entrenan con un conjunto de datos completo, y luego sus salidas se utilizan como características de entrada para entrenar una función de ensamble. 
Normalmente, la función de ensamble es una simple combinación lineal de las puntuaciones del modelo base.

<img src="../_src/assets/ensambles_stacking.jpg" height="500"><br>

## Ensambles - Voiting Classifier

Utilizando las predicciones de múltiples clasificadores, se hace predicciones basadas en el más frecuente. 
El hiperparámetro “estimadores” crea una lista para los objetos clasificadores asignándoles nombres. 
El hiperparámetro “votación” se establece en estricto (duro) o no estricto (blando).
Si se establece en estricto, el clasificador de votaciones emitirá juicios basados ​​en las predicciones que aparezcan con mayor frecuencia. De lo contrario, si se establece en no estricto, utilizará un enfoque ponderado para tomar su decisión.
Por ejemplo, se puede configurar en suave cuando se usa un número par de clasificadores debido a su enfoque ponderado y configurarlo en difícil cuando se usa un número impar de clasificadores debido a su enfoque de “mayoría lleva el voto”.

<img src="../_src/assets/ensambles_voiting.jpg" height="300"><br>

## Homework

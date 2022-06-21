![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

# Big Data

La era de los Datos.

<img src="../_src/assets/LaEraDeLosDatos.jpg"  height="400">

Es un término que hace referencia a una nueva clase de datos que no pueden ser gestionados por sistemas tradicionales.


### 3V’s de Big Data

* Volumen
* Variedad
* Velocidad

<img src="../_src/assets/BigData.jpg"  height="400">

### Casos de Uso

<img src="../_src/assets/CasosDeUso.jpg"  height="400">

### Data Lake

* Es un repositorio unificado de datos, estructurados y no estructurados.
* Está diseñado soportar las cargas de trabajo de Big Data y Machine Learning.
* Prioriza el almacenamiento de los datos en su formato original para luego ser procesados de acuerdo a la demanda.

<img src="../_src/assets/DataLake.jpg"  height="400">

### Estrategia de Procesamiento

<img src="../_src/assets/EstrategiaProcesamiento.jpg"  height="400">

### Arquitectura

<img src="../_src/assets/Arquitectura.jpg"  height="400">

## Hadoop

Es un sistema open-source diseñado para almacenar y procesar Big Data de forma distribuida utilizando un cluster de servidores.

### Características:
* Tolerancia a Fallos.
* Escalabilidad Horizontal.
* Utiliza commodity hardware.
* Desarrollado en lenguaje Java.
* Procesamiento en paralelo.

- [Sitio Oficial](https://hadoop.apache.org/)

### Ecosistema Hadoop

<img src="../_src/assets/Ecosistema_Hadoop.jpg"  height="400">

## Cluster Hadoop

<img src="../_src/assets/Cluster_Hadoop.jpg"  height="400">

## Componentes Core

### HDFS (Hadoop Distributed File System)

<img src="../_src/assets/HDFS.jpg"  height="100">

Master -> NameNode
Worker -> DataNode

Hadoop permite organizar computadoras en una relación maestro – esclavo que contribuye a conseguir una gran escalabilidad para el procesamiento.

Un Cluster Hadoop tiene dos tipos de nodos, un único “Master Node” llamado NameNode y un gran número de “Workers Nodes” llamados DataNodes.

<img src="../_src/assets/Hadoop_Nodes.jpg"  height="200">

El Masternode administra el sistema de archivos, su “namespace” y controla el acceso a los archivos por los clientes, conociendo qué bloques de qué archivos están en cada DataNode.
Un único MasterNode implica la necesidad de “Hot backups” para mantener la disponibilidad del servicio.

El MasterNode usa un log de transacciones para mantener un registro de cada cambio que ocurre en el sistema de archivos.

Los DataNodes almacenan los bloques de datos en el espacio de almacenamiento dirigidos por el MasterNode.

Cada DataNode típicamente contiene muchos discos para maximizar la capacidad de almacenamiento y la velocidad de acceso, y tienen su propio sistema de archivos local.
Los DataNodes almacenan y distribuyen bloques de datos sobre la red usando un protocolo de bloques, gestionado por el DataNode.

Los NameNodes almacenan toda la información relevante acerca de todos los DataNodes, y los archivos almacenados en los DataNodes:

* Para cada DataNode, su nombre, rack, capacidad y estado.
* Para cada archivo, su nombre, réplicas, tipo, tamaño, "timeStamp", ubicación, estado.

El NameNode trata de asegurar que los archivos se distribuyan de forma pareja entre los DataNodes del clúster, también optimiza el ancho de banda y balancea la carga de procesamiento y almacenamiento.

Cada pieza de datos es almacenado típicamente en tres nodos, dos en el mismo rack y uno en un rack diferente.

Si un DataNode falla, éste puede ser recreado automáticamente en otra computadora, escribiéndose todos los bloques de archivos desde réplicas (otros DataNodes).

Los DataNodes se comunican por medio de mensajes ("heartbeats") para conocer el estado de los nodos. Sin ese mensaje se considera que el nodo ha fallado, y la replicación automáticamente reemplaza el nodo fallido.

En el Sistema de Bloques ("block system"), un bloque es la unidad fundamental de almacenamiento en HDFS. Se almacena la información de grandes archivos distribuyendo segmentos llamados bloques para ser almacenados en diferentes computadoras.
El tamaño predeterminado de los bloques es de 64 o 128 MB dependiendo de la distribución:

hdfs getconf -confKey dfs.blocksize

Cada archivo de datos ocupa un determinado número de bloques, dependiendo de su tamaño y organizado en bloques consecutivos, para facilidad y velocidad de acceso.
El tamaño de bloques y el factor de replicación puede ser configurado según se requiera.

Respecto de la Integridad de los datos, Hadoop asegura que no habrá pérdida o corrupción de datos durante el procesamiento y almacenamiento.

Los datos son escritos sólo una vez y nunca actualizados en el lugar, pueden ser leídos muchas veces.

Sólo un cliente a la vez puede escribir o agregar datos al archivo, no se permiten actualizaciones concurrentes.

Si algunos datos en un DataNode se pierden o corrompen, o hay una falla en el disco que los contiene, una nueva réplica en buen estado es recreada automáticamente desde una réplica en otro DataNode. Al menos una réplica es almacenada en un DataNode en un rack diferente.

Los archivos de entrada pueden variar desde pequeños a extremadamente grandes y con diferentes estructuras.

Los archivos secuenciales ("secuence files") son una estructura especializada de datos dentro de Hadoop para manejar pequeños archivos en registros pequeños.

Utilizan una estructura de datos persistentes HDFS y MapReduce están diseñados para gestionar archivos de gran tamaño, de manera que "empaquetar“ archivos pequeños en archivos secuenciales hace más eficiente su procesamiento y almacenamiento.

#### Ejemplo de escritura en HDFS

<img src="../_src/assets/Escritura_HDFS.jpg"  height="400">

### YARN (Yet Another Resource Negotiator)

<img src="../_src/assets/YARN.jpg"  height="100">

Master -> ResourceManager
Worker -> NodeManager

Es el centro de la arquitectura de Hadoop, caracterizado como un sistema Operativo distribuido para aplicaciones de Big Data.

YARN administra recursos y "workloads" en un entorno seguro mientras asegura la alta disponibilidad en múltiples clusters Hadoop.

YARN brinda flexibilidad como una plataforma común para ejecutar múltiples aplicaciones y herramientas, de consultas interactivas SQL (Hive), de proceso de flujos en tiempo real (Spark), y procesamiento por lotes (MapReduce) para trabajar con los datos almacenados en una plataforma HDFS.

Brinda gran escalabilidad para expandirse más allá de 1000 nodos y provee ubicación dinámica de recursos del clúster.

#### Ejemplo de ejecución de Jobs en YARN

<img src="../_src/assets/Ejemplo_YARN.jpg"  height="400">

- [YARN] (https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/YARN.html)

## MapReduce

Permite procesar enormes cantidades de datos utilizando los servicios de gran cantidad de computadoras para trabajar en diferentes partes del trabajo ("job") simultáneamente, brindando capacidad de procesamiento en paralelo y tolerancia a fallos.

La tarea de procesamiento de los datos se divide en muchas partes, cada una procesada de forma independiente de las otras y luego los resultados intermedios se combinan en el resultado final.

MapReduce es un "framework" de procesamiento paralelo para acelerar el procesamiento de datos a gran escala, con un mínimo movimiento de los dados en el sistema de archivos distribuido del clúster Hadoop, obteniendo resultados cercanos al tiempo real.

- [MapReduce] (https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html)


<img src="../_src/assets/Ejemplo_MapReduce.jpg"  height="400">

La función map(): se encarga del mapeo y es aplicada en paralelo para cada ítem en
la entrada de datos. Esto produce una lista de pares (k2,v2) por cada llamada.

Luego el se juntan todos los pares con la misma clave de todas las listas y los agrupa, creando un grupo por cada una de las diferentes claves generadas.

Desde el punto de vista de la arquitectura, el nodo master toma el input, lo divide en
pequeñas piezas o problemas de menor identidad, y los distribuye a los denominados
"worker nodes".

Un "worker node" puede volver a sub-dividir, dando lugar a una estructura de árbol.

El "worker node" procesa el problema y pasa la respuesta al nodo maestro "master node".

La función reduce es aplicada en paralelo para cada grupo, produciendo una colección
de valores para cada dominio:

Reduce(k2, list (v2)) -> list(v3)

Típicamente se produce un valor v3 o una llamada vacía, aunque una llamada puede retornar más de un valor. El retorno de todas esas llamadas se recoge como la lista de resultado deseado.

Por lo tanto, el framework MapReduce transforma una lista de pares (clave, valor) en una lista de valores.

## Instalación Hadoop

Se puede instalar Hadoop en un clúster de computadoras "on premise" o utilizar servicios en la nube: Azure, IBMCloud, AWS.
Requiere una instalación de Java y está escrito en ese lenguaje.
Para instalaciones locales es útil contar con una interfaz gráfica como Cloudera Resouces Manager que permite la instalación de Hadoop y componentes relacionados, como YARN, HBase, Pig.
Si se instala desde la línea de comandos, se debe descargar Hadoop de algunos de
los "mirrors" de Apache. 
La instalación en la nube es más sencilla que instalar Java Virtual Machines en computadoras locales.
HDFS tiene una interfase de línea de comandos "UNIX-like".
Use el "shell" sh para comunicarse con Hadoop.

## Homework

1) Realizar la instalación de VirtualBox: https://www.virtualbox.org/wiki/Downloads
2) Realizar la instalación de Putty: https://www.putty.org/ - https://www.compuhoy.com/como-descargo-putty-en-linux/
3) Realizar la instalación de WinSCP: https://winscp.net/eng/download.php (FileZilla es una alternativa si no usas sistema operativo Windows)
4) En el archivo "Servidor_Ubuntu.zip" hay disponible un archivo VDI necesario para crear una máquina virtual Linux en VirtualBox. Esta máquina virtual es un servidor Ubuntu: <br> usuario: ubuntu <br>
contraseña: ubuntu <br>
Ya contiene una instalación de Docker. Por lo que a y b son opcionales:<br>
a) Instalación de Docker en tu sistema operativo: https://hub.docker.com/<br>
b) Si el sistema operativo usado es Linux: https://docs.docker.com/engine/install/<br>
    sudo apt install -y docker-compose<br>
5) Comenzar a familiarizarse con los comandos de Linux:<br>
[Tutorial] (https://www.tutorialspoint.com/unix_commands/index.htm)<br>
[Interactivo] (https://cli-boot.camp/?id=1dbj970vv4n)<br>
6) Una vez que tenemos todo funcionando, habiendo escogido cualquiera de las opciones ya podemos crear el cluster Hadoop siguiendo las siguientes instrucciones:<br>
6.1-Probemos la instalación de Docker: “sudo docker run hello-world”<br>
6.2-Descarguemos desde GitHub lo necesario para ejecutar el cluster:<br>
git clone https://github.com/soyHenry/DS-M4-Cluster_Hadoop<br>
6.3-Revisemos el archivo “start-container.sh”, los archivos dentro de la carpeta “config” y la URL “localhost:8088”. (Si usamos la máquina virtual, en lugar de localhost va la ip local de la misma)<br>
6.4-Finalmente sigamos las instrucciones propuestas para ver en funcionamiento HDFS y MapReduce sobre Hadoop.

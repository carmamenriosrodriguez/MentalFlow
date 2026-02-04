# Mentalflow: una app de bienestar basada en datos para la salud mental pública 

**Carmen Ríos Rodríguez**

## Objetivo 
Este proyecto desarrolla la infraestructura de datos para una plataforma de monitoreo preventivo, transformando métricas de comportamiento diario en indicadores accionables para la intervención temprana en salud mental. Queremos proponer una alternativa amable lejos de retención, métricas y beneficios económicos y solo analizando el comportamiento digital respecto a la salud mental podremos enfocarnos en la prevención y el cuidado de la salud mental en la ciudadanía. 
Entregamos un **análisis de correlacion entre comportamiento digital y salud mental** y **que dimensiones del comportamiento digital podemos relacionar con la salud mental** así como **dimensiones de enfoque para el cuidado y la intervención de nuestra app para con la ciudadanía.**


## Contexto de negocio 
En la última década, los problemas de salud mental han incrementado significativamente, convirtiéndose en una prioridad para empresas, gobiernos y plataformas digitales. Existe una creciente preocupación sobre cómo los hábitos diarios (como el tiempo en pantalla, el uso de redes sociales, el tiempo en pantalla o el aislamiento por lo digital) influyen en el estado emocional de las personas. 
Las instituciones de salud y las plataformas de bienestar a menudo carecen de herramientas integradas que correlacionen el comportamiento diario (datos transaccionales/digitales) con síntomas específicos de salud mental (depresión, ansiedad, ataques de pánico, soledad). Por ello, este proyecto nace de la necesidad de entender estos patrones mediante el procesamiento y análisis de grandes volúmenes de datos demográficos y de estilo de vida para generar recomendaciones o alertas tempranas.
Nuestro enfoque tiene que ver con el acceso público y gratuito de la ciudadanía a una alternativa sostenible y amable para con la salud mental, por lo que nos dirigimos a 
sistemas de gobierno y entidades públicas. 

## Dataset
**Fuentes**
1. Mental Health Dataset (mental_health.csv): Datos demográficos, clínicos y de estilo de vida de individuos a nivel global.
2. Instagram Scraping/Export (instagram_posts): Datos de comportamiento digital que incluyen visualizaciones, "likes" y tipos de contenido consumidos.
3. YouTube Data API: Información enriquecida sobre categorías de video, métricas de interacción y tendencias de contenido.

**Scope**
El alcance de este proyecto es la identificación de correlaciones entre el consumo de medios digitales y el bienestar psicológico. Se busca entender cómo variables externas (tiempo de pantalla, tipo de contenido) afectan variables internas (ansiedad, depresión, soledad, concentración y apoyo social).

**Tamaños**
- Dataset Principal (Mental Health): ~4000 registros con 37 variables. 
- Dataset Digital (Instagram): ~ 500000 registros con 35 variables.
- API Youtube: 14 registros (average de métricas) con 7 variables. 
- Base de Datos Final: Estructura relacional cargada en SQL con tablas normalizadas para análisis.

**Diccionario breve (datasets finales)**
- `Age / Gender / Country`: perfil demográfico del sujeto.
- `Screen_Time_Hours_Day`: total de horas de exposición a pantallas.
- `Has_Mental_Health_Issue`: variable binaria (0/1) que indica diagnóstico o síntoma presente.
- `Loneliness / Social_suport`: variable de escalabilidad para detectar sentimiento general. 
- `Duración_media`: Tiempo promedio de consumo de contenido digital convertido a minutos.

## Notas sobre la calidad del dato 
El proceso de limpieza reveló varios desafíos críticos que fueron abordados mediante ingeniería de datos:
1. Dataset mental_health.csv
- Consistencia de categorías: Se detectaron variaciones en campos de texto (ej. estados civiles o niveles educativos) que requirieron normalización para evitar duplicidad de categorías en el análisis.
- Integridad clínica: El dataset presenta un balance entre variables subjetivas (sentimientos) y objetivas (horas de sueño), lo cual es ideal pero propenso a sesgos de autoinforme (self-reporting bias).
2. Dataset de Instagram (IG)
- Formatos de tiempo: La mayor dificultad residió en la columna de duración de los posts, que venía en formatos inconsistentes (ISO 8601, ej. PT1M30S). Se implementó una función de Regex robusta para transformar estos strings en valores numéricos (segundos) y permitir cálculos matemáticos.
3. API de YouTube (YT)
- Métricas dinámicas: A diferencia del CSV estático, los datos de la API son volátiles (cambian en tiempo real). El script garantiza la captura de la "foto" del momento para mantener la trazabilidad.

## Hipótesis o preguntas clave
1. Análisis demográfico sobre comportamiento digital en instagram entre países por rango de edad y género: los casos de EEUU y GB.
2. Análisis demográfico sobre salud mental entre países por rango de edad y género: los casos de EEUU y GB.
3. ¿Existe correlación entre comportamiento digital y salud mental? 
    3.1. Análisis del usuario medio por género y edad en rrss
    3.2. El consumo pasivo vs. el aislamiento social: ¿A más tiempo en rrss, mayor sentimiento de soledad y menor sentimiento de comprensión?
    3.3. La falsa conexión social: ¿Se corresponde la tasa de interracciones y de seguidores/seguidos con el sentimiento de tener amigos y apoyo social?
    3.4. ¿Dónde se habla más (país) de salud mental en redes sociales?
        3.4.1. ¿Los usuarios que consumen vídeos de youtube con una duración media/corta muestran una mayor tendenca a la dificultad de concentrarse?
        3.4.2. En países donde el sentimiento de soledad es más alto, los vídeos sobre soledad son más visitados


## Proceso de análisis 
1. Obtención e importación de datos de nuestras diferentes fuentes. 
2. Obtención de Api key de youtube y consulta. 
3. Guardado de datos de Api en formato csv por la volatilidad de los datos y el cupo máximo por día. 
4. Limpieza individualizada de nuestros datos en la plataforma Visual Studio con Python.  
5. Conexión e importación a mySQL. 
6. Querys/llamadas de selección de datos según preguntas realizadas. 
7. Análisis de resultados. 

**Herramientas**
- Limpieza: Python (pandas) en `mental_health.ipynb`.
- Análisis: MySQL.
- Presentación: Canva. 

## Resultados
1. **En nuestro análisis demográfico sobre comportamiento digital:**
- Los usuarios de usa pasan, en promedio, más tiempo en la plataforma, sobre todo los jóvenes de 18-24 años. 
- Los reels consumen la mayor parte del tiempo, siendo EEUU el de mayor volumen de visualización sigificativamente mayor (unos 50 reeels más que un inglés promedio)
- Por norma general, el comportamiento de GB es más pasivo (ven más contenido que crean o con el que interactuan). 
- Entre jóvenes de 18 a 24 años la creación de contenido en EEUU (posts semanales) es casi el doble que en Inglaterra. Entre los siguientes dos segmentos (35-54) las métricas se igualan, pero en el de Adultos Mayores (55-65) el grupo británico es muy activo que, siendo aun menor que el de USA, es el segmento líder de Inglaterra. 
- Respecto al consumo de publicidad mediante redes sociales, ambos países tienen un ratio ads-vistos, ads-clickados similar. Sin embargo, al ser Inglaterra el país de uso de rrss de manera más pasiva podemos inferir que los anuncios pueden afectar más a este país. 

2. **En nuestro análisis demográfico sobre salud mental entre países por rango de edad y género:**
- En GB los niveles de soporte social y sentirse comprendidos son moderados (5-6), pero sí que existe una tendencia a sentirse solos (sobre el 5). Además en los grupos más jóvenes se observa una alta dificultad de concentración respecto a otros rangos de edad, pero son los que menos pinsan en autolesión o suicidio. La tendencia extrema más desoladora es que el grupo de mayor edad (55-65) alcanzan casi un 9 en sentimiento de soledad. 
- EN EEUU se reportan niveles ligeramente más altos de cambios de humor, irritabilidad y pensamientos obsesivos compulsivos. Además, los adultos jóvenes (18-24) aunque muestran un buen conteo de media sobre apoyo social y amistades, a menudo se sienten insuficientes (rondando los 7 puntos de media). 
- Respecto a géneros, las mujeres suelen reportar niveles más altos de dificultad para concentrarse y cambios de humor, peor a penas se sienten comprendidas o apoyadas. Los hombres, por otra parte, presentan niveles de soledad muy elevados (llegando al 8). En cuanto a personas No Binarias, tienden a mostrar pensamientos obsesivos, sentirse insuficientes y solos. 
- En general, los adultos entre 35 y 44 años son el grupo que presenta mayor estabilidad entre las diferentes métricas aunque con una carga de sentirse insufiientes (6). 

3. **¿Existe correlación entre comportamiento digital y salud mental?**
- Los datos muestran una curva clara: a mayor tiempo de uso, mayores son los indicadores de malestar, especialmente entre los jóvenes. 
- En cuando a edades, los jóvenes (18-24 años) tienen mayor consumo digital (casi 214 minutos al día) pero muestran índices graves de seoledad y de búsqueda de validación externa relaciona con la nota de sensación de insuficiencia. El siguiente grupo (35-44) mantienen un uso medio de 187 mins por día pero son los que sufren picos más altos de ataques de páinco (casi un 60% reportan sufrir ataques de pánico constantes en el año del análisis). Por último, el grupo de mediana edad (45-54) tiene el consumo más bajo de reels pero la tasa más alta de todos los grupos de sentirse insuficientes. 
- En el caso de las mujeres hay una tendencia clara a ver reels continuos, pero se sienten insuficientes e inseguras. Los hombres, tienen un uso similar en minutos totales a las mujeres pero mayor uso de reels (más de 150 al día por individuo) y el género que mayor solo se siente. Las personas No binarias, por otro lado, presentan los datos de pánico más altos (un 80% sufren ataques).
- Por países, los usuarios estadounidenses muestran una relación más directa entre minutos en IG y pánico. En GB se observa una nota de soledad ligeramente superior en los jóvenes británicos en comparación con sus pares estadounidenses. Sus tiempos de conexión casi idénticos.

    3.1. **Análisis del usuario medio por género y edad en rrss**
    - `TOP MÁXIMOS`: 1. Personas no binarias adultas (35-44), con una duración media por día de casi 4 horas. 2. Hombres adultos mayores (55-65) con una media de 3 horas y 40 minutos. 3. Juventud no binaria entre 18 y 24 años con un poco más de 3 horas y media al día de media. 
    - `TOP MÍNIMOS`: 1. El conjunto de mujeres con menos de 18 aós y más de 65 muestra un uso medio de 2 horas y cuarenta y cinco minutos. 2. Los adultos jóvenes de 25 a 34 años no binarios con casi 3 horas 3. Los hombres mayores de edad de menos de 24 con tres horas y cinco minutos de media por día. 
    - Podemos observar que, aun diferenciandose por grupos y por edades, el top máximo y el top mínimo solo tiene a penas una hora de diferencia. La media general de horas pasadas en la pantalla por usuario es de 3h y cuarto. 

    3.2. **El consumo pasivo vs. el aislamiento social: ¿A más tiempo en rrss, mayor sentimiento de soledad y menor sentimiento de comprensión?**
    - Los grupos con mayor consumo de contenido (Jóvenes 18-24 de ambos sexos con 5.81 horas) presentan niveles de soledad elevados (entre 5.49 y 5.52). Sin embargo, el pico de soledad lo tienen las mujeres de 35-44 años (5.55), a pesar de tener un consumo moderado (4.21h). Esto sugiere que en adultos la soledad puede estar ligada a otros factores externos al tiempo de pantalla.
    - Curiosamente, el grupo que más tiempo consume (Mujeres -18 o +65 con 5.91h) es el que reporta sentirse más comprendido (5.69).
    - Hay una correlación negativa clara: A mayor número de horas vistas, menor es la capacidad de concentración. Quienes ven menos de 4 horas (adultos mayores de 55) mantienen niveles de concentración más estables que los jóvenes con alto consumo.

    3.3. **La falsa conexión social: ¿Se corresponde la tasa de interracciones y de seguidores/seguidos con el sentimiento de tener amigos y apoyo social?**
    - En todos los géneros, la juventud de entre 18 y 24 años tienen los niveles más altos de seguidores/seguidos (casi 5700 por usuario) y de interacciones medias (170 al día). Sin embargo, a pesar de ser los más activoos, sus niveles de sentimiento de apoyo social y amigos son menores que los grupos con menos actividad digital. Dicho de otro modo, a pesar de estar más conectados eso no se traduce en mayor sensación de conectividad en la vida real.
    - Los grupos medio (24-54) sí que el ratio conectividad digital-conectividad real está compensada. 
    - Si observamos el caso de los adultos mayores (55-65) existe la baja intensidad de interacciones y de seguidores/seguidos, pero una gran satisfacción en apoyo social. Esto parece indicar que realmente el comportamineto digital que nos vincula al resto no nos vincula en la vida real y que la satisfacción en apoyo social no parece tener correlación a mayor interacción sino, más bien, todo lo contrario. 

    3.4. **¿Dónde se habla más (país) de salud mental en redes sociales?**
    - Estados Unidos lidera en la intensidad del interés y el consumo real. La 'ansiedad' como tema genera mas de 85 millones de vistas en el top 50 de los vídeos, mientras que en GB esa misma categoria tiene unas 16 millones de visitas. Además el engagement (comentarios, likes, compartidos) es significativamente más alto en vídeos cuyo títul incluyan las palabras 'ansiedad' o 'depresión'. Después de ello, muy cerca de los 80 millones de visitas, los vídeos que tratan sobre sentirse comprendidos. 
    - En GB el tema con más visitas y engagement es a soledad (lonlines) con más de 96 millones de visitas. 
    - Es interesante notar que la adicción a las redes sociales tiene la duración media de video más alta en ambos países (entre 24 y 25 minutos). Esto indica que, independientemente del país, cuando se habla de este tema, se prefiere un contenido mucho más profundo y extenso que los clips rápidos de otros trastornos.

        3.4.1. **¿Los usuarios que consumen vídeos de youtube con una duración media/corta muestran una mayor tendenca a la dificultad de concentrarse?**
        - La nota media de los usuarios en USA que sienten dificultad para concentrarse es de un 5,03. Cuando deciden buscar vídeos en Youtube con la temática "loss of attention" la duración media es de 4 minutos, lo que indica que, precisamente, buscan esos vídeos cortos y esos estímulos incluso cuando buscan sobre ello. 
        - En Inglaterra la nota no llega al 5 (4,8) y los vídeos que buscan son de una misma duración media (sobre los 4 minutos).

        3.4.2. **En países donde el sentimiento de soledad es más alto, los vídeos sobre soledad son más visitados.**
        - Reino Unido tiene un índice de sentimiento de soledad ligeramente superior (5.49 vs 5.40) y muestra un volumen de visitas masivamente superior (casi 8 veces mayor) en comparación con EEUU. Lo que parece indicar que existe una relación directa: a mayor sentimiento de soledad reportado, mayor es el interés por consumir vídeos sobre el tema.

        3.4.3. **Los usuarios de países con una duracion_media de video nacional más alta tienden a tener sesiones individuales más largas pero una menor tasa de creación de contenido propio.**
        - USA tiene una duración de video significativamente mayor (10.13 minutos por vídeo). Sin embargo, la duración del video no está afectando en absoluto a la frecuencia de posteo; los usuarios crean la misma cantidad de contenido independientemente de si los videos nacionales son más largos o cortos. La duración del video parece retener a los usuarios un poco más de tiempo en la aplicación (más tiempo de consumo), pero no parece canibalizar ni desincentivar la creación de contenido, ya que la tasa de publicación se mantiene constante. 
    

## Interpretación y recomendaciones 
Los hallazgos de este informe confirman que el bienestar emocional de la ciudadanía está intrínsecamente ligado a la arquitectura del consumo digital: mientras que en EE.UU. el malestar se manifiesta en picos de ataques de pánico (60%) vinculados al uso intensivo de Reels, en el Reino Unido la problemática se desplaza hacia una soledad crónica que afecta drásticamente a los adultos mayores (puntuación de 9/10). Resulta alarmante que los jóvenes de 18-24 años, a pesar de poseer las métricas de interconectividad más altas (5,700 seguidores de media), reporten los niveles más bajos de apoyo social real, lo que evidencia una 'falsa conexión social' que el mercado actual no está resolviendo. Por ello, se recomienda que Mentalflow se posicione no solo como una herramienta de monitoreo, sino como un interventor de hábitos: es imperativo implementar funciones de 'alfabetización algorítmica' y alertas de consumo pasivo, transformando la tendencia detectada de buscar vídeos cortos sobre falta de atención en sesiones de enfoque guiado. Nuestra recomendación estratégica es priorizar el desarrollo de módulos de apoyo comunitario real para el segmento senior en GB y protocolos de gestión de ansiedad digital para jóvenes en EEUU, convirtiendo el dato transaccional en una política pública de salud mental sostenible y proactiva.
Si bien Estados Unidos presenta volúmenes de consumo y ataques de pánico más altos, Reino Unido presenta los indicadores de "necesidad social desatendida" más críticos para una intervención de salud pública. Mientras que en EEUU. el problema es de intensidad y pánico (más transaccional), en el Reino Unido es de aislamiento y pasividad (más estructural). Priorizamos GB porque los datos revelan una población que busca ayuda masivamente en plataformas digitales pero que reporta los niveles más bajos de soporte social real, especialmente en el segmento senior, lo que garantiza un mayor retorno social. 

## Limitaciones y próximos pasos 
- No podemos inferir de manera 100% objetiva porque las fuentes de datos están obtenidas en el mismo año pero no a los mismos usuarios y una cuenta con muchos más registros que otra. 
- Podríamos hacer un análisis más amplio si tuvieramos datos similares de otros años, lo qeue daría uan prespectiva de evolución. 
- Debido al tiempo limitado del estudio, no se ha podido obtener toda la información máxima por la cantidad enorme de variables. Por ello, el material ofrece mucho más contexto de métricas específicas que sería útil analizar para próximos estudios. 

## Cómo replicar el proyecto
Instrucciones exactas (entorno, dependencias, y orden recomendado):
- Descargas de archivos `mental_health.csv` y archivo `instagram_users_lifestyle.csv`
- Petición de Api a Youtube: https://developers.google.com/youtube/v3/docs?hl=es-419#call-the-api. 
- Llamada y obtención de datos de la API. 
- Guardado en archivo csv los datos consultados a través de la api. 
- Creación de Script de SQL: creación de base de datos. 
- Ejecución de archivo `functions.py`. 
- Importación de las funciones en notebook. 
- Introudcción de Api Key en el apartado de API. 
- Notebook de exploración inicial y limpieza: `mental_health.ipynb`: pulsar `Run all`, introducir contraseña de conexión a mySQL.
- En el Script de SQL: `mental_sql.sql`: seguir instrucciones y ejecutar querys. 
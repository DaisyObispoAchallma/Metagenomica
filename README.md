# README
### Daisy Obispo, 2020
#### Análisis de datos metagenómicos generados por la plataforma Miseq (Illumina)

Este es un repositorio para análisis de la región ITS2 (hongos) para estudios metagenómicos. Los datos provienen de la plataforma de secuenciación Illumina. 

El repositorio contiene la siguiente estructura:

**`/bin`**: Esta carpeta contiene los archivos ejecutables para el análisis metagenómico. 

* `bin/MetaGen.sh` : es el script en bash que contiene un flujo de trabajo usando el programa [AMPtk](https://amptk.readthedocs.io/en/latest/pre-processing.html?highlight=padding)

* `bin/plots_MetaGen.Rmd` : es el script en R Markdown que contiene los análisis estadísticos del archivo `taxonomy.biom`, obtenido ejecutando el script anterior. 

**`/data`**: Esta carpeta contiene el archivo `taxonomy.biom` obtenido como output de la ejecución del script.

*`data/taxonomy.biom` : es el archivo obtenido al ejecutar `MetaGen.sh` , el cúal contiene información que agrupa la tabla de OTUs, tabla de taxonomiía y la tabla de las muestras en un solo documento de formato `.biom`

*`data/metagenomics.html` : es el informe del análisis estadísticos obtenido al ejecutar el script `plots_MetaGen.Rmd` 

##### Interpretación de los resultados

#####Descripción del análisis ejecutado por `MetaGen.sh`:

Se evaluó el párametro min_len dentro de la herramienta AMPtk, que corresponde a remover secuencias con longitud mínima, se aplicaron valores de 200 y 300 bp. Usando `min_len 200` se identificaron taxónomicamente 1257 OTUs y con el párametro de `min_len 300` se identificaron 329 OTUs.
Estos resultados demuestran que al relajar el valor de `min_len 200` se recupera mayor cantidad de OTUs, siendo determinante para un posterior análisis y además de considerar valores basados en calidades no tan exigentes. Se debe de realizar la elección del párametro evaluado de manera óptima y teniendo en cuenta los criterios de calidad adecuados para obtener secuencias de mayor tamaño y con alta confianza de la asignación taxónomica de los OTUs. Sin embargo, al usar párametros más estrictos como `min_len 300` se corre el riesgo de perder información contrarrestando con una mayor calidad. 

#####Descripción del análisis ejecutado por `plot_MetaGen.Rmd`:

Se obtuvó un número total de 1257 OTUs en 12 muestras de suelo rizosférico recolectados en sitios de bosque nativo (N) y mixto (M) de Quercus (Q) y de Juniperus (J). En el análisis de diversidad alfa (ver Figura 1, en metagenomics.html), se obsservo que el *Phylum* predominante fue de *Ascomycota*, seguido por *Basidiomycota* y *Blastocladiomycota* , teniendo un patrón similar en Quercus y Juniperus, además se visualiza que en *Juniperus* existe una mayor abundancia de OTUs, y dentro de este grupo los bosques nativos tienen más abundancia que los mixtos. Al realizar el test de ANOVA, no se encontraron diferencias significativas de la abundacia observada en relación con el hospedero y el tratamiento.

En el análisis de diversidad beta, al aplicar la ordenación `NMDS` se obtuvo un nivel de estrés de 0.13, lo cuál indico que existen diferencias entre las muestras dependiendo de los OTUs que comparten. Se visualizó la ordenación del hospedero y tratamiento (ver Figura 4, en metagenomics.html), en donde las muestras de bosque nativo muestran cierta agrupación según tipo de hospedero. Luego de aplicar el test de ADONIS, no se encontro evidencia significativa evaluando hospedero y tratamiento de manera independiente, sin embargo, al realizar el test para ambas variables y ver la interacción entre ellas, se demostro que existe evidencia significativa (p <0.05).

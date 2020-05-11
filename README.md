# README
### Daisy Obispo, 2020
#### Análisis de datos metagenómicos generados por la plataforma Miseq (Illumina)

Este es un repositorio para análisis de la región ITS2 (hongos) para estudios metagenómicos. Los datos provienen de la plataforma de secuenciación Illumina. 

El repositorio contiene la siguiente estructura:

**`/bin`**: Esta carpeta contiene el script `MetaGen.sh` utilizado para el análisis metagenómico. El script contiene un flujo de trabajo usando el programa [AMPtk](https://amptk.readthedocs.io/en/latest/pre-processing.html?highlight=padding)

**`/data`**: Esta carpeta contiene el archivo `taxonomy.biom` obtenido como output de la ejecución del script.

##### NOTA:
Se evaluó el párametro `min_len` dentro de la herramienta AMPtk, que corresponde a remover secuencias con longitud mínima, se aplicaron valores de 200 y 300 bp. Usando `min_len 200` se identificaron taxónomicamente 1257 OTUs y con el párametro de `min_len 300` se identificaron 329 OTUs. 

Estos resultados demuestran que al relajar el valor de `min_len` se recupera mayor cantidad de OTUs, siendo determinante para un posterior análisis y además de considerar valores basados en calidades no tan exigentes, corriendo el riesgo de poder tener menor confianza de los datos. Se debe de realizar la elección del párametro evaluado de manera óptima y teniendo en cuenta los criterios de calidad adecuados para obtener secuencias de mayor tamaño y con alta confianza de la asignación taxónomica de los OTUs.

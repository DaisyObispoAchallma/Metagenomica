# Metagenomica
### Daisy Obispo, 2020
#### Pipeline bioinformático para procesamiento de datos metagenómicos generados por la plataforma Miseq (Illumina)

Este es un repositorio para análisis de la región ITS2 (hongos) para estudios metagenómicos. Los datos provienen de la plataforma de secuenciación Illumina. 

El repositorio contiene la siguiente estructura:

**`/bin`**: Esta carpeta contiene el script `MetaGen.sh` utilizado para el análisis metagenómico. El script contiene un flujo de trabajo usando el programa [AMPtk](https://amptk.readthedocs.io/en/latest/pre-processing.html?highlight=padding)

**`/data`**: Esta carpeta contiene el archivo `taxonomy.biom` obtenido como output de la ejecución del script, el cual corresponde a la tabla de OTU con asignación taxonómica.

##### NOTA:
Se evaluó el párametro `min_len` dentro de la herramienta AMPtk, que corresponde a remover secuencias con longitud mínima, se aplicaron valores de 200 y 300 bp. 

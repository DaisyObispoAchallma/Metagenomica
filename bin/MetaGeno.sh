#!/bin/bash

#------------------------------------------------------------------------
#  Project: Metagenomica
#  Author:  Daisy Obispo Achallma
#  Date:    May, 2020
##-----------------------------------------------------------------------

#Análisis de datos metagenómicos generados por la plataforma Miseq (Illumina)

#**Información**
#Este script escrito en "bash" fue diseñado y ejecutado en el servidor CONABIO. 
#El análisis bioinformático fue con la herramienta AMPTK.
#Se realizó la secuenciación metagenómica de la región ITS2 (hongos) de 24 muestras de suelo rizosférico.
#recolectados en sitios de bosque nativo (N) y mixto (M) de Quercus (Q) y de Juniperus (J).
#Para cada muestra tenemos dos archivo fastq, correspondiente a las secuencias forward (R1) y reverse (R2).
#El rawdata se encuentra depositado en el servidor de CONABIO, dentro del directorio "$HOME/metagenomica/fastq". 
#Desde el directorio personal "$HOME/dobispo", se trabajará con el análisis de los datos .

#**Procesamiento de los datos** 

#*Step_1. Preprocesamiento de archivos FASTQ*
#Consiste en ensamblar los reads R1 y R2, además de eliminar los primers y secuencias cortas (mínimo de 200 bp)

amptk illumina -i ../metagenomica/fastq -o amptk/ -f GTGARTCATCRARTYTTTG -r CCTSCSCTTANTDATATGC -l 300 --min_len 200 --full_length --cleanup

##Se usarón los siguientes párametros:
#-i, carpeta de entrada con los archivos fastq 
#-o, Nombre del archivo de salida 
#-f, secuencia del primer forward "gITS7ngs"
#-r, secuencia del primer reverse "ITS4ngsUni"
#-l, longitud de las lecturas (300 bp)
#--min_len, longitud mínima para conservar una secuencia (200 bp)
#--full_length, conservar únicamente secuencias completas
#--cleanup, eliminar archivos intermediarios  

#*Step_2. Agrupamiento con 97% de similitud usando UPARSE*
#Consiste en realizar un filtro de calidad (incluyendo secuencias quiméricas) y agrupar las secuencias en OTUs

amptk cluster -i amptk.demux.fq.gz -o cluster -m 2 --uchime_ref ITS

##Se usarón los siguientes párametros:
#-i, archivo de entrada con las secuencias alineadas 
#-o, Nombre del archivo de salida
#-m, Número mínimo de lecturas para que una OTU validad sea retenida (filtro singleton) 
#--uchime_ref, Filtrado de quimeras (ITS)

#*Step_3. Filtrado de la tabla de OTUs "index bleed"*
#Consiste en filtrar las lecturas asignadas a la muestra incorrecta durante la secuenciación de Illumina, usando el término "Index bleed". 
#Este error es frecuente, además de tener un grado variable entre varias corridas. Para minimizar, se puede usar un control positivo (mock) artificial para medir el grado de index bleed dentro de una corrida. Si la corrida no incluyó un mock artificial, este umbral se puede definir manualmente (en general se usa 0,005%).

amptk filter -i cluster.otu_table.txt -o filter -f cluster.cluster.otus.fa -p 0.005 --min_reads_otu 2

##Se usarón los siguientes párametros:
#-i, archivo de entrada "Tabla de OTU"
#-o, Nombre de archivo de salida 
#-f, Archivo fasta con secuencias de referencia para cada OTU
#-p, % porcentaje umbral de index bleed entre las muestras 
#--min_reads_otu, número mínimo de lecturas para que una OTU valida sea retenida (filtro singleton)

#*Step_4. Asignación taxonómica a cada OTU*
#La herrammienta AMPtk utiliza la base de datos de secuencias de [UNITE] (https://unite.ut.ee/) para asignar la taxonomía de los OTUs. 

amptk taxonomy -i filter.final.txt -o taxonomy -f filter.filtered.otus.fa -m ../metagenomica/amptk.mapping_file.txt -d ITS2 --tax_filter Fungi

##Se usarón los siguientes párametros:
#-i, archivo de entrada "Tabla de OTUs filtrada"
#-o, Nombre de archivo de salida 
#-f, archivo fasta con secuencias referencia para cada OTU 
#-m, archivo mapeado con meta-data asociados con las muestras 
#-d, base de datos preinstalada [ITS1, ITS2, ITS, 16S LSU, COI]
#--tax_filter, eliminación de las OTUs que no pasen el filtro. (solo Fungi)
 
#**El output final es una tabla de OTU perteneciente a hongos en formato "*.biom", el cuál se usará para hacer el análisis de diversidad. Esta tabla contiene frecuencia por muestra, taxonomía, y los meta-datos asociados a cada muestra.


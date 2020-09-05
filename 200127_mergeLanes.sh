#!/bin/bash
#script to merge lanes from a Nextseq run
#Made by Jonas N. Søndergaard
#Made on 200127

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 8:00:00

#run loop to merge lanes from individual samples
#Name.list is a text file with the names of the individual files
for i in {1..14}; do \
	FILE_NAME=`sed "${i}q;d" Name.list`
	
	cat *_S${i}_* > ${FILE_NAME}.fastq

	gzip ${FILE_NAME}.fastq
done

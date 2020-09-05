#!/bin/bash
#script to run FastQC on fastq files
#Made by Jonas N. Søndergaard
#Made on 200127

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 6:00:00
#SBATCH -J 200127_FastQC
#SBATCH --output=200127_FastQC.out
#SBATCH --error=200127_FastQC.err


#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load FastQC/0.11.5

#run FastQC
fastqc \
	/proj/FQfiles/CK*.fastq.gz \
	--outdir /proj/FastQC
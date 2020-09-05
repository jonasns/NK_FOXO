#!/bin/bash
#script made to count the number of reads aligned to genes and non-coding features in a reference genome file. 
#Made by Jonas N. Søndergaard
#Made on 200103

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 4:00:00
#SBATCH -J 200103_FeatureCounts
#SBATCH --output=200103_FeatureCounts.out
#SBATCH --error=200103_FeatureCounts.err

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load subread/2.0.0

#file paths
BAM_PATH=/proj/BAMfiles_sorted
OUTPUT_PATH=/proj/FeatureCounts
GTF_PATH=/proj/refgenomes

#run featureCounts
featureCounts \
	-t exon \
	-g gene_id \
	-s 2 \
	-T 2 \
	-p \
	-M \
	-O \
	--fraction \
	-C \
	-a ${GTF_PATH}/gencode.vM23.annotation.gtf \
	-o ${OUTPUT_PATH}/200203_EXP20CA6225_NK.readCount \
	${BAM_PATH}/*.bam \
	&> ${OUTPUT_PATH}/200203_EXP20CA6225_NK.readCount.log


#Readme
#-t: Specify feature type in GTF annotation. Here I chose exon, because on transcript level we might not get the lncRNAs
#-g: Specify attribute type in GTF annotation. Here we could chose e.g. transcript ID or gene ID. I chose gene ID, because I want to do DE analysis on gene level.
#-s: use '-s 2' if reversely stranded (as is the case for the Illumina Truseq library prep protocol)
#-T: Number of computational cores/threads used for the analysis
#-p: The experiment is paired end
#-M: Multi-mapping reads will also be counted. Each alignment will have 1 count or a fractional count if --fraction is specified
#-O: Allow reads that overlaps multiple features to be counted
#-C: If specified, the chimeric fragments (those fragments that have their two ends aligned to different chromosomes) will NOT be counted.
#-a: Name of the annotation file. Here it's gencode version M23.
#-o: output file name

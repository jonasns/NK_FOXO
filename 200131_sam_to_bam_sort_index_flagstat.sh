#!/bin/bash
#script used for converting sam files to bam files and subsequently sort and index the bam files.
#Made by Jonas N. Søndergaard
#Made on 200130 

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 16:00:00
#SBATCH -J 200131_sam_to_bam_sort_index_flagstat
#SBATCH --output=200131_sam_to_bam_sort_index_flagstat.out
#SBATCH --error=200131_sam_to_bam_sort_index_flagstat.err

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load samtools/1.10

#file paths
SAM_DIR=/proj/SAMfiles
BAM_DIR=/proj/BAMfiles
BAM_DIR_SORTED=/proj/BAMfiles_sorted
FLAGSTAT_DIR=/proj/Flagstat

#loop to make BAM files from SAM files, and sorting, indexing and generating flagstats of the BAM files.
for i in {1..14}; do \
	FILE_NAME=`sed "${i}q;d" Name.list`
	
	echo $i,$FILE_NAME
	date

	samtools view \
		-@ 4 \
		-bS ${SAM_DIR}/${FILE_NAME}_tc_rmrRNA.sam \
		> ${BAM_DIR}/${FILE_NAME}_tc_rmrRNA.bam \

	samtools sort \
		-@ 4 \
		${BAM_DIR}/${FILE_NAME}_tc_rmrRNA.bam \
		-o ${BAM_DIR_SORTED}/${FILE_NAME}_tc_rmrRNA.sorted.bam

	samtools index \
		-@ 4 \
		${BAM_DIR_SORTED}/${FILE_NAME}_tc_rmrRNA.sorted.bam

	samtools flagstat \
		-@ 4 \
		${BAM_DIR_SORTED}/${FILE_NAME}_tc_rmrRNA.sorted.bam \
		> ${FLAGSTAT_DIR}/${FILE_NAME}.flagstat

	date
done

#!/usr/bin/env bash

#SBATCH --job-name=align
#SBATCH --time=10:00:00
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=10G
#SBATCH --output=out_%j.o
#SBATCH --error=err_%j.e
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=end

module add UHTS/Aligner/STAR/2.7.9a;

FILE_DIRECTORY=/data/courses/rnaseq/lncRNAs/Project2/fastq/
GENOME_DIRECTORY='/data/courses/rnaseq/lncRNAs/Project2/references/star_genome'

#Arguments 1 & 2 are forward & backward reads. Both are supplied in pair by running "run_mapping.sh".

STAR --runThreadN 1 \
        --genomeDir $GENOME_DIRECTORY \
        --readFilesIn $FILE_DIRECTORY${1} $FILE_DIRECTORY${2} \
        --readFilesCommand zcat \
        --outSAMtype BAM SortedByCoordinate \
        --outFileNamePrefix ./star_output/mapping_$1/


###########################################################################
#This script is executed by run_mapping.sh for each of the (12) fasta files
###########################################################################

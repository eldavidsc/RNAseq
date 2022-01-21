#!/usr/bin/env bash

#SBATCH --job-name=quantification
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --error=err_%j.e
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=end

module add UHTS/Assembler/cufflinks/2.2.1

GTF_FILE=/data/courses/rnaseq/lncRNAs/Project2/lbrun/03transcriptome_assembly/stringtie_output/merged_all.gtf
GENOME=/data/courses/rnaseq/lncRNAs/Project2/references/genome_sequence/GRCh38.primary_assembly.genome.fa.gz

gunzip < $GENOME > genome.fa

gffread -w merged.fa -g genome.fa $GTF_FILE

rm genome.fa

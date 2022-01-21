#!/usr/bin/env bash

#SBATCH --job-name=convertstuff
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --error=err_%j.e
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=end

module add UHTS/Analysis/bedops/2.4.40;

FILE=/data/courses/rnaseq/lncRNAs/Project2/dschaer/3assembly/ta_output_merged.gtf

convert2bed --input=GTF < $FILE > merged.bed

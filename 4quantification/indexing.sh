#!/usr/bin/env bash

#SBATCH --job-name=indexing
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --error=err_%j.e
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=end

module add UHTS/Analysis/kallisto/0.46.0;

FILE=/data/courses/rnaseq/lncRNAs/Project2/dschaer/4quantification/merged.fa

kallisto index -i kallisto_index $FILE

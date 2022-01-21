#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --time=01:00:00
#SBATCH --job-name=inter
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_3Intergenic/inter.txt
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_3Intergenic/e_%j.e
#SBATCH --mail-type=end

module add UHTS/Analysis/BEDTools/2.29.2;

REF=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_3Intergenic/gencode.v38.annotation.bed
DATA=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_1CAGEr/merged.bed

bedtools window -w 100 -sm -v -a $DATA -b $REF

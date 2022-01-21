#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=01:00:00
#SBATCH --job-name=CAGE
#SBATCH --output=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_1CAGEr/polyA.txt
#SBATCH --error=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_1CAGEr/e_%j.e
#SBATCH --mail-type=end

module add UHTS/Analysis/BEDTools/2.29.2;

REF=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_1CAGEr/atlas.clusters.2.0.GRCh38.96.bed.gz
DATA=/data/courses/rnaseq/lncRNAs/Project2/dschaer/6_1CAGEr/merged.bed

gunzip < $REF > ref.bed

bedtools window -w 100 -a $DATA -b ref.bed 

rm ref.bed


#!/usr/bin/env bash

#SBATCH --job-name=cpat
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --error=err_%j.e
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=end

module add SequenceAnalysis/GenePrediction/cpat/1.2.4;

FILE=/data/courses/rnaseq/lncRNAs/Project2/dschaer/4quantification/merged.fa


cpat.py -g $FILE -x Human_Hexamer.tsv -d Human_logitModel.RData -o cpatOut


#Reference annotations were downloaded from here: https://sourceforge.net/projects/rna-cpat/files/v1.2.2/prebuilt_model/

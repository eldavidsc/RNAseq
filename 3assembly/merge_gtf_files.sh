#!/usr/bin/env bash

#SBATCH --job-name=merge
#SBATCH --time=10:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --output=out_%j.o
#SBATCH --error=err_%j.e
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=end


module add UHTS/Aligner/stringtie/1.3.3b;


ANNOTATION_FILE='/data/courses/rnaseq/lncRNAs/Project2/dschaer/3assembly/gencode.v38.annotation.gtf'
FILE_LIST=(/data/courses/rnaseq/lncRNAs/Project2/dschaer/3assembly/output/*output.gtf)

stringtie $FILE_LIST --merge -o merged.gtf  -G $ANNOTATION_FILE


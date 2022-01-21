#!/usr/bin/env bash

#SBATCH --job-name=assemble_fr
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --error=err_%j.e
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=end
#SBATCH --array=0-11

module add UHTS/Aligner/stringtie/1.3.3b;


ANNOTATION_FILE='/data/courses/rnaseq/lncRNAs/Project2/dschaer/3assembly/gencode.v38.annotation.gtf'
FILE_LIST=(/data/courses/rnaseq/lncRNAs/Project2/dschaer/3assembly/bam_files/*.bam)

stringtie ${FILE_LIST[$SLURM_ARRAY_TASK_ID]} -o fr_output/${SLURM_ARRAY_TASK_ID}_output.gtf --fr -G $ANNOTATION_FILE 

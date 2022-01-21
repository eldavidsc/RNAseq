#!/usr/bin/env bash

#SBATCH --job-name=quantification
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --error=err_%j.e
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=end
#SBATCH --array=0-11

module add UHTS/Analysis/kallisto/0.46.0;

FORWARD=(/data/courses/rnaseq/lncRNAs/Project2/fastq/*R1*)
BACKWARDS=(/data/courses/rnaseq/lncRNAs/Project2/fastq/*R2*)
INDEX=/data/courses/rnaseq/lncRNAs/Project2/dschaer/4quantification/kallisto_index


kallisto quant -i $INDEX -o output_quant/$SLURM_ARRAY_TASK_ID/ -b 20 --rf-stranded ${FORWARD[SLURM_ARRAY_TASK_ID]} ${BACKWARDS[SLURM_ARRAY_TASK_ID]}

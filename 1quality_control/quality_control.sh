#!/bin/bash
#SBATCH --job-name=quality_control
#SBATCH --output=../dschaer/out_qc_%j.o
#SBATCH --error=qc.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G
#SBATCH --time=3:00:00
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=begin,end
#SBATCH --array=1-25

FILE_DIR=/data/courses/rnaseq/lncRNAs/Project2/fastq
OUTPUT_DIR=../dschaer/qc_out
 

module add UHTS/Quality_control/fastqc/0.11.9;


cd $FILE_DIR

for i in `ls`;do
fastqc -o $OUTPUT_DIR $i; done

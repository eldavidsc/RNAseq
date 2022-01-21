#!/bin/bash
#SBATCH --job-name=count_reads
#SBATCH --error=cs.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=100G
#SBATCH --time=0:50:00
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=begin,end

cd ../fastq;
for i in `ls`; do
zcat $i | awk '$1=="+"' | wc -l >> ../dschaer/out/${i}.txt; done

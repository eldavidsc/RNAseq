#!/usr/bin/env bash

#SBATCH --job-name=stats
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --mail-user=wyttfiffyasym@hotmail.com
#SBATCH --mail-type=end


#Execute to count exons and transcripts in meta transcriptome assembly

awk 'BEGIN {exons = 0 ; transcripts = 0} {if ($3 == "exon") {++exons} ; if ($3 == "transcript") {++transcripts}} END { print exons "\t" transcripts } ' merged.gtf

# 1670489 exons	252855 transcripts

#Execute to count unique gencode identifiers

awk '{print $10}' merged.gtf | sort | uniq | grep "MSTRG" | wc -l

# Entries with no gencode identifier: 11265

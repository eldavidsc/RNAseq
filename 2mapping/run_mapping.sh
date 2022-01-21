
for i in `seq 1 12`; do
R1="$(cat FORWARD_READS.txt | awk "NR==$i {print $1}" )"
R2="$(cat BACKWARDS_READS.txt | awk "NR==$i {print $1}" )"

sbatch mapping.sh $R1 $R2;
done

#####################################################################
#Execute to run sbatch job for every fasta file in FORWARD_READS.txt
#Will provide argument pair for STAR from BACKWARDS_READS.txt
######################################################################

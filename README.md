0count_reads.)

Execute count_reads.sh to create a file with the number of transcripts for each file.

Output:
/out contains files with the number of reads for each sample

1quality_control.)

Execute quality_control.sh to run a quality check for each sample using fastqc software.

Output:
/qc_out contains .html summaries of the reads quality

2mapping.)

Execute run_mapping.sh to map the reads to the reference genome using STAR for each file. 
run_mapping.sh will execute mapping.sh, taking a pair of arguments from FORWARD_READS.txt and BACKWARDS_READS.txt. These two .txt files contain the names of the forward and backwards reads for each of the 12 sample files. 

Output:
In
/data/courses/rnaseq/lncRNAs/Project2/dschaer/2mapping/star_output

Execute all_logs.sh to create a directory containing all STAR alignment logs.
Execute /alignment_logs/display_mapped_reads.sh to display the alignment rates for all file.

In order to aggregate all .bam output files for the next step, execute make_bamlist.sh to store the .bam files in a single directory in /dschaer/3assembly/bam_files.

3assembly.)

Execute assembly.sh to assemble the transcriptome for each file as an array job. A reference annotation file [gencode.v38.annotation.gtf] is required in the same directory as the script.

Execute merge_gtf.files to create merged.gtf containing all 12 samples

Execute commands in stats_assembly.sh to get information about anumber of exon/transcripts in meta-assembly, as well as novel gencode identifiers.

Output:
/data/courses/rnaseq/lncRNAs/Project2/dschaer/3assembly/merged.gtf

4quantification.)

Quantification was done with Kallisto, which requires input files to be in .fa format. Hence, execute gtf_to_fasta.sh to convert. /data/courses/rnaseq/lncRNAs/Project2/references/genome_sequence/GRCh38.primary_assembly.genome.fa is required.

Execute indexing.sh to create a Kallisto index for merged.fa. Creating an index is required for quantification.

Quantification is done by executing quantification.sh

Output:
/data/courses/rnaseq/lncRNAs/Project2/dschaer/4quantification/output_quant

5differential_expression.)

Sleuth_code_diff_exp.R contains R code to run differential expression analysis on transcript and on gene level. Result tables and explicit diferential expression matrices can be created for both levels.

Output:
/data/courses/rnaseq/lncRNAs/Project2/dschaer/5differential_expression/
Matrix_genelevel.txt
Matrix_translevel.txt
result_tableG.txt
result_tableT.txt

6_1end_annotation.)

Execute gtf2bed.sh to convert gtf meta-assembly to bed

Run window_polyA.sh to select elements with correct polyA end annotation. Annotation is downloaded from here: https://polyasite.unibas.ch/download/atlas/2.0/GRCh38.96/atlas.clusters.2.0.GRCh38.96.bed.gz

Run window_TSS.sh to select elements with correct transcription start site annotation. Annotation is downloaded from here: https://dbarchive.biosciencedbc.jp/en/fantom5/data-7.html

6_2protein_coding_pot.)

Execute cpatstuff.sh to evaluate coding potential. Reference files were downloaded from here: https://sourceforge.net/projects/rna-cpat/files/v1.2.2/prebuilt_model/

Run CPAT_RatioCoding.R on cpatOut.dat to select novel and protein coding elements.

Output:
CPAT_datanovelcut.txt

6_3intergenic.)

Run convert_to_bed.sh to convert gencode annotation file to .bed.

Execute inter.sh to select elements in intergenic regions. 

Run commands in inter_stats.sh to count unique identifiers in output.
unique identifiers: 11265
total: 187856

Output:
inter.txt

7.) Prioritization

Execute Prioritization_table.R with output from all 4 previous tasks to create an excel file summarizing all information.
Excel table can be sorted according to desired parameters in order to find suitable candidate.


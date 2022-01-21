# Sleuth manual
#https://rawgit.com/pachterlab/sleuth/master/inst/doc/intro.html


########################Installation and reading in data############################

devtools::install('./sleuth/') 
library('sleuth')
library(dplyr)


base_dir <- "C:/Users/Dave/Documents/Masta/Sem1/RNA_Sequencing/Progress/output_quantification"
sample_id <- dir(file.path(base_dir))
kal_dirs <- sapply(sample_id, function(id) file.path(base_dir, id))
kal_dirs

s2c <- data.frame(path=kal_dirs, sample=sample_id, condition = rep(c("holo", "mero", "para", "parent"), each=3), stringsAsFactors=FALSE)
s2c <- dplyr::select(s2c, sample, condition)
s2c <- dplyr::mutate(s2c, path = kal_dirs)
s2c

####Add gene names

source("http://bioconductor.org/biocLite.R")
biocLite("biomaRt")

mart <- biomaRt::useMart(biomart = "ENSEMBL_MART_ENSEMBL",
                         dataset = "hsapiens_gene_ensembl",
                         host = 'ensembl.org')

t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id", "ensembl_gene_id",
                                     "external_gene_name"), mart = mart)
t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id,
                     ens_gene = ensembl_gene_id, ext_gene = external_gene_name)


##################Differential expression Transcript-levels############################

so <- sleuth_prep(s2c, ~ condition, target_mapping = t2g, extra_bootstrap_summary=T)

so <- sleuth_fit(so)
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_lrt(so, 'reduced', 'full')
so <- sleuth_wt(so, which_beta = "conditionparent")


result_tableT<- sleuth_results(so, "conditionparent", test_type = 'wt')
result_tableT <- dplyr::filter(result_tableT, qval <= 0.05)


Matrix_translevel <- sleuth_to_matrix(obj = so, which_df = "obs_norm", which_units = "tpm")

write.table(result_tableT,"result_tableT.txt")
write.table(Matrix_translevel,"Matrix_translevel.txt")


plt <- plot_volcano(so, test="conditionparent", test_type = "wt", which_model = "full",
                    sig_level = 0.1, point_alpha = 0.2, sig_color = "red",
                    highlight = NULL)
show(plt)

############################Differential expression Gene-Level#########################################

rm(so)
so <- sleuth_prep(s2c, ~condition, target_mapping = t2g, aggregation_column = 'ens_gene',
                  gene_mode = T, extra_bootstrap_summary=TRUE)

so <- sleuth_fit(so)
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_lrt(so, 'reduced', 'full')
so <- sleuth_wt(so, which_beta = "conditionparent")


result_tableG<- sleuth_results(so, "conditionparent", test_type = 'wt')
result_tableG <- dplyr::filter(result_tableG, qval <= 0.05)


Matrix_genelevel <- sleuth_to_matrix(obj = so, which_df = "obs_norm", which_units = "scaled_reads_per_base" )

write.table(result_tableG,"result_tableG.txt")
write.table(Matrix_genelevel,"Matrix_genelevel.txt")


plt <- plot_volcano(so, test="conditionparent", test_type = "wt", which_model = "full",
                    sig_level = 0.1, point_alpha = 0.2, sig_color = "red",
                    highlight = NULL)
show(plt)
sleuth_live(so)







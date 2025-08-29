# Concatenates the no alt hg38 reference genome used in ENCODE with the U13369.1 rDNA array.
# Used for aligning nascent RNA-seq experiments.

wget https://www.encodeproject.org/files/GRCh38_no_alt_analysis_set_GCA_000001405.15/@@download/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta.gz -O hg38.fa.gz
wget https://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi\?tool\=portal\&save\=file\&log$\=seqview\&db\=nuccore\&report\=fasta\&id\=555853\&conwithfeat\=on\&withparts\=on\&hide-cdd\=on -O - | sed '$ d' | sed 's/U13369.1/rRNA_U13369.1/g' | bgzip > rDNA_human_U13369.1.fa.gz

gunzip -c hg38.fa.gz rDNA_human_U13369.1.fa.gz | bgzip > hg38.rRNA.fa.gz
samtools faidx hg38.rRNA.fa.gz
cut -f1-2 hg38.rRNA.fa.gz.fai > hg38.rRNA.chrom.sizes
bwa index hg38.rRNA.fa.gz

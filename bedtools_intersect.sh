#!/bin/bash

#finding intersecting sequences between files



#Instert bed/gff/vcf/bam file for variables
A=opt_Eseedling_DApeak_bed.txt
B=RILs_ALL.denovo_shared_mPing.loci.gff 

module load bedtools

#finding intersecting regions between A and B
bedtools intersect -a $A -b $B > ATAC_shared_mPing_Intersect.bed

cat ATAC_shared_mPing_Intersect.bed | column -t > ATAC_shared_mPing_Intersect_col.bed

#sorting the intersecting regions by chromosome and start position
sort -k1,1 -k2,2n ATAC_shared_mPing_Intersect_col.bed > ATAC_shared_mPing_Intersect.sort.bed 

#optional merging command below
#bedtools merge -i ATAC_shared_mPing_Intersect.sort.bed > ATAC_shared_mPing_merge.bed

#make table next

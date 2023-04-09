#Downloading and assembling illumina short reads
#srun-p short -N 1 -c 16 --mem 16gb -n 1 --pty bash -l
#CPU=


#downloading reference genome for alignment
#change accession number for fasta file and in URL
curl -o NC_002695.2.fasta "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=NC_002695.2&rettype=fasta&amp;retmode=text"

module load libdeflate/1.14 htslib/1.16
module load sratoolkit
module load bwa
module load samtools

#Index genome
GENOME=NC_002695.2.fasta
bwa index $GENOME

#SRA=SRR22489963
#sbatch

fasterq-dump --split-files SRR22543622

CPU=16
#may have to specify path to files
FWDREAD=SRR22543622_1.fastq
REVREAD=SRR22543622_2.fastq
bwa mem -t $CPU $GENOME $FWDREAD $REVREAD > local_align.sam
samtools fixmate -O bam local_align.sam align_fixmate.bam
samtools sort --threads $CPU -O BAM -o align.bam align_fixmate.bam
samtools index align.bam
#samtools tview align.bam $GENOME

samtools consensus -f fastq align.bam -o cons.fq


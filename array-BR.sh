#!/bin/bash
module load GATK/4.0.4.0-IGB-gcc-4.9.4-Java-1.8.0_152-Python-3.6.1
module load SAMtools
module load parallel

#Input/Output locations
homedir=~/deepTA
readdir=$homedir/alignments/gp2
outdir=$homedir/recal/gp2
gvcfdir=$homedir/gvcf/gp2
refdir=~/wildsnps/vv2.2
reffile='vv2.2.fa'
refvcf=$homedir/refvcf/variants-vv2.2.vcf
scratchdir=$homedir/temp/$SLURM_JOB_ID
mkdir -p $scratchdir

#locations for modules on biocluster
GATKDir=$EBROOTGATK

#Check that inputs exist
for inname in homedir readdir outdir gvcfdir redfir reffile refvcf; do
  if [ ! -e $inname ]; then
    echo "$inname does not exist"
    exit 1
  fi
done

#Prep inputs
if [ ! -f $refvcf.idx ]; then
  echo "index vcf reference file"
  java -Xmx79G -XX:ParallelGCThreads=4 -Djava.io.tmpdir=$scratchdir -jar $GATKDir/gatk.jar IndexFeatureFile -F $refvcf
  echo "indexing done"
fi

if [ ! -e $readdir/$i.sort.dd.dd.bam.bai ]; then
  if [ ! -f $readdir/$i.sort.dd.dd.bam ]; then
    echo "$readdir/$i.sort.dd.dd.bam does not exist"
    exit 1
  else; 
    samtools index $readdir/$i.sort.dd.dd.bam
  fi
fi

seq 1 43 | parallel -j 4 $homedir/scripts/parallel-BR4.sh {} $i "$scratchdir" "$GATKDir"

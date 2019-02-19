#This is a submission script that should be run on the head node (it doesn't take many resources, and you can't talk to the
#queue manager from the worker nodes. Run it by typing this: chmod u+x queue_jobs.sh; ./queue_jobs.sh

#This pipeline was developed in summer 2018 according to the GATK best practices for GATK 4.0 calling germline variants.
#You should make sure that the steps used here are appropriate for your data and analysis. 
#https://software.broadinstitute.org/gatk/best-practices/workflow?id=11145

#GATK is slow and not very performant, so this approach brute-forces parallelization by breaking the problem into pieces and submitting
#each piece separately (a scatter-gather approach). A step cannot start until the prior steps it depends on have finished (dependencies).

for i in {01..42}; do #for each sample (can be modified to pull names from a script, see BioCluster workshop slides)
  RES1=$(sbatch --parsable -e BR_$i.out --export=i=$i -D ~/deepTA/jobs -J BR_$i -N 1 -n 8 --mem=80G array-BR.sh) #run BaseRecal
  RES2=$(sbatch --parsable --dependency=afterok:$RES1 --kill-on-invalid-dep=yes -e PR_$i.out --export=i=$i -D ~/deepTA/jobs -J PR_$i -N 1 -n 8 --mem=50G array-PR.sh)
  sbatch --dependency=afterok:$RES2 --kill-on-invalid-dep=yes -e HC_$i.out --export=i=$i -D ~/deepTA/jobs -J HC_$i -N 1 -n 1 --mem=50G array-HC.sh
done

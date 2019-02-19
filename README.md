Halie Rando, Spring 2019

## MOTIVATION
Here are some scripts I wrote to help manage variant calling with GATK on the BioCluster. We had a lot of issues optimizing this pipeline because GATK is not very performant (a.k.a. it often uses only one CPU even if you give it more than one). The pipeline here brute-forces  the issue by breaking each individual up into pieces and requesting the amount of memory and CPUs that we found to be roughly cost-optimal. 

Your data are likely very different from ours, so you will likely need to tailor these scripts. I hope this is a good starting place. I was working with ~15X sequencing data from 84 red foxes from two different populations. The red fox genome is 2.5 Gb and split into 676878 scaffolds, but here I was looking only at scaffolds larger than 5Kbp (corresponding to 3154 scaffolds).

These scripts are written specifically for the Illinois BioCluster2, but should be a good starting place for anyone working on a cluster with a slurm queue management system. I will also try to upload the same pipeline that I have adapted for PBS Torque -- if you would like  it sooner rather than later, you can reach out to me by email at rando2 at illinois dot edu.

Please refer to the [GATK 4.0 best practices workflow](https://software.broadinstitute.org/gatk/best-practices/workflow?id=11145) for the rationale behind each step of the pipeline.

## NOTE TO ILLINOIS RESEARCHERS
If you are new to cluster computing, I highly recommend signing up for the [HPCBio workshop](https://hpcbio.illinois.edu/hpcbio-workshops) that teaches you how to use the BioCluster.

Additionally, you can come to the [Bioinformatics Coffee Hour](https://bioinfcoffeehour.slack.com) to ask for help. As of Spring 2019, we meet at 2:30pm on Wednesdays in Array Cafe.

## USING THE PIPELINE
Start with the queue_jobs.sh script. This is the hub that queues all of the jobs with interlocking dependencies, so that (if all goes well), you can run this script once and then take the weekend off. Of course, it might take a little work at first to make sure the script is able to find everything it needs to run!

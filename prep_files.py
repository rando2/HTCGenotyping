#THIS SCRIPT IS STILL IN PROGRESS TO MAKE THIS PIPELINE PORTABLE. PLEAE DON'T TRY TO USE IT YET!

#Please fill out all of this information

#Where is your reference file and what is it called? (Should be in fasta format)
reffile="/home/reference/fox5k.fa" #leave quotes around this, do not use ~ for home directory

#How many scaffolds are in your assembly?
num_scaff=3154




#Do not modify below unless you need to change how the script works!
import os.system

makeref="samtools faidx " + reffile
makesizes="cut -f1,2 " + reffile + ".fai > " + reffile + ".sizes"

command = makeref + ';' + makesizes
os.system(command)

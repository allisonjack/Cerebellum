#!/bin/bash

#SBATCH -J suit_isolate
#SBATCH -o suit_isolate%j.out
#SBATCH -e suit_isolate%j.err 
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=YOURUSERNAME@YOUREMAIL.edu
#SBATCH -N 1
#SBATCH -p short
#SBATCH -t 1:00:00

#-p is the name of your desired partition--adjust this accordingly!

source ~/.bashrc

module load matlab
ssh login4 -L 27000:128.164.84.113:27000 -L 27001:128.164.84.113:27001 -N &
export LM_LICENSE_FILE="27000@localhost"

matlab -nodesktop < suit_isolate.m 

#call this with

#sbatch --array=1-16 suit_isolate.m

#Adjust the range of array to capture number of images/participants to be processed.
#These numbers will be passed to the SLURM_ARRAY_TASK_ID variable within the script 
#and used in indexing the array of participant-specific paths.

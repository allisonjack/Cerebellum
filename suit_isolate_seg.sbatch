#!/bin/bash

#SBATCH -J suit_isolate_seg
#SBATCH -o suit_isolate_seg%j.out
#SBATCH -e suit_isolate_seg%j.err 
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=allisonjack@gwu.edu
#SBATCH -N 1
#SBATCH -p short
#SBATCH -t 1:00:00

#-p is the name of your desired partition--adjust this accordingly!
# set output and error output filenames, %j will be replaced by Slurm with the jobid


source ~/.bashrc

module load matlab
ssh login4 -L 27000:128.164.84.113:27000 -L 27001:128.164.84.113:27001 -N &
export LM_LICENSE_FILE="27000@localhost"

matlab -nodesktop < suit_isolate_seg.m 

#call this with

#     sbatch --array=1-13 suit_isolate_seg.sbatch

#adjust the range of array to capture number of images/participants to be processed
#these numbers will be passed to the SLURM_ARRAY_TASK_ID variable within the script
#and used in indexing the array of participant-specific paths

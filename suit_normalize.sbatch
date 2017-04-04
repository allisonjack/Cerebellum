#!/bin/bash

# set output and error output filenames, %j will be replaced by Slurm with the jobid
#SBATCH -o suit_normalize%j.out
#SBATCH -e suit_normalize%j.err 
#SBATCH -N 1
#SBATCH -p short
#SBATCH -t 2:00:00
#SBATCH --mail-type=BEGIN,END,FAIL 
#SBATCH --mail-user=YOURUSERNAME@YOUREMAIL.edu

source ~/.bashrc

module load matlab
ssh login4 -L 27000:128.164.84.113:27000 -L 27001:128.164.84.113:27001 -N &
export LM_LICENSE_FILE="27000@localhost"

matlab -nodesktop < suit_normalize.m

#call with
# sbatch --array=1-16 suit_normalize.sbatch
#where the range of numbers in the array is 1 through the number of images to be processed

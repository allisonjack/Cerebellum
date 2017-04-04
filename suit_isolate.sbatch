#!/bin/bash

#SBATCH -J suit_isolate
#SBATCH -o suit_isolate%j.out
#SBATCH -e suit_isolate%j.err 
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=YOURUSERNAME@YOUREMAIL.edu
#SBATCH -N 1
#SBATCH -p short
#SBATCH -t 1:00:00

source ~/.bashrc

module load matlab
ssh login4 -L 27000:128.164.84.113:27000 -L 27001:128.164.84.113:27001 -N &
export LM_LICENSE_FILE="27000@localhost"

matlab -nodesktop < suit_isolate.m 

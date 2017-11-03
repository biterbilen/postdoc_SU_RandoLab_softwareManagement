#!/bin/bash - 
#===============================================================================
#
#          FILE: bb_scratch2oak.sh
# 
#         USAGE: $ sbatch ./bb_scratch2oak.sh [local_dir]
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Biter Bilen (), biterbilen@yahoo.com
#  ORGANIZATION: 
#       CREATED: 09/22/2017 02:34:57 PM
#      REVISION:  ---
#===============================================================================



set -o nounset                              # Treat unset variables as an error

###!/bin/bash 
#SBATCH --time=2:0:0 
#SBATCH -n 4
#SBATCH --partition normal
if [ "$#" -ne 1 ]; then
	echo "missing directory" >&2
	exit 1
fi

dir=$1

if [[ $SHERLOCK == 1 ]]; then
	module load mpifileutils
	else
	module load system mpifileutils
	fi

#mkdir -p $OAK/$USER/$dir	
srun dcp -p $PI_SCRATCH/$dir $OAK/$USER/$dir



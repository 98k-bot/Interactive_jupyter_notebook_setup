#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH -p gpu
#SBATCH --gpus=a100:1
#SBATCH --job-name=jupyter_zhanh
#SBATCH -t 24:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=huixin.zhan@cshs.org
#SBATCH -o /common/zhanh/Jupyter_Scripts/out_jupyter
#SBATCH -e /common/zhanh/Jupyter_Scripts/err_jupyter

source /common/zhanh/anaconda3/etc/profile.d/conda.sh
#conda activate dna
#/common/zhanh/anaconda3/envs/dna/bin/python

WHOAMI=`whoami`
PORTNUM=`cksum <<< ${WHOAMI} | cut -f 1 -d ' ' | cut -c1-4`
timeout 86400 jupyter notebook --no-browser --port ${PORTNUM} || echo 'timed out!'

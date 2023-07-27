#!/bin/bash


#!/bin/bash
#SBATCH --nodes 1
#SBATCH -p gpu
#SBATCH --gpus=a100:1
#SBATCH --time 1-0:00:00
#SBATCH --job-name jupyter-notebook
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=huixin.zhan@cshs.org
#SBATCH --output /common/zhanh/Jupyter_Scripts/jupyter-notebook-%J.log

#rm /common/zhanh/Jupyter_Scripts/jupyter-notebook-*.log

# get tunneling info
XDG_RUNTIME_DIR=""
port=$(shuf -i8000-9999 -n1)
node=$(hostname -s)
user=$(whoami)
cluster=$(hostname -f)


# print tunneling instructions jupyter-log
echo -e "
MacOS or linux terminal command to create your ssh tunnel:
ssh -N -L ${port}:${node}:${port} ${user}@esplhpccompbio-lv01

Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"

source /common/zhanh/anaconda3/etc/profile.d/conda.sh
#conda activate dna
#/common/zhanh/anaconda3/envs/dna/bin/python


# DON'T USE ADDRESS BELOW.
# DO USE TOKEN BELOW
jupyter-notebook --no-browser --port=${port} --ip=${node}

#!/bin/bash

#SBATCH --time 4:00:00
#SBATCH --mem 64G
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 50
#SBATCH --job-name diff_sampler
#SBATCH --array=1#-40 #Run 40 copies of the code = 4000 samples
#SBATCH --partition cosma8-serial
#SBATCH --account dp270
#SBATCH --output /cosma8/data/dp270/dc-glas1/slurm-out/slurm-%J.out

source ~/.bashrc
conda deactivate
conda activate hera_sim

SCRIPT="/cosma/home/dp270/dc-glas1/diffuse_emission/vis_realified.py"

echo $@

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
python -u $SCRIPT "$@" -dir=standard -nsamples=100 -data_seed=20 -jobid=$SLURM_ARRAY_TASK_ID
#!/bin/bash
#SBATCH --job-name=pv
#SBATCH --time=00:60:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem-per-cpu=2048MB
#SBATCH --output=pv.out
#SBATCH --partition=computes_thin

mpiexec -np $SLURM_NTASKS pvserver
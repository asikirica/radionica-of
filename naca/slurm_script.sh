#!/bin/bash
#SBATCH --job-name=naca
#SBATCH --time=00:30:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=5
#SBATCH --mem-per-cpu=1024MB
#SBATCH --output=logit-%j.out
#SBATCH --partition=computes_thin

# modify decomposeParDict and decompose
sed -i "s/numberOfSubdomains.*[0-9][0-9]*;/numberOfSubdomains $SLURM_NTASKS;/g" system/decomposeParDict
decomposePar -fileHandler collated > log.decomposePar 2>&1

# run
mpirun -np $SLURM_NTASKS simpleFoam -parallel -fileHandler collated > log.LOGGIT 2>&1

# reconstruct
reconstructPar -fileHandler collated > log.reconstructPar 2>&1
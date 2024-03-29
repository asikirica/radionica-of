#!/bin/bash

# decomposition
nx=4
ny=2
nz=2

# create mesh
blockMesh > log.blockMesh 2>&1

# set fluid zone
setFields > log.setFields 2>&1

# modify decomposeParDict and decompose
sed -i "s/numberOfSubdomains.*[0-9][0-9]*;/numberOfSubdomains $SLURM_NTASKS;/g" system/decomposeParDict
sed -i "s/n.*([0-9][0-9]*.*[0-9][0-9]*.*[0-9][0-9]*);/n ($nx $ny $nz);/g" system/decomposeParDict
decomposePar -fileHandler collated > log.decomposePar 2>&1

# run
mpirun -np $SLURM_NTASKS interFoam -parallel -fileHandler collated > log.LOGGIT 2>&1

# reconstruct
reconstructPar -fileHandler collated -time 20:40> log.reconstructPar 2>&1
#!/bin/bash

# create mesh
blockMesh > log.blockMesh 2>&1

# renumber mesh (reduced bandwith)
# renumberMesh -overwrite > log.renumberMesh 2>&1

# modify decomposeParDict and decompose
sed -i "s/numberOfSubdomains.*[0-9][0-9]*;/numberOfSubdomains $SLURM_NTASKS;/g" system/decomposeParDict
decomposePar -fileHandler collated > log.decomposePar 2>&1

# run
mpirun -np $SLURM_NTASKS pimpleFoam -parallel -fileHandler collated > log.LOGGIT 2>&1

# reconstruct
reconstructPar -fileHandler collated > log.reconstructPar 2>&1
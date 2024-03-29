#!/bin/bash

# create mesh
blockMesh > log.blockMesh 2>&1

# create patch
topoSet > log.topoSet 2>&1
createPatch -overwrite > log.createPatch 2>&1

# modify decomposeParDict and decompose
sed -i "s/numberOfSubdomains.*[0-9][0-9]*;/numberOfSubdomains $SLURM_NTASKS;/g" system/decomposeParDict
decomposePar -fileHandler collated > log.decomposePar 2>&1

# run
mpirun -np $SLURM_NTASKS buoyantReactingFoam -parallel -fileHandler collated > log.LOGGIT 2>&1

# reconstruct
reconstructPar -fileHandler collated > log.reconstructPar 2>&1
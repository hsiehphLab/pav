#!/bin/bash -l

# modified for maintenance window
#SBATCH --time=24:00:00

# original:
# #SBATCH --time=96:00:00

#SBATCH --ntasks=1
#SBATCH --mem=50g
#SBATCH --tmp=1g

source /projects/standard/hsiehph/shared/bin/initialize_conda.sh
conda activate pav4


set -euo pipefail

mkdir -p logs


# for testing:
#   --configfile .test/config.yaml \

export SNAKEFILE="../Snakefile"

# removed:
#    --resources load=1000 \


snakemake -s ${SNAKEFILE} \
    --use-conda \
   --profile profile \
    --local-cores 20 \
    --cores 20 \
    --max-inventory-time 10000 \
    --scheduler greedy \
    --latency-wait 60 \
    --restart-times 2 \
    --jobs 100 \
    --nolock \
    "$@"



#    --local-cores 100 \
#    --cores 100 \
#    --max-inventory-time 10000 \
#    --resources load=1000 \
#    --scheduler greedy \
#    --latency-wait 60 \
#    --restart-times 1 \
#    --rerun-incomplete \

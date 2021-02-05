#!/bin/bash

# Needed for local MPI issues
export MPICH_INTERFACE_HOSTNAME=localhost

cd ${CMEC_CODE_DIR}
echo "Running drought metrics"
python ${CMEC_CODE_DIR}/drought_metrics.py ${CMEC_CONFIG_DIR}/cmec.json >> ${CMEC_WK_DIR}/drought_metrics_log.txt

# Make cmec outputs if drought metrics succeeds
if [[ $? = 0 ]]; then
    echo "Creating CMEC output"
    python ${CMEC_CODE_DIR}/dm_cmec_outputs.py ${CMEC_CONFIG_DIR}/cmec.json
    # Remove regridding files
    rm ${CMEC_WK_DIR}/conservative_*.nc
else
    echo "Failure in drought_metrics.py"
fi

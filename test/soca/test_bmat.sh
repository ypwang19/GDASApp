#!/bin/bash
set -e

project_binary_dir=$1
project_source_dir=$2

source ${project_source_dir}/test/soca/test_utils.sh

# Clean test files created during a previous test
echo "============================= Test that the grid has been generated"
rm -f  ${DATA}/soca_gridspec.nc
rm -f  ${DATA}/ocn.bkgerr_stddev.incr.2018-04-15T09:00:00Z.nc
rm -f  ${DATA}/bump/bump[23]d_nicas_local_000002-00000[12].nc

# Export runtime env. variables
source ${project_source_dir}/test/soca/runtime_vars.sh $project_binary_dir $project_source_dir

# Run step
echo "============================= Testing exgdas_global_marine_analysis_bmat.sh for clean exit"
${project_source_dir}/scripts/exgdas_global_marine_analysis_bmat.sh > exgdas_global_marine_analysis_bmat.log

echo "============================= Test that the grid has been generated"
test_file  ${DATA}/soca_gridspec.nc

echo "============================= Test that the parametric diag of B was generated"
test_file  ${DATA}/ocn.bkgerr_stddev.incr.2018-04-15T09:00:00Z.nc
test_file  ${DATA}/bump/bump2d_nicas_local_000002-000001.nc
test_file  ${DATA}/bump/bump3d_nicas_local_000002-000001.nc

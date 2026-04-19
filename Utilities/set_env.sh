#!/bin/bash

echo ""
echo ">>> Setting necessary environment variables"
echo "==========================================="

# --- OLD EG2 ENVIRONMENT (kept as comment) ---
# export DATA_DIR=${HOME}/analysis-omega/out/GetSimpleTuple/data
# export SIM_DIR=${HOME}/analysis-omega/out/GetSimpleTuple/sim
# export HAPRAD_CPP=${HOME}/software/HAPRAD_CPP
# export CERN_LIB=/lib/x86_64-linux-gnu/

# --- NEW RGD ENVIRONMENT ---
export DATA_DIR=/w/hallb-scshelf2102/clas12/suman/new_RGD_Analysis/GetSimpleTuple/data
export SIM_DIR=/w/hallb-scshelf2102/clas12/suman/new_RGD_Analysis/GetSimpleTuple/sim
export HAPRAD_CPP=/w/hallb-scshelf2102/clas12/suman/new_RGD_Analysis/Radiative_Corrections/HAPRAD_CPP_RGD

# use the CERN env set by the module:
export CERN_LIB=${CERN}/2023/lib

echo ">>> DATA_DIR   = ${DATA_DIR}"
echo ">>> SIM_DIR    = ${SIM_DIR}"
echo ">>> HAPRAD_CPP = ${HAPRAD_CPP}"
echo ">>> CERN_LIB   = ${CERN_LIB}"
echo ""

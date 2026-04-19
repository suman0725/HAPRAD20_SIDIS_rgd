#!/bin/bash

#####################################################
#                                                   #
#  Script to execute the RC calculation chain       #
#  for RGD SIDIS pi+ analysis on JLab ifarm         #
#                                                   #
#  RGD targets: C, Cu, Sn (solid) + D (LD2)        #
#  Beam energy: 10.6 GeV (RGD)                      #
#                                                   #
#  Adapted from utfsm-eg2-data-analysis/HAPRAD_CPP  #
#  EG2 original target list was:                    #
#    targets=("D_C" "D_Fe" "D_Pb" "C" "Fe" "Pb")   #
#                                                   #
#  RGD target list (C first for EG2 validation):   #
#    targets=("D_C" "D_Cu" "D_Sn" "C" "Cu" "Sn")   #
#                                                   #
#####################################################

function print_help() {
    echo "SCRIPT: exec_rad-corr_chain.sh"
    echo "======================="
    echo "./exec_rad-corr_chain.sh --pid <pid>"
    echo "Where:"
    echo "  <pid>  = selects particle PDG number (211=pi+, -211=pi-, 2212=proton)"
    echo "Example:"
    echo "  ./exec_rad-corr_chain.sh --pid 211"
    exit
}

function process_args() {
    arr=("$@")
    ic=0
    while [[ $ic -le $((${#arr[@]}-1)) ]]; do
        if [[ "${arr[$ic]}" == "--pid" ]]; then
            pid=${arr[$((ic+1))]}
        else
            echo "ERROR: unrecognized argument: ${arr[$((ic))]}.";
            print_help;
        fi
        ((ic+=2))
    done
}

function print_args() {
    echo "SCRIPT: exec_rad-corr_chain.sh"
    echo "=============================="
    echo "pid = ${pid}"
}

################
###   Main   ###
################

if [[ -z "${DATA_DIR}" ]]; then
    echo "ERROR: variable DATA_DIR is unset. Run: source set_env.sh"
    exit 1
fi

if [[ -z "${HAPRAD_CPP}" ]]; then
    echo "ERROR: variable HAPRAD_CPP is unset. Run: source set_env.sh"
    exit 1
fi

if [[ -z "${CERN_LIB}" ]]; then
    echo "ERROR: variable CERN_LIB is unset. Run: source set_env.sh"
    exit 1
fi

if [[ ${#} -ne 2 ]]; then
    echo "ERROR: ${#} arguments were provided, they should be 2."
    print_help
fi

argArray=("$@")
process_args "${argArray[@]}"
print_args

# -------------------------------------------------------
# RGD target list
# C is first: smallest nuclear effects, was in EG2 ->
#   use it to validate RC against Mineeva's EG2 results
# D_X = deuterium (LD2) reference paired with target X
#
# EG2 original was:
#   targets=("D_C" "D_Fe" "D_Pb" "C" "Fe" "Pb")
# -------------------------------------------------------
targets=("D_C" "D_Cu" "D_Sn" "C" "Cu" "Sn")

# move to Utilities dir
cd ${HAPRAD_CPP}/Utilities

# create binning.csv from Binning.hxx edges
./bin/GetBinning

# loop over targets
for tar in "${targets[@]}"; do

    echo ""
    echo "========================================"
    echo "  Processing target: ${tar}"
    echo "========================================"

    # compute bin centroids (Q2, nu, zh, pt2, phi) from data
    ./bin/GetCentroids -t${tar} -p${pid}

    # fit phi_PQ distributions -> PARAM_A, PARAM_AC, PARAM_ACC
    ./bin/FitPhiPQ -t${tar} -p${pid}

    # patch TStructFunctionArray.cxx with phi fit parameters
    source fit-results_${tar}.sh
    cd ${HAPRAD_CPP}
    sed -i "s|Double_t A;|Double_t A = ${PARAM_A};|g"      TStructFunctionArray.cxx
    sed -i "s|Double_t Ac;|Double_t Ac = ${PARAM_AC};|g"    TStructFunctionArray.cxx
    sed -i "s|Double_t Acc;|Double_t Acc = ${PARAM_ACC};|g" TStructFunctionArray.cxx

    # recompile HAPRAD_CPP with updated structure functions
    make

    # recompile Utilities
    cd ${HAPRAD_CPP}/Utilities
    make clean; make

    # compute RC factors -> RCFactor_${tar}.txt
    ./bin/GetRC -t${tar}

    # restore TStructFunctionArray.cxx (remove patched values)
    cd ${HAPRAD_CPP}
    sed -i "s|Double_t A = ${PARAM_A};|Double_t A;|g"      TStructFunctionArray.cxx
    sed -i "s|Double_t Ac = ${PARAM_AC};|Double_t Ac;|g"    TStructFunctionArray.cxx
    sed -i "s|Double_t Acc = ${PARAM_ACC};|Double_t Acc;|g" TStructFunctionArray.cxx
    make

    cd ${HAPRAD_CPP}/Utilities

done

echo ""
echo "========================================"
echo "  Done! RC factors written to:"
for tar in "${targets[@]}"; do
    echo "    RCFactor_${tar}.txt"
done
echo "========================================"

#ifndef BINNING_HXX
#define BINNING_HXX

#ifndef HEADERS_HXX
#include "Headers.hxx"
#endif

// ============================================================
//  Binning.hxx
//
//  EG2 original (Ebeam=5.0 GeV, targets: C, Fe, Pb):
//    const Double_t kEdgesQ2[3]    = {1, 2.5, 4.0};
//    const Double_t kEdgesNu[3]    = {2.2, 3.2, 4.2};
//    const Double_t kEdgesZ[3]     = {0.5, 0.75, 1.0};
//    const Double_t kEdgesPt2[3]   = {0.0, 0.75, 1.5};
//    const Double_t kEdgesPhiPQ[6] = {-180.,-108.,-36.,36.,108.,180.};
//
//  RGD adaptation (Ebeam=10.6 GeV, targets: C, Cu, Sn):
//    - Q2 extended to 9 GeV^2  (EG2 max was 4.0)
//    - Nu extended to 9 GeV    (EG2 max was 4.2 at 5 GeV beam)
//    - Z  lower bound at 0.3   (EG2 started at 0.5)
//    - Pt2 finer binning at low end to capture pT broadening
//    - PhiPQ unchanged
// ============================================================

// Q^2 (GeV^2) -- 3 bins, 4 edges
const Double_t kEdgesQ2[4]    = {1.0, 2.5, 4.5, 9.0};

// Nu (GeV) -- 3 bins, 4 edges
const Double_t kEdgesNu[4]    = {2.0, 4.0, 6.0, 9.0};

// z_h -- 3 bins, 4 edges
const Double_t kEdgesZ[4]     = {0.3, 0.5, 0.75, 1.0};

// p_T^2 (GeV^2) -- 3 bins, 4 edges
const Double_t kEdgesPt2[4]   = {0.0, 0.5, 1.0, 1.5};

// phi_PQ (degrees) -- 5 bins, 6 edges  [unchanged from EG2]
const Double_t kEdgesPhiPQ[6] = {-180., -108., -36., 36., 108., 180.};

#endif

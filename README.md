# HAPRAD_CPP — RGD SIDIS Radiative Corrections

C++ program for calculation of radiative corrections to semi-inclusive hadron leptoproduction, based on the original Fortran code `HAPRAD2`.

## Source

This code is adapted from the EG2 analysis repository:
**https://github.com/utfsm-eg2-data-analysis/HAPRAD_CPP**

Original EG2 authors: H. Hakobyan, R. Oyarzun, S. Mancilla (UTFSM, Chile)  
RGD adaptation: Suman Shrestha (Temple University / Jefferson Lab)

## Physics

Computes radiative corrections (RC) to the SIDIS cross section:

```
RC = σ_obs / σ_Born
```

Applied to RGD π⁺ observables:
- Multiplicity ratios (nuclear / deuteron)
- p_T broadening
- cos φ and cos 2φ modulations  (unpolarized beam helicity)
- sin φ modulation              (longitudinally polarized beam)

RGD targets: Cu, C, Sn (solid foils) + liquid deuterium (LD2)

## Requirements

* [**ROOT**](https://root.cern.ch/) — available on JLab ifarm via `clas12` module
* **CERNLIB** — available on JLab ifarm via `cernlib/2023` module

> **Note:** This code is developed and tested on **JLab ifarm** (AlmaLinux 9, GCC 11).  
> Load the environment before compiling:
> ```bash
> module load clas12/5.6
> ```

## Compilation

```bash
# On JLab ifarm — environment already loaded by clas12 module
make clean && make
```

A shared library `slib/libTRadCor.so` will be created.

For the analysis utilities (RC factor extraction chain):

```bash
cd Utilities
source set_env.sh
make
```

## Usage

Link `slib/libTRadCor.so` to your own analysis programs to compute RC factors.  
See [Utilities/README.md](Utilities/README.md) for the full RC extraction workflow.

## Key Classes

| Class | Description |
|-------|-------------|
| `TRadCor` | Main RC calculation class |
| `TBorn` | Born cross section |
| `TDelta` | Radiative correction delta |
| `TSemiInclusiveModel` | SIDIS structure functions H1–H4 |
| `TStructFunctionArray` | Nuclear structure function input |
| `TKinematicalVariables` | Kinematic variable handler |
| `THapradConfig` | Configuration (beam energy, target, hadron) |
| `ConfigFile` | Config file parser |

## References

* I. Akushevich, N. Shumeiko, A. Soroko. *Eur. Phys. J. C* **10**, 681 (1999)
* I. Akushevich, A. Ilyichev, M. Osipenko. *Physics Letters B* **672**, 35–44 (2009)
* T. Mineeva, EG2 SIDIS RC methodology (internal document, template for RGD)

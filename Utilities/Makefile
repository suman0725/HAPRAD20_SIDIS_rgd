# ------------------------------------------------------------
# Makefile for HAPRAD_CPP Utilities (RG-D environment)
# ------------------------------------------------------------

.DELETE_ON_ERROR:

MKDIR_P := mkdir -p

BINDIR := ./bin
SRCDIR := ./src

# ROOT
ROOTCONFIG := root-config
ROOTCFLAGS := $(shell $(ROOTCONFIG) --cflags)
ROOTLDFLAGS := $(shell $(ROOTCONFIG) --ldflags)
ROOTLIBS := $(shell $(ROOTCONFIG) --libs)

# CERNLIB (now correct for JLab ifarm EL9)
CERNLIBS := -lpdflib804 -lmathlib -lphtools -lpacklib -lkernlib -lpawlib

# Compilers
CXX := c++
LD := c++

# Flags
CXXFLAGS := -g -O2 -Wall -fPIC -pthread -std=c++17 $(ROOTCFLAGS)
LDFLAGS  := -g -O2 $(ROOTLDFLAGS) -lgfortran -Wl,-rpath,$(HAPRAD_CPP)/slib

# Includes
INCLUDES := -I./include -I$(HAPRAD_CPP)

# Libraries
LIBS := \
    -L$(HAPRAD_CPP)/slib -lTRadCor \
    $(ROOTLIBS) -lMathMore \
    -L$(CERN_LIB) $(CERNLIBS)

# Programs
PROG := GetBinning GetCentroids FitPhiPQ GetRC
LIST := $(addprefix $(BINDIR)/, $(PROG))

.PHONY: all clean

# Default target
all: $(LIST)

# Linking
$(BINDIR)/%: $(BINDIR)/%.o
	@echo "Doing application" $@
	$(LD) $(LDFLAGS) $^ $(LIBS) -o $@

# Compilation
$(BINDIR)/%.o: $(SRCDIR)/%.cxx
	$(MKDIR_P) $(BINDIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

# Clean
clean:
	@rm -rf $(LIST:%=%.o) $(LIST)

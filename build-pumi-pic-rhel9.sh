source /lore/mersoj2/laces-software/scripts/loads-rhel9.sh
# UPDATE TO YOUR OWN DIRECTORY
SOURCE_DIR="${SOURCE_DIR:-/lore/mersoj2/laces-software/sources}"
# UPDATE TO YOUR OWN DIRECTORY
BUILD_DIR="${BUILD_DIR:-/lore/mersoj2/laces-software/build/}"

# LEAVE THESE ALONE (for now)
DEVICE_ARCH="${DEVICE_ARCH:-ADA89}"
DEPENDENCY_DIR="${DEPENDENCY_DIR:-/lore/mersoj2/laces-software/build/}"


CURDIR=$PWD
cd $SOURCE_DIR

git clone https://github.com/SCOREC/pumi-pic.git

export NVCC_WRAPPER_DEFAULT_COMPILER=`which mpicxx`

cmake -S $SOURCE_DIR/pumi-pic -B $BUILD_DIR/${DEVICE_ARCH}/pumi-pic \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/${DEVICE_ARCH}/pumi-pic/install \
  -DCMAKE_CXX_COMPILER=`which mpicxx` \
  -DCMAKE_C_COMPILER=`which mpicc` \
  -DENABLE_CABANA=ON \
  -DOmega_h_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/omega_h/install/lib64/cmake/Omega_h/ \
  -DKokkos_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/kokkos/install/lib64/cmake/Kokkos/ \
  -DCabana_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/Cabana/install/share/cmake/Cabana/ \
  -DEnGPar_DIR=$DEPENDENCY_DIR/EnGPar/install/lib/cmake/EnGPar/

cmake --build $BUILD_DIR/${DEVICE_ARCH}/pumi-pic/ -j8 --target install
cd $CURDIR

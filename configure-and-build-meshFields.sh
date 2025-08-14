SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
export NVCC_WRAPPER_DEFAULT_COMPILER=`which mpicxx`

git clone git@github.com:SCOREC/meshFields.git

cmake -S $SOURCE_DIR/meshFields -B $BUILD_DIR/${DEVICE_ARCH}/meshFields \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/${DEVICE_ARCH}/meshFields/install \
  -DOmega_h_DIR=$BUILD_DIR/${DEVICE_ARCH}/omega_h/install/lib64/cmake/Omega_h/ \
  -DKokkos_DIR=$BUILD_DIR/${DEVICE_ARCH}/kokkos/install/lib64/cmake/Kokkos/ \

cmake --build $BUILD_DIR/${DEVICE_ARCH}/meshFields/ -j8 --target install
cd $CURDIR

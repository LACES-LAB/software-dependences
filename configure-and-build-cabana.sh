SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
export NVCC_WRAPPER_DEFAULT_COMPILER=`which mpicxx`

git clone https://github.com/ECP-copa/Cabana.git

ENABLE_CUDA=ON
if [ "${DEVICE_ARCH}" = "NATIVE" ]; then
  echo "BUILDING WITH NATIVE CPU ARCH"
  ENABLE_CUDA=OFF
fi

cmake -S $SOURCE_DIR/Cabana -B $BUILD_DIR/${DEVICE_ARCH}/Cabana \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/${DEVICE_ARCH}/Cabana/install \
  -DCMAKE_CXX_COMPILER=`which mpicxx` \
  -DCMAKE_C_COMPILER=`which mpicc` \
  -DKokkos_DIR=$BUILD_DIR/${DEVICE_ARCH}/kokkos/install/lib64/cmake/Kokkos/ \
  -DCabana_REQUIRE_CUDA=${ENABLE_CUDA} \
  -DCabana_ENABLE_TESTING=OFF \
  -DCabana_ENABLE_EXAMPLES=OFF

cmake --build $BUILD_DIR/${DEVICE_ARCH}/Cabana/ -j8 --target install
cd $CURDIR

SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR

export NVCC_WRAPPER_DEFAULT_COMPILER=`which mpicxx`
git clone git@github.com:kokkos/kokkos-kernels.git
cd kokkos-kernels
git checkout tags/4.5.01
cd ..

cmake -S $SOURCE_DIR/kokkos-kernels -B $BUILD_DIR/${DEVICE_ARCH}/kokkos-kernels \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/${DEVICE_ARCH}/kokkos-kernels/install \
  -DCMAKE_CXX_STANDARD=17 \
  -DKokkos_DIR=$BUILD_DIR/${DEVICE_ARCH}/kokkos/install/lib64/cmake/Kokkos/ \
  -DBUILD_SHARED_LIBS=ON 



cmake --build $BUILD_DIR/${DEVICE_ARCH}/kokkos-kernels -j8 --target install
cd $CURDIR

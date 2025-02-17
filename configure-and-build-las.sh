SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR

git clone https://github.com/jacobmerson/las.git

export PKG_CONFIG_PATH=${BUILD_DIR}/petsc/lib/pkgconfig/:$PKG_CONFIG_PATH

cmake -S ${SOURCE_DIR}/las -B ${BUILD_DIR}/las \
 -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/las/install \
 -DCMAKE_C_COMPILER=mpicc \
 -DCMAKE_CXX_COMPILER=mpicxx \
 -DWITH_PUMI=ON \
 -DBUILD_SPARSKIT=ON \
 -DWITH_MPI=ON \
 -DWITH_PETSC=ON \
 -DSCOREC_DIR=${BUILD_DIR}/core/install/lib/cmake/SCOREC

cmake --build $BUILD_DIR/las -j8 --target install
cd $CURDIR

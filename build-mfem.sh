# this script will configure and build mfem

source /users/mersoj2/laces-software/scripts/loads-rhel9.sh
# UPDATE TO YOUR OWN DIRECTORY
SOURCE_DIR="${SOURCE_DIR:-/users/mersoj2/laces-software/sources}"
# UPDATE TO YOUR OWN DIRECTORY
BUILD_DIR="${BUILD_DIR:-/users/mersoj2/laces-software/build/}"

# LEAVE THESE ALONE (for now)
DEVICE_ARCH="${DEVICE_ARCH:-ADA89}"
DEPENDENCY_DIR="${DEPENDENCY_DIR:-/users/mersoj2/laces-software/build/}"


export NVCC_WRAPPER_DEFAULT_COMPILER=`which mpicxx`

CURDIR=$PWD
cd $SOURCE_DIR

# checkout sources
git clone https://github.com/mfem/mfem.git

export PKG_CONFIG_PATH=${DEPENDENCY_DIR}/petsc/lib/pkgconfig/:$PKG_CONFIG_PATH

cmake -S $SOURCE_DIR/mfem -B $BUILD_DIR/mfem \
	-DCMAKE_CXX_COMPILER=g++ \
	-DCMAKE_C_COMPILER=gcc \
	-DMFEM_USE_MPI=OFF \
	-DMFEM_USE_PETSC=OFF \
	-DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/mfem/install

cmake --build $BUILD_DIR/mfem -j8 --target install

cd $CURDIR

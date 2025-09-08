# this script will configure and build amsi and mumfim
# we don't treat amsi as a separate dependency since they are tightly coupled

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
git clone https://github.com/SCOREC/amsi
git clone -b mumfim-torch-damage https://github.com/jacobmerson/mumfim.git

# configure amsi
cmake -S $SOURCE_DIR/amsi -B $BUILD_DIR/amsi \
	-DCMAKE_CXX_COMPILER=mpicxx \
	-DCMAKE_C_COMPILER=mpicc \
	-DBUILD_EXTERNAL=OFF \
	-DSCOREC_DIR=${DEPENDENCY_DIR}/core/install/lib/cmake/SCOREC \
	-Dyaml-cpp_DIR=${DEPENDENCY_DIR}/yaml-cpp/install/lib64/cmake/yaml-cpp \
	-DENABLE_ZOLTAN=OFF \
	-DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/amsi/install

# build amsi
cmake --build $BUILD_DIR/amsi -j8 --target install

export PKG_CONFIG_PATH=${DEPENDENCY_DIR}/petsc/lib/pkgconfig/:$PKG_CONFIG_PATH

# configure mumfim
cmake -S $SOURCE_DIR/mumfim -B $BUILD_DIR/${DEVICE_ARCH}/mumfim \
	-DCMAKE_CXX_COMPILER=mpicxx \
	-DCMAKE_C_COMPILER=mpicc \
	-DBUILD_EXTERNAL=OFF \
	-Damsi_DIR=${BUILD_DIR}/amsi/install/lib/cmake/amsi \
	-Dyaml-cpp_DIR=${DEPENDENCY_DIR}/yaml-cpp/install/lib64/cmake/yaml-cpp \
	-DSCOREC_DIR=${DEPENDENCY_DIR}/core/install/lib/cmake/SCOREC \
	-DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${DEVICE_ARCH}/mumfim/install \
        -DCatch2_DIR=${DEPENDENCY_DIR}/Catch2/install/lib64/cmake/Catch2 \
	-Dlas_DIR=${DEPENDENCY_DIR}/las/install/lib/cmake/las/ \
	-DModelTraits_DIR=${DEPENDENCY_DIR}/model-traits/install/lib64/cmake/ModelTraits/ \
	-Dfmt_DIR=${DEPENDENCY_DIR}/fmt/install/lib64/cmake/fmt \
	-DKokkos_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/kokkos/install/lib64/cmake/Kokkos/ \
	-DKokkosKernels_DIR=$DEPENDENCY_DIR/${DEVICE_ARCH}/kokkos-kernels/install/lib64/cmake/KokkosKernels/



# build mumfim
cmake --build $BUILD_DIR/${DEVICE_ARCH}/mumfim -j8 --target install


cd $CURDIR

SOURCE_DIR=$1
BUILD_DIR=$2
SCRIPT_DIR=$3

CURDIR=$PWD
cd $SOURCE_DIR

PATCH_FILE=${SCRIPT_DIR}/patches/pumi-2-7.patch

git clone https://github.com/SCOREC/core.git
cd core
git checkout v2.2.7
git submodule init
git submodule sync
git submodule update
git apply --stat ${PATCH_FILE}
git apply ${PATCH_FILE}
cd ..

cmake -S $SOURCE_DIR/core -B $BUILD_DIR/core \
 -DCMAKE_C_COMPILER=mpicc \
 -DCMAKE_CXX_COMPILER=mpicxx \
 -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/core/install \
 -DENABLE_SIMMETRIX=OFF \
 -DENABLE_OMEGA_H=OFF \
 -DSIM_MPI=mpich4.1.1 \
 -DSKIP_SIMMETRIX_VERSION_CHECK=ON

cmake --build $BUILD_DIR/core/ -j8 --target install
cd $CURDIR

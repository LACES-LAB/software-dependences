SOURCE_DIR=$1
BUILD_DIR=$2
SCRIPT_DIR=$3

CURDIR=$PWD
cd $SOURCE_DIR

git clone https://github.com/SCOREC/EnGPar.git
cd EnGPar
git submodule init
git submodule sync
git submodule update
cd ..

cmake -S $SOURCE_DIR/EnGPar -B $BUILD_DIR/EnGPar \
 -DCMAKE_C_COMPILER=mpicc \
 -DCMAKE_CXX_COMPILER=mpicxx \
 -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/EnGPar/install \
 -DSCOREC_PREFIX=$BUILD_DIR/core/

cmake --build $BUILD_DIR/EnGPar/ -j8 --target install
cd $CURDIR

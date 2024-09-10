SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR

git clone git@github.com:ornladios/ADIOS2.git

cmake -S $SOURCE_DIR/ADIOS2 -B $BUILD_DIR/adios2 \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/adios2/install \
  -DADIOS2_USE_CUDA=OFF 

cmake --build $BUILD_DIR/adios2/ -j8 --target install
cd $CURDIR

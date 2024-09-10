SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR

git clone git@github.com:UO-OACISS/perfstubs.git

cmake -S $SOURCE_DIR/perfstubs -B $BUILD_DIR/perfstubs \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/perfstubs/install \
  -DCMAKE_CXX_COMPILER=`which mpicxx`

cmake --build $BUILD_DIR/perfstubs -j8 --target install
cd $CURDIR

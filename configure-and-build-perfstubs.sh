SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR

git clone git@github.com:UO-OACISS/perfstubs.git
cd perfstubs
# https://github.com/SCOREC/pcms/blob/462d4bd7cc4ce72fd17226296283b6af8f3084a7/.github/workflows/cmake-test.yml#L128
git checkout a1fa3feb1d89214e28047f166500351074b5f0c2
cd ..

cmake -S $SOURCE_DIR/perfstubs -B $BUILD_DIR/perfstubs \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/perfstubs/install \
  -DCMAKE_CXX_COMPILER=`which mpicxx`

cmake --build $BUILD_DIR/perfstubs -j8 --target install
cd $CURDIR

SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
echo "SOURCE_DIR $SOURCE_DIR"

#git clone -b v2.13.8 https://github.com/catchorg/Catch2
git clone https://github.com/catchorg/Catch2

cmake -S $SOURCE_DIR/Catch2 -B $BUILD_DIR/Catch2 \
 -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/Catch2/install

cmake --build $BUILD_DIR/Catch2/ -j8 --target install
cd $CURDIR

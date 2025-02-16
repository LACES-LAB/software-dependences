SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
echo "SOURCE_DIR $SOURCE_DIR"

#git clone -b v2.13.8 https://github.com/catchorg/Catch2
git clone https://github.com/fmtlib/fmt.git

cmake -S $SOURCE_DIR/fmt -B $BUILD_DIR/fmt \
 -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/fmt/install

cmake --build $BUILD_DIR/fmt/ -j8 --target install
cd $CURDIR

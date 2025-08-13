SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
echo "SOURCE_DIR $SOURCE_DIR"

git clone https://github.com/gabime/spdlog.git

cmake -S $SOURCE_DIR/spdlog -B $BUILD_DIR/spdlog \
 -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/spdlog/install

cmake --build $BUILD_DIR/spdlog/ -j8 --target install
cd $CURDIR

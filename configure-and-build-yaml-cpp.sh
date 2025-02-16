SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
echo "SOURCE_DIR $SOURCE_DIR"

git clone https://github.com/jbeder/yaml-cpp

cmake -S $SOURCE_DIR/yaml-cpp -B $BUILD_DIR/yaml-cpp \
 -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/yaml-cpp/install

cmake --build $BUILD_DIR/yaml-cpp/ -j8 --target install
cd $CURDIR

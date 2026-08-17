SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
echo "SOURCE_DIR $SOURCE_DIR"

git clone -b v2.12.0 https://github.com/pybind/pybind11.git

cmake -S $SOURCE_DIR/pybind11 -B $BUILD_DIR/pybind11 \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/pybind11/install \
  -DPYBIND11_TEST=OFF \
  -DPYBIND11_FINDPYTHON=ON \
  -DPython_EXECUTABLE=$(which python)

cmake --build $BUILD_DIR/pybind11/ -j8 --target install
cd $CURDIR

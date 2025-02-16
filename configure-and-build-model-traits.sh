SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR

git clone git@github.com:jacobmerson/model-traits.git

cmake -S $SOURCE_DIR/model-traits -B $BUILD_DIR/model-traits \
  -DCMAKE_CXX_COMPILER=mpicxx \
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/model-traits/install \
  -DCMAKE_CXX_STANDARD=17 \
  -DMODEL_TRAITS_ENABLE_SIMMETRIX=OFF \
  -DMODEL_TRAITS_ENABLE_YAML=ON \
  -DMODEL_TRAITS_ENABLE_SCOREC=ON \
  -DMODEL_TRAITS_BUILD_EXTERNAL=OFF \
  -Dfmt_DIR=${BUILD_DIR}/fmt/install/lib64/cmake/fmt \
  -Dyaml-cpp_DIR=${BUILD_DIR}/yaml-cpp/install/lib64/cmake/yaml-cpp \
  -DSCOREC_DIR=${BUILD_DIR}/core/install/lib/cmake/SCOREC \
  -DCatch2_DIR=${BUILD_DIR}/Catch2/install/lib64/cmake/Catch2



cmake --build $BUILD_DIR/model-traits -j8 --target install
cd $CURDIR

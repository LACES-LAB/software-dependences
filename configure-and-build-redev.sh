SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR

git clone git@github.com:SCOREC/redev.git
cd redev
# use the same version of redev as is used in CI
# https://github.com/SCOREC/pcms/blob/462d4bd7cc4ce72fd17226296283b6af8f3084a7/.github/workflows/cmake-test.yml#L146
git checkout ac09848a5f9b89493e8b679c9080b9efe5538376
cd ..

cmake -S $SOURCE_DIR/redev -B $BUILD_DIR/${DEVICE_ARCH}/redev \
	-DCMAKE_INSTALL_PREFIX=$BUILD_DIR/${DEVICE_ARCH}/redev/install/ \
	-DCMAKE_CXX_COMPILER=`which mpicxx` \
	-DMPIEXEC_EXECUTABLE=`which mpirun` \
	-DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DADIOS2_DIR=$BUILD_DIR/adios2/install/lib64/cmake/adios2/ \
  -Dperfstubs_DIR=$BUILD_DIR/perfstubs/install/lib/cmake/


cmake --build $BUILD_DIR/${DEVICE_ARCH}/redev/ -j8 --target install
cd $CURDIR

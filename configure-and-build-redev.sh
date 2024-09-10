SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR

git clone git@github.com:jacobmerson/redev.git

cmake -S $SOURCE_DIR/redev -B $BUILD_DIR/${DEVICE_ARCH}/redev \
	-DCMAKE_INSTALL_PREFIX=$BUILD_DIR/${DEVICE_ARCH}/redev/install/ \
	-DCMAKE_CXX_COMPILER=`which mpicxx` \
	-DMPIEXEC_EXECUTABLE=`which mpirun` \
	-DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DADIOS2_DIR=$BUILD_DIR/adios2/install/lib64/cmake/adios2/ \
  -Dperfstubs_DIR=$BUILD_DIR/perfstubs/install/lib64/cmake/


cmake --build $BUILD_DIR/${DEVICE_ARCH}/redev/ -j8 --target install
cd $CURDIR

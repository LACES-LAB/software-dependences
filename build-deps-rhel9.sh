DIR=$PWD

source $DIR/loads-rhel9.sh



SOURCE_DIR="${SOURCE_DIR:-/lore/mersoj2/laces-software/sources}"
BUILD_DIR="${BUILD_DIR:-/lore/mersoj2/laces-software/build/}"
DEVICE_ARCH="${DEVICE_ARCH:-ADA89}"

mkdir $SOURCE_DIR
cd $SOURCE_DIR


source $DIR/configure-and-build-catch2.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-kokkos.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-omega-h.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-perfstubs.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-flcl.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-adios2.sh $SOURCE_DIR $BUILD_DIR
source $DIR/configure-and-build-redev.sh $SOURCE_DIR $BUILD_DIR 

cd $DIR

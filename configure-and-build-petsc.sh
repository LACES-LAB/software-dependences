SOURCE_DIR=$1
BUILD_DIR=$2

CURDIR=$PWD
cd $SOURCE_DIR
git clone https://github.com/petsc/petsc

cd petsc
git checkout main

./configure --with-cc=mpicc --with-cxx=mpicxx --with-fc=mpifort \
	--prefix=$BUILD_DIR/petsc/ \
	--with-blaslapack-dir=$NETLIB_LAPACK_RHEL9_ROOT \
	--with-scalapack-dir=$NETLIB_SCALAPACK_RHEL9_ROOT



	#--with-blas-lib=$NETLIB_LAPACK_RHEL9_ROOT/lib64/libblas.so \
        #--with-lapack-dir=$NETLIB_LAPACK_RHEL9_ROOT/lib64/ \
make PETSC_DIR=/lore/mersoj2/laces-software/sources/petsc PETSC_ARCH=arch-linux-c-debug all
make PETSC_DIR=/lore/mersoj2/laces-software/sources/petsc PETSC_ARCH=arch-linux-c-debug install

cd $CURDIR

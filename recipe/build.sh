export CC=$(which gcc)
export CXX=$(which g++)
export FC=$(which gfortran)
export F77=$FC
export F90=$FC
export F03=$FC

if [ $(uname) == Darwin ]; then
  export JAVAPREFIX=$(/usr/libexec/java_home)
else
  export JAVAPREFIX="${JAVA_HOME:-/usr/java/default}"
fi
export JAVA=$JAVAPREFIX/bin/java

export PYTHON=$PREFIX/bin/python
export PATH=$JAVAPREFIX/bin:$PATH

if [! -d "$PREFIX/lib64" ]; then
  ln -s "$PREFIX/lib" "$PREFIX/lib64"
fi

pushd runtime/libparsifal
  ./configure --prefix=$PREFIX --disable-documentation \
    --disable-option-checking 
  make all -j$CPU_COUNT
  make install
popd

rm "$PREFIX"/lib64 || echo "Unable to remove $PREFIX/lib64"

PYTHON_ARCH=${1:?}

DIST_FILE=cpython-${PYTHON_VERSION}+${PYTHON_DIST_RELEASE}-${PYTHON_ARCH}_v4-unknown-linux-gnu-install_only.tar.gz
curl -OL https://github.com/indygreg/python-build-standalone/releases/download/${PYTHON_DIST_RELEASE}/${DIST_FILE}
mkdir -p $PYTHON_ARCH/build
tar zxvf $DIST_FILE -C $PYTHON_ARCH/build

# copy build to dist
mkdir -p $PYTHON_ARCH/dist
rsync -av --exclude-from=python-linux-dart.exclude $PYTHON_ARCH/build/* $PYTHON_ARCH/dist

# compile lib
python -m compileall -b $PYTHON_ARCH/dist/lib/python3.12

# archive
tar -czf python-linux-dart-$PYTHON_VERSION_SHORT-$PYTHON_ARCH.tar.gz -C $PYTHON_ARCH/dist .
#!/bin/bash
set -e

## get absolute parent folder of current script
PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd) 
BUILD_DIR=$PROJECT_DIR/build
mkdir -p $BUILD_DIR

# Generate lock file for reproducible builds
uv lock

# Export to requirements.txt for Lambda
uv export --format requirements-txt --no-hashes > requirements.txt

#ARCH x86_64 aarch64, default with x86_64
ARCH=${1:-x86_64}
PIP_ARCH=$ARCH
## if arch is aarch64, set ARCH to aarch64
if [ "$ARCH" = "arm64" ]; then
    PIP_ARCH=aarch64
fi

FOLDER=$BUILD_DIR/$ARCH
OUTPUT=lambda-venv-$ARCH.zip
# Create build directory
mkdir -p $FOLDER/

# Install to build directory with Lambda-compatible wheels
uv pip install --platform manylinux2014_$PIP_ARCH --only-binary=:all: \
    --python-version 3.12 --target $FOLDER/ \
    -r requirements.txt

# Copy application code

# Create deployment package
cd $FOLDER && zip -r ../$OUTPUT . && cd ..

# Cleanup
rm requirements.txt
rm -r $FOLDER

echo "✅ uv locked venv deployment package created: $BUILD_DIR/$OUTPUT"


#!/bin/bash
set -e

## get parent folder of current script
PROJECT_DIR=$(cd "$(dirname "$0")/.." && pwd) 
BUILD_DIR=$PROJECT_DIR/build
mkdir -p $BUILD_DIR

OUTPUT=lambda-lib.zip

find $PROJECT_DIR/src/ -name "*.pyc" -delete
find $PROJECT_DIR/src/ -name "__pycache__" -type d -exec rm -rf {} +

## zip all folders and files except aws_lambda.py in src
cd $PROJECT_DIR/src && zip -r $BUILD_DIR/$OUTPUT . -x "aws_lambda.py" && cd $PROJECT_DIR
echo "✅ library deployment package created: $BUILD_DIR/$OUTPUT"
# Generate lock file for reproducible builds

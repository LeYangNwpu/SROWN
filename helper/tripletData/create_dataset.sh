#!/usr/bin/env sh
# This script extracts the images from mnist dataset,
# and generate triplets for similarity learning.

echo "Generate validation batches ..."
python /disk1/yangle/code/tripletData/generate_batch.py /disk1/yangle/dataset/tripletData/train.lst /disk1/yangle/dataset/tripletData/train.bat 10 10

echo "Done!"

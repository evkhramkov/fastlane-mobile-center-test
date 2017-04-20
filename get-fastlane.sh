#!/bin/sh

root_dir=$PWD

cd ../

git clone https://github.com/evkhramkov/fastlane.git
cd "fastlane"
git checkout mobile-center

cd $root_dir
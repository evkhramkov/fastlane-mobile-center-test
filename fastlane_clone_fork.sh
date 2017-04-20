#!/bin/sh

# this task clones forked fastlane into according to ./Gemfile dependency place
# than switched to mobile-center branch

cd ../
git clone https://github.com/evkhramkov/fastlane.git
cd fastlane
git checkout mobile-center

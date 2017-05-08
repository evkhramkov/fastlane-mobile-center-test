#!/bin/sh

# this task runs unit tests for fastlane mobile_center_upload action

export PATH=$PATH:$PWD/fake-bin/
cd ../fastlane
bundle install --quiet

echo ================================================================================
echo ========================== RUNNING UNIT TESTS ==================================
echo ================================================================================

DEBUG=true bundle exec rspec ./fastlane/spec/actions_specs/mobile_center_upload_spec.rb

echo ================================================================================
echo ========================= USING FORKED FASTLANE ================================
echo ================================================================================
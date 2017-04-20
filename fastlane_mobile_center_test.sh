#!/bin/sh

# this task runs unit tests for fastlane mobile_center_upload action

cp ./xcode-select ../fastlane
cd ../fastlane
DEBUG=true bundle exec rspec ./fastlane/spec/actions_specs/mobile_center_upload_spec.rb

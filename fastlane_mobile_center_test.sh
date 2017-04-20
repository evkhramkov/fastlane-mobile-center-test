#!/bin/sh

# this task runs unit tests for fastlane mobile_center_upload action

cd ../fastlane
DEBUG=true bundle exec rspec ./fastlane/spec/actions_specs/mobile_center_upload_spec.rb

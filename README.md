[![Build Status](https://travis-ci.org/evkhramkov/fastlane-mobile-center-test.svg?branch=master)](https://travis-ci.org/evkhramkov/fastlane-mobile-center-test)

# Testing mobile center integration project for [fastlane fork](https://github.com/evkhramkov/fastlane)

## Travis test

- clone fastlane fork from [https://github.com/evkhramkov/fastlane](https://github.com/evkhramkov/fastlane) into neighbour folder to current root
- switches to `mobile-center` branch
- runs unit tests for `mobile_Center_upload` task
- runs `bundle exec fastlane test`
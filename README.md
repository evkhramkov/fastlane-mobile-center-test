[![Build Status](https://travis-ci.org/evkhramkov/fastlane-mobile-center-test.svg?branch=master)](https://travis-ci.org/evkhramkov/fastlane-mobile-center-test)

# Testing mobile center integration project for [fastlane fork](https://github.com/evkhramkov/fastlane)

## Travis test

- clone fastlane fork from [https://github.com/evkhramkov/fastlane](https://github.com/evkhramkov/fastlane) into neighbour folder to current root
- switches to `mobile-center` branch
- runs unit tests for `mobile_Center_upload` task
- runs `bundle exec fastlane test`


# Feature parity with hockeyapp integration

## Used mobile center cli API for distribution uploads (from [mobile center swagger spec](https://github.com/Microsoft/mobile-center-cli/blob/master/swagger/bifrost.swagger.before.json) )

- `POST /v0.1/apps/{owner_name}/{app_name}/release_uploads`
  - Begins the upload process for a new release for the specified application
  - Response `201`:
    ```
    {
      "upload_id": "The ID for the current upload",
      "upload_url": "The URL where the client needs to upload the release to"
    }
    ```
- `POST {upload_url}` - release upload
- `PATCH /v0.1/apps/{owner_name}/{app_name}/release_uploads/{upload_id}`
  - Commits or aborts the upload process for a release for the specified application
  - Body: `{ status: "committed" | "aborted" }`
  - Response `200`:
    ```
    {
      "release_url": "A URL to the new release. If upload was aborted will be null"
    }
    ```
- `PATCH /v0.1/apps/{owner_name}/{app_name}/releases/{release_id}`
  - Updates release with distribution group and release notes
  - Body: 
    ```
    {
      "distribution_group_name": string,
      "distribution_group_id": string,
      "release_notes": string
    }
    ```
  - Response `200`: Details of an uploaded release
    ```
    {
      "id": "...",
      "status": "...",
      "app_name": "...",
      "app_display_name": "...",
      "version" "...",
      "short_version": "...",
      "release_notes": "...",
      "provisioning_profile_name": "...",
      "provisioning_profile_type": "...",
      "size": "...",
      "min_os": "...",
      "android_min_api_level": "...",
      "bundle_identifier" "...",
      "fingerprint": "...",
      "uploaded_at": "...",
      "download_url": "...",
      "app_icon_url" "...",
      "install_url": "...",
      "distribution_groups" "...",
    }
    ```
- `POST /v0.1/apps/{owner_name}/{app_name}/symbol_uploads`
  - Begins the symbol upload process for a new set of symbols for the specified application
  - Response `201`:
    ```
    {
      "symbol_upload_id": "The id for the current upload",
      "upload_url": "The URL where the client needs to upload the symbol blob to",
      "expiration_date": "Describes how long the upload_url is valid"
    }
    ```
- `PUT {upload_url}` - dSYM upload
- `PATCH /v0.1/apps/{owner_name}/{app_name}/symbol_uploads/{symbol_upload_id}`
  - Commits or aborts the symbol upload process for a new set of symbols for the specified application
  - Body: `{ status: "committed" | "aborted" }`
  - Response `200`:
    ```
    {
       "symbol_upload_id": "The id for the current symbol upload",
        "app_id": "The application that this symbol upload belongs to",
        "status": "The current status for the symbol upload",
        "symbol_type": "The type of the symbol for the current symbol upload",
        "symbols": "The symbol ids",
        "origin": "The origin of the symbol upload"
    }
    ```

## `hockeyapp` and `mobile_center_upload` options comparison

option name            | hockeyapp | mobile center          | description
---------------------- | --------- | -------------------    | -----------
`api_token`            | [x]       | [x]                    | Api Token
`owner_name`           | [ ]       | [x]                    | Mobile center user name
`app_name`             | [ ]       | [x]                    | Mobile center app name
`apk`                  | [x]       | [x]                    | Path to your APK file
`ipa`                  | [x]       | [x]                    | Path to your IPA file
`dsym`                 | [x]       | [x]                    | Path to your symbols file
`upload_dsym_only`     | [x]       | [x]                    | Flag to upload only the dSYM file to hockey app
`notes`                | [x]       | [x] as `release_notes` | Release Notes
`group`                | [ ]       | [x]                    | Distribute group name
`teams`                | [x]       | [ ]                    | Comma separated list of team ID numbers to which this build will be restricted
`create_update`        | [x]       | [ ]                    | Set true if you want to create then update your app as opposed to just upload it.
`notify`               | [x]       | [ ]                    | Notify testers? '1' for yes
`status`               | [x]       | [ ]                    | Download status: '1' = No user can download; '2' = Available for download
`notes_type`           | [x]       | [ ]                    | Notes type for your :notes, '0' = Textile, '1' = Markdown (default)
`release_type`         | [x]       | [ ]                    | Release type of the app: '0' = Beta (default), '1' = Store, '2' = Alpha, '3' = Enterprise
`mandatory`            | [x]       | [ ]                    | Set to '1' to make this update mandatory
`users`                | [x]       | [ ]                    | Comma separated list of user ID numbers to which this build will be restricted
`tags`                 | [x]       | [ ]                    | Comma separated list of tags which will receive access to the build
`bundle_short_version` | [x]       | [ ]                    | The bundle_short_version of your application, required when using `create_update`
`bundle_version`       | [x]       | [ ]                    | The bundle_version of your application, required when using `create_update`
`public_identifier`    | [x]       | [ ]                    | App id of the app you are targeting, usually you won't need this value. Required, if `upload_dsym_only` set to `true`
`commit_sha`           | [x]       | [ ]                    | The Git commit SHA for this build
`repository_url`       | [x]       | [ ]                    | The URL of your source repository
`build_server_url`     | [x]       | [ ]                    | The URL of the build job on your build server
`owner_id`             | [x]       | [ ]                    | ID for the owner of the app
`strategy`             | [x]       | [ ]                    | Strategy: 'add' = to add the build as a new build even if it has the same build number (default); 'replace' = to replace a build with the same build number
`bypass_cdn`           | [x]       | [ ]                    | Flag to bypass Hockey CDN when it uploads successfully but reports error
`dsa_signature`        | [x]       | [ ]                    | DSA signature for sparkle updates for macOS
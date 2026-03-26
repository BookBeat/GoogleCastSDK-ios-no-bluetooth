# GoogleCastSDK-ios-no-bluetooth
This is a repository to provide an SPM package for the Google Cast SDK since they only provide a CocoaPod version. This repo should be deprecated as soon as they provide an SPM.

## How to add a new version
As of now (2023-05-31) new versions are provided from the Google developer site: https://developers.google.com/cast/docs/ios_sender#xcframework

1. Download the dynamic xcframework file and rename to `GoogleCast.xcframework.zip`
2. Create a new branch from `main`.
3. Update the Package.swift file:
    1. Update the version string to the new version `X.X.X`
    2. Calculate the zip checksum using swift package compute-checksum /path/to/GoogleCastSDK.zip and update the checksum string
4. Unzip the file
5. Run the `generate_license.rb` script, passing an **absolute** path to the `OpenSourceLicenses` directory that's part of the unzipped folder: `ruby generate_license.rb /path/to/GoogleCastSDK-ios-x.y.z-xcframework/OpenSourceLicenses`
6. Create a PR.
7. When the PR is Approved, merge to `main`.
8. Create a tag with the new version number with `git tag X.X.X` that matches the Google release version
9. Run `git push --tags`

10. Go to the app repo and update the SPM reference to the tag you just created. Fix any build errors that the new version might introduce. You might have to delete `DerivedData` before the changes are available in the app.

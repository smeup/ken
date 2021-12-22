# ken publish procedure

Follow the steps below to publish a new version

- make your changes to the code

- update the documentation with the following command:

  `dartdoc --format "md"`

- update the version in the pubspec.yaml

- document the version in the CHANGELOG.md file

- Check the release with the following command:

  `dart pub publish --dry-run`

- Run the following command to publish the new version:

  `dart pub publish`

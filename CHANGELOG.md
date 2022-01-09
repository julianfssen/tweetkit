# Changelog
All notable changes to `tweetkit` will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2022-01-09
### Added
- Added the ability to add OAuth tokens when setting up the client instance. Credit to @rofreg
- Added OAuth as an option to authenticate requests. Credit to @rofreg
- Added the `post_tweet` method to post tweets via OAuth. Credit to @rofreg
- Added the `delete_tweet` method to delete tweets via OAuth. Credit to @rofreg
- Added tests for the `Tweets` module.
- Added tests for the `Search` module.
- Added tests for search building and cleaning in the `Conjunctions` class.
### Changed
- Updated client responses to return a `Tweetkit::Response` object. The `Tweetkit::Response` object contains a `Tweets` object that is made up of `Tweet` objects that contain the data for each respective tweet. `Fields` and `Expansions` objects are also available depending on the fields and expansions made in the request.
- Moved search building and cleaning logic to the `Conjunctions` class.
- Fixed wrong config key names when setting up the client. Credit to @dewey
### Removed
- No changes

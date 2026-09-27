# Changelog

## [1.0.3](https://github.com/kidager/telegram-bot-api/compare/v1.0.2...v1.0.3) (2026-09-27)


### Bug Fixes

* **ci:** read the version from stderr in the smoke test ([2ffb5ea](https://github.com/kidager/telegram-bot-api/commit/2ffb5eabf642a3424e937a2539c64725a3abaec4))


### Performance Improvements

* **ci:** fast native multi-arch builds and release-please ([a6969a5](https://github.com/kidager/telegram-bot-api/commit/a6969a5da29c8891749b9985064f4be6a27c6a66))
* **docker:** build with clang and ccache, pin alpine by digest ([8fafd8c](https://github.com/kidager/telegram-bot-api/commit/8fafd8c2d183dac549667127c430b41979023b79))


### Continuous Integration

* **build:** add native multi-arch PR build with caches and weekly clean build ([b2c1c7d](https://github.com/kidager/telegram-bot-api/commit/b2c1c7d6c0b9c22ce2110b5fa0fe0b8a8354cd44))
* **build:** drop the weekly clean build, rely on dependabot PRs ([b88a77f](https://github.com/kidager/telegram-bot-api/commit/b88a77f1d634c3c45c5c489b28cb3490399e1632))
* **deploy:** build each arch on a native runner and merge the manifest ([b8b761c](https://github.com/kidager/telegram-bot-api/commit/b8b761ca8dedb4d6d01f4ab8d33df0a27d162601))
* **release:** add release-please ([bd29dec](https://github.com/kidager/telegram-bot-api/commit/bd29dec7e5929a15247b3f7d158302c3f52874a5))
* **release:** publish images from the release-please workflow without a PAT ([2f55664](https://github.com/kidager/telegram-bot-api/commit/2f55664cae114b73c35cfc0c0e5fdd174ca0a5da))

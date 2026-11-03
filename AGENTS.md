# Development guide

This pure Dart package registers Grinder tasks. It is unlisted on pub.dev and
no longer used by its author; existing releases remain available. Keep maintenance
focused on compatibility and the requested fixes.

## Safe verification

Run from the repository root using stable Dart:

```sh
dart pub get
(cd example && dart pub get)
dart analyze --fatal-infos
(cd example && dart run tool/grind.dart --help)
git diff --check
```

The `--help` command should list `build`, `b`, `watch`, `w`, `serveWeb`, `sw`,
`updatePods`, and `up`. It registers tasks without executing them. This verifies
compilation and task registration, not the effects of the tasks themselves.

Do not run a real Grinder task as a smoke check. In particular, `updatePods`/`up`
delete Pods and Podfile.lock and run Flutter/CocoaPods commands; build/watch and
serveWeb also start external tooling. Validate command construction with isolated
tests when changing task behavior. Run an actual task only when the request
specifically calls for it in an appropriate disposable project.

There is currently no `test/` suite. Do not claim `dart test` passed. If behavior
changes introduce tests, run those tests and retain the `--help` check. For
documentation-only changes, check links and command accuracy instead of running
unrelated tasks. Report actual checks and limitations.

## Compatibility and dependencies

- The published library declares Dart 2.17 support. Keep that floor unless the
  requested change requires an intentional compatibility change.
- Development dependencies have newer SDK requirements, so successful stable
  analysis does not prove Dart 2.17 consumer compatibility. When changing `lib/`
  or runtime dependencies, check a separate consumer on the minimum SDK without
  this repository's development dependencies.
- `example/` is a separate package with a path dependency on the library. Resolve
  dependencies in both directories; monthly Dependabot covers both and Actions.
- Use `dart pub outdated` in each package for dependency work. Avoid adding
  Flutter app infrastructure or MCP tooling to this command-line package.

## Working with existing changes

- Inspect `git status`, the current branch, and matching open pull requests
  before editing. Continue the task's existing branch/PR when applicable,
  preserve unrelated work, and avoid duplicate maintenance PRs.
- Treat publishing, tagging, merging, or changing the pub.dev listing as separate
  operations; do not infer them from a routine maintenance request.

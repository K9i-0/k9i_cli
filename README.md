# k9i_cli
This dart package provides Grinder tasks used by K9i, allowing for the sharing of Grinder tasks across multiple projects.

## Usage
```
import 'package:grinder/grinder.dart';
import 'package:k9i_cli/k9i_cli.dart';

void main(List<String> args) {
  // Add all tasks from the k9i_cli package.
  addAllTasks(enableAlias: true, useFvm: true); // set useFvm to true if you're using Flutter Version Management

  grind(args);
}
```
### Using the useFvm parameter
By default, the addAllTasks method uses the standard Flutter command. However, if you are using the Flutter Version Management (FVM), you can set the useFvm parameter to true to prefix the commands with fvm flutter. This allows you to execute tasks with the specific Flutter version set by FVM.

## Available tasks
```
Available tasks:
  build                flutter pub run build_runner build --delete-conflicting-outputs
  b                    Alias for build
  watch                flutter pub run build_runner watch --delete-conflicting-outputs
  w                    Alias for watch
  serveWeb             Serve Flutter web app on local IP.
  sw                   Alias for serveWeb
  updatePods           Clean and update Pods installation.
  up                   Alias for updatePods
```
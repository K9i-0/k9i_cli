import 'dart:io';

import 'package:grinder/grinder.dart';
import 'package:k9i_cli/src/utils.dart';

/// Add all tasks from the k9i_cli package.
///
/// If [enableAlias] is `true`, aliases are added to the tasks.
void addAllTasks({bool enableAlias = false}) {
  addBuildRunnerTask(enableAlias: enableAlias);
  addServeWebTask(enableAlias: enableAlias);
  addUpdatePodsTask(enableAlias: enableAlias);
}

/// Add a task to run build_runner.
void addBuildRunnerTask({bool enableAlias = false}) {
  buildTaskFunction() =>
      runCommand(command: 'flutter pub run build_runner build -d');
  addTask(
    GrinderTask(
      'build',
      description:
          'flutter pub run build_runner build --delete-conflicting-outputs',
      taskFunction: buildTaskFunction,
    ),
  );
  if (enableAlias) {
    addTask(
      GrinderTask(
        'b',
        description: 'Alias for build',
        taskFunction: buildTaskFunction,
      ),
    );
  }

  watchTaskFunction() =>
      runCommand(command: 'flutter pub run build_runner watch -d');
  addTask(
    GrinderTask(
      'watch',
      description:
          'flutter pub run build_runner watch --delete-conflicting-outputs',
      taskFunction: watchTaskFunction,
    ),
  );
  if (enableAlias) {
    addTask(
      GrinderTask(
        'w',
        description: 'Alias for watch',
        taskFunction: watchTaskFunction,
      ),
    );
  }
}

/// Add a task to serve the web app.
void addServeWebTask({bool enableAlias = false}) {
  serveWebTaskFunction() {
    final result = Process.runSync('ifconfig', [], runInShell: true);
    if (result.exitCode != 0) {
      throw Exception(
          'ifconfig command failed with exit code ${result.exitCode}');
    }
    final output = result.stdout.toString();
    final lines = output.split('\n');
    for (var line in lines) {
      if (line.contains('inet ') && !line.contains('127.0.0.1')) {
        final ip = line.split(' ')[1];
        log(ip);
        runCommand(
          command:
              'flutter run -d web-server --web-hostname=$ip --web-port=50505',
        );
        break;
      }
    }
  }

  addTask(
    GrinderTask(
      'serveWeb',
      description: 'Serve Flutter web app on local IP.',
      taskFunction: serveWebTaskFunction,
    ),
  );
  if (enableAlias) {
    addTask(
      GrinderTask(
        'sw',
        description: 'Alias for serveWeb',
        taskFunction: serveWebTaskFunction,
      ),
    );
  }
}

/// Add a task to update pods.
void addUpdatePodsTask({bool enableAlias = false}) {
  updatePodsTaskFunction() {
    run(
      'rm',
      arguments: ['-rf', 'Pods/'],
      workingDirectory: 'ios',
    );
    run(
      'rm',
      arguments: ['-rf', 'Podfile.lock'],
      workingDirectory: 'ios',
    );
    run(
      'flutter',
      arguments: ['clean'],
    );
    run(
      'flutter',
      arguments: ['pub', 'get'],
    );
    run(
      'pod',
      arguments: ['install', '--repo-update'],
      workingDirectory: 'ios',
    );
  }

  addTask(
    GrinderTask(
      'updatePods',
      description: 'Clean and update Pods installation.',
      taskFunction: updatePodsTaskFunction,
    ),
  );
  if (enableAlias) {
    addTask(
      GrinderTask(
        'up',
        description: 'Alias for updatePods',
        taskFunction: updatePodsTaskFunction,
      ),
    );
  }
}

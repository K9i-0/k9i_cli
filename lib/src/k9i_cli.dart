import 'package:grinder/grinder.dart';
import 'package:k9i_cli/src/utils.dart';

void addAllTasks({bool enableAlias = false}) {
  addBuildRunnerTask(enableAlias: enableAlias);
}

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
      description: 'flutter pub run build_runner watch',
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

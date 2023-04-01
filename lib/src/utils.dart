import 'dart:io';

import 'package:grinder/grinder.dart';

Future<void> runCommand({
  required String command,
}) async {
  final splittedCommand = command.split(' ');
  log(command);
  final process = await Process.start(
    splittedCommand.first,
    splittedCommand.sublist(1),
  );
  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);
}

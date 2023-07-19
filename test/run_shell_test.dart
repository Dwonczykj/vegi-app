import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vegan_liverpool/utils/constants.dart';

Future<void> shell(
  String command, [
  List<String> arguments = const <String>[],
]) async {
  final process = await Process.start(command, arguments, runInShell: true);
  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);
  final exitCode = await process.exitCode;
  print('============');
  print('Exit code: $exitCode');
}

void main() async {
  group('Test Environment Integration Test', () {
    test('Environment is set to test', () async {
      // if (Platform.isWindows) {
      //   print('List Files and Directories');
      //   print('============');
      //   await shell('dir');
      // } else {
      //   await shell('ls');
      // }
      print('List Env Variables');
      print('============');
      // * These exposes the 'FLUTTER_TEST' variable =  'true'
      await shell('printenv');

      expect(DebugHelpers.isTest, true);
    });
  });
}

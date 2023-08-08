import 'package:flutter/services.dart';

// ~ https://www.kindacode.com/article/flutter-copy-to-clipboard-example-without-any-plugins/

Future<void> copyToClipboard(String? text) async {
  return Clipboard.setData(ClipboardData(text: text ?? ''));
}

Future<String?> fetchClipboardMostRecent() async {
  final ClipboardData? data = await Clipboard.getData('text/plain');
  return data?.text;
}

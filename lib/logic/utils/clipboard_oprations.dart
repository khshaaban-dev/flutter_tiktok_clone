import 'package:clipboard/clipboard.dart';

Future<bool> copyToClipboard({required String text}) {
  return FlutterClipboard.controlC(text);
}

Future<dynamic> pastFromClipboard({required String text}) {
  return FlutterClipboard.controlV();
}

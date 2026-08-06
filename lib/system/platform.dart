import 'dart:io';

import 'package:collector/system/android.dart';

Future<void> init() async {
  if (Platform.isAndroid) return await androidInit();
  throw Exception('Platform not supported');
}

String collectorPath() {
  if (Platform.isAndroid) return androidCollectorPath();
  throw Exception('Platform not supported');
}

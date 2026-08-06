import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> androidInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  var status = await Permission.manageExternalStorage.request();
  if (status.isGranted) {
    debugPrint('MANAGE_EXTERNAL_STORAGE permission granted');
  } else if (status.isDenied) {
    debugPrint('MANAGE_EXTERNAL_STORAGE permission denied');
  } else if (status.isPermanentlyDenied) {
    debugPrint('MANAGE_EXTERNAL_STORAGE permission permanently denied');
    openAppSettings();
  }
}

String androidCollectorPath() {
  return '/storage/emulated/0/Collector';
}

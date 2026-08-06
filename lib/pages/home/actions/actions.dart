import 'dart:io';
import 'package:collector/models/collection.dart';
import 'package:collector/models/menu.dart';
import 'package:collector/pages/home/signals/index.dart';
import 'package:collector/system/platform.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

Future<void> actionLoadIndex() async {
  Index menu = [];
  final directory = Directory(collectorPath());
  if (directory.existsSync()) {
    final files = directory.listSync().whereType<File>().map((file) => file.path).toList();
    files.sort();
    for (var file in files) {
      if (!file.endsWith('.db')) continue;
      CollectionName collName = basename(file).replaceFirst('.db', '');
      if (collName == 'Test' && kReleaseMode) continue;
      menu.add(MenuItem(name: collName));
    }
  }
  $index.value = menu;
}

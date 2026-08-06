import 'dart:async';

import 'package:collector/components/app.dart';
import 'package:collector/components/error.dart';
import 'package:collector/system/platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return ErrorPage(details: details);
      };
      FlutterError.onError = (FlutterErrorDetails details) {
        debugPrint('Error: ${details.exception} ${details.stack}');
      };

      if (kReleaseMode || kDebugMode) {
        SignalsObserver.instance = null;
      }
      await init();
      runApp(const CollectorApp());
    },
    (Object error, StackTrace stack) {
      debugPrint('Error: $error');
    },
  );
}

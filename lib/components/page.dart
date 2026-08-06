import 'package:collector/signals/busy.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class AppPage extends StatelessWidget {
  final Scaffold scaffold;
  const AppPage({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    if ($busy.watch(context)) {
      return Scaffold(
        body: const Center(
          child: Center(child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator(strokeWidth: 1))),
        ),
      );
    }

    return scaffold;
  }
}

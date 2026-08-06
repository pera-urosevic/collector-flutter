import 'package:collector/services/theme.dart';
import 'package:collector/pages/home/home.dart';
import 'package:flutter/material.dart';

class CollectorApp extends StatefulWidget {
  const CollectorApp({super.key});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_CollectorAppState>()?.restart();
  }

  @override
  State<CollectorApp> createState() => _CollectorAppState();
}

class _CollectorAppState extends State<CollectorApp> {
  Key key = UniqueKey();

  void restart() {
    setState(() {
      key = UniqueKey();
      debugPrint('Restarting...');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      title: 'Collector',
      theme: theme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const CollectorPage(),
    );
  }
}

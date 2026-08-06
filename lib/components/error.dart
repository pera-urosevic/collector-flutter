import 'package:collector/components/app.dart';
import 'package:collector/services/theme.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final FlutterErrorDetails details;
  const ErrorPage({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final exception = details.exceptionAsString();
    return MaterialApp(
      title: 'Collector',
      theme: theme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Something went wrong...')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('😱', style: TextStyle(fontSize: 42), textAlign: TextAlign.center),
                if (exception.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(height: 12),
                      Text(exception, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Text(
                            details.stack.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Color.fromARGB(92, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 40),
                ElevatedButton(onPressed: () => CollectorApp.restartApp(context), child: const Text('Restart')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

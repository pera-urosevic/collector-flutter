import 'package:collector/components/page.dart';
import 'package:collector/pages/home/actions/actions.dart';
import 'package:collector/pages/home/components/menu.dart';
import 'package:flutter/material.dart';

class CollectorPage extends StatefulWidget {
  const CollectorPage({super.key});

  @override
  State<CollectorPage> createState() => _CollectorPageState();
}

class _CollectorPageState extends State<CollectorPage> {
  @override
  void initState() {
    actionLoadIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(scaffold: Scaffold(body: Menu()));
  }
}

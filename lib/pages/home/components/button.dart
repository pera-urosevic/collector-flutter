import 'package:flutter/material.dart';
import 'package:collector/models/collection.dart';
import 'package:collector/pages/collection/actions/actions.dart';
import 'package:collector/pages/collection/collection.dart';

class MenuButton extends StatelessWidget {
  final CollectionName name;
  const MenuButton({super.key, required this.name});

  void onCollection(BuildContext context, CollectionName name) async {
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CollectionPage();
          },
        ),
      );
    }
    actionLoadCollection(name);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: const EdgeInsets.all(12.0), textStyle: const TextStyle(fontSize: 20)),
      onPressed: () => onCollection(context, name),
      child: Text(name),
    );
  }
}

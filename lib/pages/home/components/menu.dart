import 'package:collector/models/collection.dart';
import 'package:collector/pages/home/components/button.dart';
import 'package:collector/pages/home/signals/index.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final index = $index.watch(context);
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: index.length,
        itemBuilder: (BuildContext context, int i) {
          CollectionName name = index[i].name;
          return Align(
            alignment: Alignment.center,
            child: MenuButton(name: name),
          );
        },
      ),
    );
  }
}

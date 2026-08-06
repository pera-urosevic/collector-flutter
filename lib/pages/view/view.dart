import 'package:collector/components/page.dart';
import 'package:collector/models/field.dart';
import 'package:collector/pages/view/services/fields.dart';
import 'package:collector/models/item.dart';
import 'package:collector/pages/collection/signals/collection.dart';
import 'package:collector/pages/view/signals/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals/signals_flutter.dart';

class ViewItemPage extends StatelessWidget {
  const ViewItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Item item = $item.watch(context);
    final FieldList $fields = $collection.fields;

    return AppPage(
      scaffold: Scaffold(
        appBar: AppBar(title: SelectableText(item['id']), actions: []),
        body: CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            const SingleActivator(LogicalKeyboardKey.escape): () {
              Navigator.pop(context);
            },
          },
          child: Focus(
            autofocus: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsGeometry.fromLTRB(20, 0, 20, 80),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: List.from(
                      $fields
                          .where((field) => field.type != FieldType.id)
                          .map((field) => renderFieldView(field, item))
                          .where((widget) => widget != null),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

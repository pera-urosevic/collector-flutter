import 'package:flutter/services.dart';
import 'package:collector/components/page.dart';
import 'package:collector/pages/collection/components/drawer.dart';
import 'package:collector/pages/collection/components/grid.dart';
import 'package:collector/models/item.dart';
import 'package:collector/pages/collection/signals/view.dart';
import 'package:collector/pages/view/actions/actions.dart';
import 'package:collector/pages/view/view.dart';
import 'package:collector/pages/collection/signals/collection.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    final collection = $collection.watch(context);
    final itemsFound = $itemsFound.watch(context);

    onItem(Item item) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            actionViewItem(item);
            return ViewItemPage();
          },
        ),
      );
    }

    return AppPage(
      scaffold: Scaffold(
        key: drawerScaffoldKey,
        appBar: AppBar(
          title: Text('${collection.name} (${itemsFound.length})'),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                drawerScaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
        endDrawer: CollectionDrawer(),
        body: CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            const SingleActivator(LogicalKeyboardKey.keyF, control: true): () {
              drawerScaffoldKey.currentState?.openEndDrawer();
            },
            const SingleActivator(LogicalKeyboardKey.escape): () {
              Navigator.pop(context);
            },
          },
          child: Focus(
            autofocus: true,
            child: Center(child: Grid(onItem: onItem)),
          ),
        ),
      ),
    );
  }
}

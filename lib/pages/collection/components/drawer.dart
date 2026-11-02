import 'package:collector/pages/collection/actions/actions.dart';
import 'package:collector/pages/collection/signals/collection.dart';
import 'package:collector/pages/collection/signals/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

class CollectionDrawer extends StatefulWidget {
  const CollectionDrawer({super.key});

  @override
  State<CollectionDrawer> createState() => _CollectionDrawerState();
}

class _CollectionDrawerState extends State<CollectionDrawer> {
  final TextEditingController _searchController = TextEditingController(text: $query.value.search);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.keyF, control: true): () {
          drawerScaffoldKey.currentState?.closeEndDrawer();
        },
        const SingleActivator(LogicalKeyboardKey.escape): () {
          drawerScaffoldKey.currentState?.closeEndDrawer();
        },
      },
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: _searchController,
                  decoration: InputDecoration(hintText: 'Search'),
                  onSubmitted: (text) {
                    actionQueryCollection($query.value.copyWith(search: text));
                  },
                ),
                const SizedBox(height: 12),
                Column(
                  spacing: 4,
                  children: $collection.viewsNames
                      .map(
                        (queryName) => TextButton(
                          style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 18.0)),
                          onPressed: () {
                            final view = $collection.view(queryName);
                            actionQueryCollection(view);
                            _searchController.text = view.search;
                          },
                          child: Text(queryName),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

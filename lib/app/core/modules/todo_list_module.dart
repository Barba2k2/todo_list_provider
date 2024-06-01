import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

import 'todo_list_page.dart';

abstract class TodoListModule {
  final Map<String, WidgetBuilder> _router;
  final List<SingleChildWidget>? _bindings;

  TodoListModule({
    List<SingleChildWidget>? bindings,
    required Map<String, WidgetBuilder> router,
  })   : _router = router,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _router.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => TodoListPage(
          bindings: _bindings,
          page: pageBuilder,
        ),
      ),
    );
  }
}

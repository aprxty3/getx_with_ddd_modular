import 'package:flutter/material.dart';

import 'app_store_application.dart';

class AppProvider extends InheritedWidget {
  final AppStoreApplication application;

  const AppProvider(
      {Key? key, required Widget child, required this.application})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static AppProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppProvider>()
        as AppProvider);
  }

  static AppStoreApplication getApplication(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppProvider>()
            as AppProvider)
        .application;
  }
}

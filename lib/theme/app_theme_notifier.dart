import 'package:flutter/material.dart';

// This is a special type of widget called an InheritedWidget. Its only job is to
// hold a piece of data (in our case, a function) and make it easily available
// to any widget that is a descendant of it in the UI tree.
class AppThemeNotifier extends InheritedWidget {
  // This is the data we want to pass down: a function that takes a ThemeMode.
  final Function(ThemeMode) changeTheme;

  const AppThemeNotifier({
    Key? key,
    required this.changeTheme,
    required Widget child,
  }) : super(key: key, child: child);

  // This is a standard helper method that allows any child widget to easily
  // find and use this AppThemeNotifier by calling `AppThemeNotifier.of(context)`.
  static AppThemeNotifier of(BuildContext context) {
    final AppThemeNotifier? result = context.dependOnInheritedWidgetOfExactType<AppThemeNotifier>();
    // The 'assert' makes sure that we never try to use this in a place where
    // the notifier hasn't been provided, which helps catch bugs early.
    assert(result != null, 'No AppThemeNotifier found in context');
    return result!;
  }

  // This method tells Flutter whether widgets that depend on this data
  // should rebuild when the data changes. We keep it simple for now.
  @override
  bool updateShouldNotify(AppThemeNotifier oldWidget) {
    return oldWidget.changeTheme != changeTheme;
  }
}
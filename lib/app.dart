import 'package:flutter/material.dart';
import 'screens/list_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static Future<void> reportError(dynamic error, dynamic stackTrace) async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: ListScreen(),
    );
  }
}

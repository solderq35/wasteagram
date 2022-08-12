import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'screens/list_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    final sentryId =
        await Sentry.captureException(error, stackTrace: stackTrace);
  }

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


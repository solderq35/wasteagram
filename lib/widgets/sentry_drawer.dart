import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryTestDrawer extends StatelessWidget {
  const SentryTestDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: const Text(
                'Tap to notify Sentry that the app has thrown an exception')),
        ElevatedButton(
          child: const Text('Throw an Exception'),
          onPressed: () async {
            try {
              throw StateError('Example Error!');
            } catch (exception, stackTrace) {
              await Sentry.captureException(
                exception,
                stackTrace: stackTrace,
              );
            }
          },
        ),
      ]),
    );
  }
}

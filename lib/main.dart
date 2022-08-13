import 'package:flutter/material.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// ignore: constant_identifier_names
const DSN_URL =
    'https://a50f4d627b3543709516798024b24874@o1357917.ingest.sentry.io/6644854';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Flutter runs apps in debug mode by default and only supports release mode
  // for certain target architechtures. It does not support x86 Android ABI.
  // https://docs.flutter.dev/deployment/android#what-are-the-supported-target-architectures
  await SentryFlutter.init((options) => options.dsn = DSN_URL,
      appRunner: () => runApp(const App()));
}

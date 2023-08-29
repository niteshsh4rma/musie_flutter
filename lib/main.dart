import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:musie/shared/constants/asset_constants.dart';
import 'package:musie/start/musie_app.dart';
import 'package:musie/start/observers.dart';
import 'package:musie/start/setup.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      final initFuture = Setup.instance.init();

      if (kReleaseMode) {
        SentryFlutter.init(
          (options) async => await Setup.instance.setupSentry(options),
          appRunner: () => run(initFuture),
        );
      } else {
        FlutterError.onError = (details) {
          FlutterError.presentError(details);
          logError('FlutterError details: $details');
        };

        run(initFuture);
      }
    },
    (error, stack) {
      logError('Unhandled error: $error', null, stack);
      debugPrintStack(stackTrace: stack);
    },
  );
}

void run(Future<void> future) async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget buildSplashScreen(BuildContext context) {
    return Container(
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      child: Center(
        child: Image.asset(
          AssetConstants.appIcon,
          width: 150,
          height: 150,
        ),
      ),
    );
  }

  runApp(
    ProviderScope(
      observers: [Observers()],
      child: FutureBuilder(
        future: future,
        initialData: null,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? MusieApp()
                : buildSplashScreen(context),
      ),
    ),
  );
}

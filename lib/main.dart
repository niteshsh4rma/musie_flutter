import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:musie/core/constants/asset_constants.dart';
import 'package:musie/start/musie_app.dart';
import 'package:musie/start/setup.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  final initFuture = Setup.instance.init();

  if (kReleaseMode) {
    runZonedGuarded(
      () => SentryFlutter.init(
        (options) async => await Setup.instance.setupSentry(options),
        appRunner: () => run(initFuture),
      ),
      (error, stack) {
        logError('Unhandled error: $error', null, stack);
        debugPrintStack(stackTrace: stack);
      },
    );
  } else {
    runZonedGuarded(
      () {
        FlutterError.onError = (details) {
          FlutterError.presentError(details);
          logError('FlutterError details: $details');
        };

        run(initFuture);
      },
      (error, stack) {
        logError('Unhandled error: $error', null, stack);
        debugPrintStack(stackTrace: stack);
      },
    );
  }
}

void run(Future<void> future) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    FutureBuilder(
      future: future,
      initialData: null,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? const MusieApp()
              : Center(
                  child: Image.asset(
                    AssetConstants.appIcon,
                    width: 150,
                    height: 150,
                  ),
                ),
    ),
  );
}

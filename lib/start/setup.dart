import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class Setup {
  Setup._();

  static final Setup instance = Setup._();

  Future<void> init() async {}

  Future<SentryFlutterOptions> setupSentry(SentryFlutterOptions options) async {
    final packageInfo = await PackageInfo.fromPlatform();
    return options
      ..dsn = const String.fromEnvironment('SENTRY_DSN')
      ..environment = const String.fromEnvironment('SENTRY_ENVIRONMENT')
      ..maxCacheItems = 60
      ..release =
          '${const String.fromEnvironment('SENTRY_RELEASE')}@${packageInfo.version}+${packageInfo.buildNumber}';
  }
}

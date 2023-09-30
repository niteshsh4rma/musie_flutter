import 'package:musie/services/audio_player_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class Setup {
  Setup._();

  static final Setup instance = Setup._();

  final audioQuery = OnAudioQuery();

  Future<void> init() async {
    await Future.wait([
      setupMedia(retryRequest: true),
      setupAudioPlayer(),
    ]);
  }

  Future<void> setupAudioPlayer() {
    return AudioPlayerService.instance.init();
  }

  Future<bool> setupMedia({bool retryRequest = false}) async {
    return audioQuery.checkAndRequest(
      retryRequest: retryRequest,
    );
  }

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

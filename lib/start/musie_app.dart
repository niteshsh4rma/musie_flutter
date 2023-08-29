import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musie/navigation/app_router.dart';
import 'package:musie/shared/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:musie/shared/extensions/context_extensions.dart';
import 'package:musie/shared/theme/app_theme_mode_notifier.dart';

class MusieApp extends ConsumerWidget {
  MusieApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => context.loc.musie,
      routerConfig: appRouter.config(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

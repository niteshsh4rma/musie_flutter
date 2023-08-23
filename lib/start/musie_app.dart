import 'package:flutter/material.dart';
import 'package:musie/core/navigation/app_router.dart';
import 'package:musie/core/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:musie/core/extensions/context_extensions.dart';

class MusieApp extends StatelessWidget {
  const MusieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MaterialApp.router(
      onGenerateTitle: (context) => context.loc.musie,
      routerConfig: appRouter.config(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

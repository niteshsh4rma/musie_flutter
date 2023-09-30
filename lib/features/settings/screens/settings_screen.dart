import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cocoicons/cocoicons.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musie/shared/extensions/context_extensions.dart';
import 'package:musie/shared/theme/app_theme_mode_notifier.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);

    return NestedScrollView(
      headerSliverBuilder: (context, _) => [
        SliverAppBar.large(
          title: Text(context.loc.settings),
          centerTitle: true,
        ),
      ],
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            leading: const Icon(CocoIconBold.Eye),
            title: Text('${themeMode.name.capitalize} ${context.loc.theme}'),
            onTap: () => ref.read(appThemeProvider.notifier).toggleTheme(),
            trailing: Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: (_) =>
                  ref.read(appThemeProvider.notifier).toggleTheme(),
            ),
          ),
          ListTile(
            leading: const Icon(CocoIconBold.Export),
            title: Text(context.loc.exit),
            trailing: const Icon(CocoIconBold.Arrow_Right_1),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}

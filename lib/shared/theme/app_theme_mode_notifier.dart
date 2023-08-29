import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musie/shared/constants/global_constants.dart';
import 'package:musie/shared/data/local/storage_service.dart';
import 'package:musie/shared/domain/providers/sharedpreferences_storage_service_provider.dart';

final appThemeProvider = StateNotifierProvider<AppThemeModeNotifier, ThemeMode>(
  (ref) {
    final storage = ref.watch(storageServiceProvider);
    return AppThemeModeNotifier(storage);
  },
);

class AppThemeModeNotifier extends StateNotifier<ThemeMode> {
  final StroageService storageService;

  AppThemeModeNotifier(this.storageService) : super(ThemeMode.system) {
    getCurrentTheme();
  }

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    storageService.set(GlobalConstants.appThemeStorageKey, state.name);
  }

  void getCurrentTheme() async {
    final theme = await storageService.get(GlobalConstants.appThemeStorageKey);
    final value = ThemeMode.values.byName('${theme ?? ThemeMode.light.name}');
    storageService.set(GlobalConstants.appThemeStorageKey, value.name);
    state = value;
  }
}

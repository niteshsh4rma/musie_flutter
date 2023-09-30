import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final StorageService storageService;

  AppThemeModeNotifier(this.storageService) : super(ThemeMode.light) {
    loadCurrentTheme();
  }

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setSystemUIOverlayStyle();
    storageService.set(GlobalConstants.appThemeStorageKey, state.name);
  }

  void loadCurrentTheme() async {
    final theme = await storageService.get(GlobalConstants.appThemeStorageKey);
    final value = ThemeMode.values.byName('${theme ?? ThemeMode.light.name}');
    storageService.set(GlobalConstants.appThemeStorageKey, value.name);
    state = value;
    setSystemUIOverlayStyle();
  }

  void setSystemUIOverlayStyle() {
    final isDarkMode = state == ThemeMode.dark;
    SystemChrome.setSystemUIOverlayStyle(
      isDarkMode ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
  }
}

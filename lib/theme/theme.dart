import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// 全局主题
final class AppTheme {
  AppTheme._();

  /// 做一个浅色主题，[seedColor]是可选的主题颜色
  ///
  /// [seedColor]为空时使用flex_color_scheme的颜色，为空时用material默认生成一套颜色。
  static ThemeData makeLight(BuildContext context, [Color? seedColor]) {
    ColorScheme? seedScheme;
    if (seedColor != null) {
      seedScheme = ColorScheme.fromSeed(seedColor: seedColor);
    }
    return FlexThemeData.light(
      fontFamily: 'Microsoft YaHei UI',
      primary: seedScheme?.primary,
      onPrimary: seedScheme?.onPrimary,
      primaryContainer: seedScheme?.primaryContainer,
      onPrimaryContainer: seedScheme?.onPrimaryContainer,
      secondary: seedScheme?.secondary,
      onSecondary: seedScheme?.onSecondary,
      secondaryContainer: seedScheme?.secondaryContainer,
      onSecondaryContainer: seedScheme?.onSecondaryContainer,
      tertiary: seedScheme?.tertiary,
      onTertiary: seedScheme?.onTertiary,
      tertiaryContainer: seedScheme?.tertiaryContainer,
      onTertiaryContainer: seedScheme?.onTertiaryContainer,
      error: seedScheme?.error,
      onError: seedScheme?.onError,
      surface: seedScheme?.surface,
      onSurface: seedScheme?.onSurface,
      background: seedScheme?.surface,
      onBackground: seedScheme?.onSurface,
      surfaceTint: seedScheme?.surfaceTint,
      scheme: seedScheme == null ? FlexScheme.barossa : null,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useM2StyleDividerInM3: true,
        navigationRailLabelType: NavigationRailLabelType.all,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    );
  }

  /// 做一个深色主题，[seedColor]是可选的主题颜色
  ///
  /// [seedColor]为空时使用flex_color_scheme的颜色，为空时用material默认生成一套颜色。
  static ThemeData makeDark(BuildContext context, [Color? seedColor]) {
    ColorScheme? seedScheme;
    if (seedColor != null) {
      seedScheme = ColorScheme.fromSeed(seedColor: seedColor);
    }

    return FlexThemeData.dark(
      fontFamily: 'Microsoft YaHei UI',
      primary: seedScheme?.primary,
      onPrimary: seedScheme?.onPrimary,
      primaryContainer: seedScheme?.primaryContainer,
      onPrimaryContainer: seedScheme?.onPrimaryContainer,
      secondary: seedScheme?.secondary,
      onSecondary: seedScheme?.onSecondary,
      secondaryContainer: seedScheme?.secondaryContainer,
      onSecondaryContainer: seedScheme?.onSecondaryContainer,
      tertiary: seedScheme?.tertiary,
      onTertiary: seedScheme?.onTertiary,
      tertiaryContainer: seedScheme?.tertiaryContainer,
      onTertiaryContainer: seedScheme?.onTertiaryContainer,
      error: seedScheme?.error,
      onError: seedScheme?.onError,
      surface: seedScheme?.surface,
      onSurface: seedScheme?.onSurface,
      background: seedScheme?.surface,
      onBackground: seedScheme?.onSurface,
      surfaceTint: seedScheme?.surfaceTint,
      scheme: seedScheme == null ? FlexScheme.barossa : null,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useM2StyleDividerInM3: true,
        navigationRailLabelType: NavigationRailLabelType.all,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
    );
  }
}

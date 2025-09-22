import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color backgroundGradientStart;
  final Color backgroundGradientEnd;
  final Color accentBlue;
  final Color accentCyan;
  final Color accentPurple;
  final Color accentGray;
  final Color accentTeal;
  final Color accentLighterBlue;
  final Color accentDarkerPurple;
  final Color accentLighterCyan;
  final Color blue;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle labelStyle;
  final TextStyle bodyStyle;
  final TextStyle hintStyle;

  const AppTheme({
    required this.backgroundGradientStart,
    required this.backgroundGradientEnd,
    required this.accentBlue,
    required this.accentCyan,
    required this.accentPurple,
    required this.accentGray,
    required this.accentTeal,
    required this.accentLighterBlue,
    required this.accentDarkerPurple,
    required this.accentLighterCyan,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.labelStyle,
    required this.bodyStyle,
    required this.hintStyle,
    required this.blue,
  });

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? backgroundGradientStart,
    Color? backgroundGradientEnd,
    Color? accentBlue,
    Color? accentCyan,
    Color? accentPurple,
    Color? accentGray,
    Color? accentTeal,
    Color? accentLighterBlue,
    Color? accentDarkerPurple,
    Color? accentLighterCyan,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? labelStyle,
    TextStyle? bodyStyle,
    TextStyle? captionStyle,
    Color? blue,
  }) {
    return AppTheme(
      backgroundGradientStart:
          backgroundGradientStart ?? this.backgroundGradientStart,
      backgroundGradientEnd:
          backgroundGradientEnd ?? this.backgroundGradientEnd,
      accentBlue: accentBlue ?? this.accentBlue,
      accentCyan: accentCyan ?? this.accentCyan,
      accentPurple: accentPurple ?? this.accentPurple,
      accentGray: accentGray ?? this.accentGray,
      accentTeal: accentTeal ?? this.accentTeal,
      accentLighterBlue: accentLighterBlue ?? this.accentLighterBlue,
      accentDarkerPurple: accentDarkerPurple ?? this.accentDarkerPurple,
      accentLighterCyan: accentLighterCyan ?? this.accentLighterCyan,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      hintStyle: captionStyle ?? this.hintStyle,
      blue: blue ?? this.blue,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      backgroundGradientStart: Color.lerp(
        backgroundGradientStart,
        other.backgroundGradientStart,
        t,
      )!,
      backgroundGradientEnd: Color.lerp(
        backgroundGradientEnd,
        other.backgroundGradientEnd,
        t,
      )!,
      accentBlue: Color.lerp(accentBlue, other.accentBlue, t)!,
      accentCyan: Color.lerp(accentCyan, other.accentCyan, t)!,
      accentPurple: Color.lerp(accentPurple, other.accentPurple, t)!,
      accentGray: Color.lerp(accentGray, other.accentGray, t)!,
      accentTeal: Color.lerp(accentTeal, other.accentTeal, t)!,
      accentLighterBlue: Color.lerp(
        accentLighterBlue,
        other.accentLighterBlue,
        t,
      )!,
      accentDarkerPurple: Color.lerp(
        accentDarkerPurple,
        other.accentDarkerPurple,
        t,
      )!,
      accentLighterCyan: Color.lerp(
        accentLighterCyan,
        other.accentLighterCyan,
        t,
      )!,
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t)!,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      bodyStyle: TextStyle.lerp(bodyStyle, other.bodyStyle, t)!,
      hintStyle: TextStyle.lerp(hintStyle, other.hintStyle, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
    );
  }
}

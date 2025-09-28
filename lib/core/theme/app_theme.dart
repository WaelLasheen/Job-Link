import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color accentLighterBlue;
  final Color blue;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle labelStyle;
  final TextStyle bodyStyle;
  final TextStyle textFieldStyle;
  final TextStyle hintStyle;
  final TextStyle richTextTitleStyle;

  const AppTheme({
    required this.accentLighterBlue,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.labelStyle,
    required this.bodyStyle,
    required this.textFieldStyle,
    required this.hintStyle,
    required this.blue,
    required this.richTextTitleStyle,
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
    TextStyle? hintStyle,
    Color? blue,
    TextStyle? largeTitleStyle,
    TextStyle? textFieldStyle,
  }) {
    return AppTheme(
      accentLighterBlue: accentLighterBlue ?? this.accentLighterBlue,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      blue: blue ?? this.blue,
      richTextTitleStyle: largeTitleStyle ?? this.richTextTitleStyle,
      textFieldStyle: textFieldStyle ?? this.textFieldStyle,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      accentLighterBlue: Color.lerp(
        accentLighterBlue,
        other.accentLighterBlue,
        t,
      )!,
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t)!,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      bodyStyle: TextStyle.lerp(bodyStyle, other.bodyStyle, t)!,
      hintStyle: TextStyle.lerp(hintStyle, other.hintStyle, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      richTextTitleStyle: TextStyle.lerp(
        richTextTitleStyle,
        other.richTextTitleStyle,
        t,
      )!,
      textFieldStyle: TextStyle.lerp(textFieldStyle, other.textFieldStyle, t)!,
    );
  }
}

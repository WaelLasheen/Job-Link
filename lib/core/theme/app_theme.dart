import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color accentLighterBlue;
  final Color blue;
  final Color grey;
  final Color dividerColor;
  final Color chipColor;
  final Color ofWhiteColor;
  final Color descriptionColor;
  final Color jobApplicationAllColor;
  final Color jobApplicationPendingColor;
  final Color jobApplicationAcceptedColor;
  final Color jobApplicationRejectedColor;


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
    required this.dividerColor,
    required this.grey,
    required this.chipColor,
    required this.ofWhiteColor,
    required this.descriptionColor,
    required this.jobApplicationAllColor,
    required this.jobApplicationPendingColor,
    required this.jobApplicationAcceptedColor,
    required this.jobApplicationRejectedColor,
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
    TextStyle? richTextTitleStyle,
    Color? dividerColor,
    Color? grey,
    Color? chipColor,
    Color? ofWhiteColor,
    Color? descriptionColor,
    Color? jobApplicationAllColor,
    Color? jobApplicationPendingColor,
    Color? jobApplicationAcceptedColor,
    Color? jobApplicationRejectedColor,
  }) {
    return AppTheme(
      accentLighterBlue: accentLighterBlue ?? this.accentLighterBlue,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      blue: blue ?? this.blue,
      richTextTitleStyle: richTextTitleStyle ?? this.richTextTitleStyle,
      textFieldStyle: textFieldStyle ?? this.textFieldStyle,
      dividerColor: dividerColor ?? this.dividerColor,
      grey: grey ?? this.grey,
      chipColor: chipColor ?? this.chipColor,
      ofWhiteColor: ofWhiteColor ?? this.ofWhiteColor,
      descriptionColor: descriptionColor ?? this.descriptionColor,
      jobApplicationAllColor: jobApplicationAllColor ?? this.jobApplicationAllColor,
      jobApplicationPendingColor: jobApplicationPendingColor ?? this.jobApplicationPendingColor,
      jobApplicationAcceptedColor: jobApplicationAcceptedColor ?? this.jobApplicationAcceptedColor,
      jobApplicationRejectedColor: jobApplicationRejectedColor ?? this.jobApplicationRejectedColor,
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
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      chipColor: Color.lerp(chipColor, other.chipColor, t)!,
      ofWhiteColor: Color.lerp(ofWhiteColor, other.ofWhiteColor, t)!,
      descriptionColor: Color.lerp(descriptionColor, other.descriptionColor, t)!,
      jobApplicationAllColor: Color.lerp(jobApplicationAllColor, other.jobApplicationAllColor, t)!,
      jobApplicationPendingColor: Color.lerp(jobApplicationPendingColor, other.jobApplicationPendingColor, t)!,
      jobApplicationAcceptedColor: Color.lerp(jobApplicationAcceptedColor, other.jobApplicationAcceptedColor, t)!,
      jobApplicationRejectedColor: Color.lerp(jobApplicationRejectedColor, other.jobApplicationRejectedColor, t)!,
    );
  }
}

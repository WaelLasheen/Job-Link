import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

const lightThemeDefinition = AppTheme(
  accentLighterBlue: Color(0x403B82F6),
  blue: Color(0xff3a86ff),

  titleStyle: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1C1C1E),
  ),

  subtitleStyle: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1C1C1E),
  ),

  labelStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1C1C1E),
  ),

  textFieldStyle: TextStyle(
    fontSize: 20,
    color: Color(0XFF1E1E24),
    fontWeight: FontWeight.w500,
  ),

  hintStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Color(0xFF6E6E73),
  ),

  bodyStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Color(0xFF1F2937),
  ),

  richTextTitleStyle: TextStyle(fontSize: 32, color: Color(0xFF1C1C1E)),
  dividerColor: Color(0xFFB9C2CA),
  grey: Colors.grey,
  chipColor: Color(0xFF42A5F5),
  ofWhiteColor: Color(0xFFEEF0F2),
  descriptionColor: Color(0xFF969294),
  jobApplicationAllColor: Color(0xFF64B5F6),
  jobApplicationPendingColor: Colors.grey,
  jobApplicationAcceptedColor: Color(0xFF81C784),
  jobApplicationRejectedColor:Color(0xFFE57373) 
);

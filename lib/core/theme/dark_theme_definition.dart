import 'package:flutter/material.dart';
import 'package:job_link/core/theme/app_theme.dart';

const darkThemeDefinition = AppTheme(
  accentLighterBlue: Color(0x403B82F6),
  blue: Color(0xff3a86ff),

  titleStyle: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),

  subtitleStyle: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),

  labelStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),

  textFieldStyle: TextStyle(
    fontSize: 20,
    color: Colors.white,
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
    color: Colors.white,
  ),

  richTextTitleStyle: TextStyle(fontSize: 32, color: Colors.white),
  dividerColor: Color(0xFF2C2C2C),
  grey: Colors.grey,
  chipColor: Colors.blue,
  ofWhiteColor: Color(0xFFFBF5F3),
  descriptionColor: Color(0xFFB0B0B0),
  jobApplicationAllColor: Color(0xFF42A5F5),
  jobApplicationPendingColor: Color(0xFF757575),
  jobApplicationAcceptedColor: Color(0xFF66BB6A),
  jobApplicationRejectedColor:Color(0xFFEF5350) 
);

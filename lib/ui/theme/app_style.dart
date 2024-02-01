import 'package:flutter/material.dart';
import 'package:weather_app/ui/theme/app_colors.dart';

abstract class AppStyle {
  static TextStyle fontStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.darkBlue,
  );
}

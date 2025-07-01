import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
        headlineLarge: AppStyles.bold20Black,
        headlineMedium: AppStyles.medium16Black

    ),
    scaffoldBackgroundColor: AppColors.whiteBgColor
  );
  static final ThemeData darkTheme = ThemeData(
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20White,
          headlineMedium: AppStyles.medium16White
      ),
    scaffoldBackgroundColor: AppColors.primaryDark
  );
}

import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20Black,
      headlineMedium: AppStyles.medium16Black,
    ),
    scaffoldBackgroundColor: AppColors.whiteBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
      elevation: 0,
      showUnselectedLabels: true,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20White,
      headlineMedium: AppStyles.medium16White,
    ),
    scaffoldBackgroundColor: AppColors.primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
      elevation: 0,
      showUnselectedLabels: true,
    ),
  );
}

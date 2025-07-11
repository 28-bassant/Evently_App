import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(

    ),
    primaryColor: AppColors.primaryLight,
    dividerColor: AppColors.whiteColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20Black,
      headlineMedium: AppStyles.medium16Black,
        headlineSmall: AppStyles.medium16Primary,
        labelMedium: AppStyles.bold16White,
        labelLarge: AppStyles.bold14Black,
        titleMedium: AppStyles.medium16Black
    ),

    focusColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.whiteBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
      elevation: 0,
      showUnselectedLabels: true,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(

    ),
    primaryColor: AppColors.primaryDark,
    dividerColor: AppColors.primaryLight,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20White,
      headlineMedium: AppStyles.medium16White,
        headlineSmall: AppStyles.medium16White,
        labelLarge: AppStyles.bold14Primary,
        labelMedium: AppStyles.bold16Black,
        titleMedium: AppStyles.medium16White

    ),
    focusColor: AppColors.primaryLight,

    scaffoldBackgroundColor: AppColors.primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: AppStyles.bold12White,
      unselectedLabelStyle: AppStyles.bold12White,
      elevation: 0,
      showUnselectedLabels: true,
    ),
  );
}

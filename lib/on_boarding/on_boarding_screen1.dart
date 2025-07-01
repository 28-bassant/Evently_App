import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_language_provider.dart';
import '../providers/app_theme_provider.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({super.key});

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
  @override
  Widget build(BuildContext context) {
    var langageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    bool status = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(AppAssets.onBoardingScreen1),
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        SizedBox(height: height * .02),
        Text(
          AppLocalizations.of(context)!.onboarding1title,
          style: AppStyles.bold20Primary,
        ),
        SizedBox(height: height * .02),
        Text(
          AppLocalizations.of(context)!.onboarding1content,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: AppStyles.medium20Primary,
            ),
            Container(
              child: FlutterSwitch(
                width: width * .30,
                height: height * .06,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: status,
                borderRadius: 30.0,
                padding: 8.0,
                activeColor: themeProvider.appTheme == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.primaryDark,
                inactiveColor: themeProvider.appTheme == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.primaryDark,
                toggleBorder: Border.all(
                  color: AppColors.primaryLight,
                  width: 3,
                ),
                switchBorder: Border.all(
                  color: AppColors.primaryLight,
                  width: 2,
                ),
                activeIcon: langageProvider.appLanguage == 'en'
                    ? Image(image: AssetImage(AppAssets.egyptImage))
                    : Image(image: AssetImage(AppAssets.americaImage)),
                inactiveIcon: langageProvider.appLanguage == 'ar'
                    ? Image(image: AssetImage(AppAssets.egyptImage))
                    : Image(image: AssetImage(AppAssets.americaImage)),

                onToggle: (val) {
                  langageProvider.appLanguage == 'en'
                      ? langageProvider.changeLanguage('ar')
                      : langageProvider.changeLanguage('en');
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.theme,
              style: AppStyles.medium20Primary,
            ),
            Container(
              child: FlutterSwitch(
                width: width * .30,
                height: height * .06,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: status,
                borderRadius: 30.0,
                padding: 8.0,
                activeColor: themeProvider.appTheme == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.primaryDark,

                inactiveColor: themeProvider.appTheme == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.primaryDark,
                toggleBorder: Border.all(
                  color: AppColors.primaryLight,
                  width: 3,
                ),
                switchBorder: Border.all(
                  color: AppColors.primaryLight,
                  width: 2,
                ),
                activeIcon: themeProvider.appTheme == ThemeMode.light
                    ? Image(image: AssetImage(AppAssets.moonImage))
                    : Image(
                        image: AssetImage(AppAssets.sunImage),
                        color: AppColors.primaryLight,
                      ),
                inactiveIcon: themeProvider.appTheme == ThemeMode.dark
                    ? Image(image: AssetImage(AppAssets.moonImage))
                    : Image(
                        image: AssetImage(AppAssets.sunImage),
                        color: AppColors.primaryLight,
                      ),

                onToggle: (val) {
                  themeProvider.appTheme == ThemeMode.dark
                      ? themeProvider.changeTheme(ThemeMode.light)
                      : themeProvider.changeTheme(ThemeMode.dark);
                  status = !status;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: height * .04),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(
              vertical: height * .02,
              horizontal: width * .02,
            ),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.onBoardingScreen2RouteName,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.letsStart,
                style: AppStyles.regular20White,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

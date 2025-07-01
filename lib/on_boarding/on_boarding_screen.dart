import 'package:evently_app/on_boarding/on_boarding_screen1.dart';
import 'package:evently_app/on_boarding/on_boarding_screen3.dart';
import 'package:evently_app/on_boarding/on_boarding_screen4.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_language_provider.dart';
import '../providers/app_theme_provider.dart';
import '../ui/home_screen.dart';
import 'on_boarding_screen2.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void _onDone(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  final List<Widget> onboardingPages = [
    OnBoardingScreen1(),
    OnBoardingScreen2(),
    // create as many as you want
  ];
  @override
  Widget build(BuildContext context) {
    var langageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return IntroductionScreen(
      pages: [
        PageViewModel(

          titleWidget: Image(image: AssetImage(AppAssets.onBoardingTopTitile)),
          bodyWidget: OnBoardingScreen1(),

        ),

        PageViewModel(
          titleWidget: Image(image: AssetImage(AppAssets.onBoardingTopTitile)),
          bodyWidget: OnBoardingScreen2(),
        ),
        PageViewModel(
          titleWidget: Image(image: AssetImage(AppAssets.onBoardingTopTitile)),
          bodyWidget: OnBoardingScreen3(),
        ),
        PageViewModel(
          titleWidget: Image(image: AssetImage(AppAssets.onBoardingTopTitile)),
          bodyWidget: OnBoardingScreen4(),
        ),
      ],
      onDone: () => _onDone(context),
      showBackButton: true,
      back: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.primaryLight,
                width: 2
            ),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Icon(Icons.arrow_back,
          color: AppColors.primaryLight,
          weight: 40,),

      ),
      next: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.primaryLight,
                width: 2
            ),
            borderRadius: BorderRadius.circular(25)
        ),
        child: Icon(Icons.arrow_forward,
          color: AppColors.primaryLight,
          weight: 40,),

      ),
      done: Text(
          AppLocalizations.of(context)!.done, style: AppStyles.medium20Primary),
      dotsDecorator: DotsDecorator(
        size: Size.square(10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),

        ),
          color: AppColors.greyColor,
          activeColor: AppColors.primaryLight
      ),
    );
  }
}

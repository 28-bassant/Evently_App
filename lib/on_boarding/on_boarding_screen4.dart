import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/app_assets.dart';
import '../utils/app_styles.dart';

class OnBoardingScreen4 extends StatelessWidget {
  const OnBoardingScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(AppAssets.onBoardingScreen4),
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        SizedBox(height: height * .02),
        Text(
          AppLocalizations.of(context)!.onboarding4title,
          style: AppStyles.bold20Primary,
        ),
        SizedBox(height: height * .02),
        Text(
          AppLocalizations.of(context)!.onboarding4content,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: height * 0.02),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class OnBoardingScreen2 extends StatelessWidget {
  String ImagePath;
  String textContent;
  String textTitle;

  OnBoardingScreen2(
      {required this.ImagePath, required this.textTitle, required this.textContent});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(ImagePath),
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        SizedBox(height: height * .02),
        Text(
          textTitle,
          style: AppStyles.bold20Primary,
        ),
        SizedBox(height: height * .02),
        Text(
          textContent,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: height * 0.02),
      ],
    );
  }
}

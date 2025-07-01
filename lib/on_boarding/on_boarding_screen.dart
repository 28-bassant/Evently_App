import 'package:evently_app/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ui/home_screen.dart';


class OnboardingScreen extends StatelessWidget {
  void _onDone(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Discover amazing things.",
          image: Image.asset(AppAssets.onBoardingScreen1, height: 250),
        ),
        PageViewModel(
          title: "Stay Connected",
          body: "Get updates anytime, anywhere.",
          image: Image.asset(AppAssets.onBoardingScreen1, height: 250),
        ),
        PageViewModel(
          title: "Let's Start",
          body: "We're glad to have you!",
          image: Image.asset(AppAssets.onBoardingScreen1, height: 250),
        ),
      ],
      onDone: () => _onDone(context),
      onSkip: () => _onDone(context),
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: Size.square(10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}


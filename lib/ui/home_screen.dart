import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/ui/profile/profile_tab.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ProfileTab(),
    );
  }
}

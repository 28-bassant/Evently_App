import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_provider.dart';
class LanguageBootomSheet extends StatelessWidget {
  const LanguageBootomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var langageProvider = Provider.of<AppLanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: width * .04,
        vertical: height * .04

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              langageProvider.changeLanguage('en');
            },
            child: langageProvider.appLanguage == 'en'?
                getSelectedBottomSheet(AppLocalizations.of(context)!.english):
                getUnSelectedBottomSheet(AppLocalizations.of(context)!.english),
          ),



          SizedBox(height: height * .04,),
          InkWell(
            onTap: () {
              langageProvider.changeLanguage('ar');
            },
            child: langageProvider.appLanguage == 'ar'?
            getSelectedBottomSheet(AppLocalizations.of(context)!.arabic):
            getUnSelectedBottomSheet(AppLocalizations.of(context)!.arabic),
          ),

        ],
      ),
    );
  }
  Widget getSelectedBottomSheet(String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
          style: AppStyles.bold20Primary,),
        Icon(Icons.check,
          color: AppColors.primaryLight,
          size: 30,)
      ],
    );
  }Widget getUnSelectedBottomSheet(String text){
    return Text(text,
      style: AppStyles.bold20Black,);
  }
}

import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
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
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.iSDark()?
            getSelectedBottomSheet(AppLocalizations.of(context)!.dark):
            getUnSelectedBottomSheet(AppLocalizations.of(context)!.dark),
          ),



          SizedBox(height: height * .04,),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: themeProvider.iSDark()?
            getUnSelectedBottomSheet(AppLocalizations.of(context)!.light):
            getSelectedBottomSheet(AppLocalizations.of(context)!.light),
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

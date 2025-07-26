import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/profile/language/language_bootom_sheet.dart';
import 'package:evently_app/ui/profile/theme/theme_bottom_sheet.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';
import '../../providers/user_provider.dart';

class ProfileTab  extends StatefulWidget {
  const ProfileTab({super.key});



  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var langageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);


    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height * .20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.only(
          bottomLeft: Radius.circular(55)
        )),
        title:Row(
          children: [
            Image(image: AssetImage(AppAssets.routeImage)),
            SizedBox(width: width * .04,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userProvider.currentUser!.name,
                  style: AppStyles.bold24White,),
                SizedBox(height: height * .01,),
                Text(userProvider.currentUser!.email,
                  style: AppStyles.medium16White,)
              ],
            )
            
          ],
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          vertical: height * .04,
          horizontal: width * .04
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.headlineLarge,),
            InkWell(
              onTap: () {
                ShowLanguageBottomSheet();
              },
              child: Container(
                margin:  EdgeInsets.symmetric(
                    vertical: height * .02
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width * .02,
                  vertical: height * .01
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryLight,
                    width: 2
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(langageProvider.appLanguage == 'en'?
                    AppLocalizations.of(context)!.english:
                    AppLocalizations.of(context)!.arabic,
                    style: AppStyles.bold20Primary,),
                    Icon(Icons.arrow_drop_down_outlined,
                      color: AppColors.primaryLight,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: height * .02,),
            Text(AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.headlineLarge,),
            InkWell(
              onTap: () {
                ShowThemeBottomSheet();
              },
              child: Container(
                margin:  EdgeInsets.symmetric(
                    vertical: height * .02
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: width * .02,
                    vertical: height * .01
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.primaryLight,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(themeProvider.iSDark()?
                    AppLocalizations.of(context)!.dark:
                    AppLocalizations.of(context)!.light,
                      style: AppStyles.bold20Primary,),
                    Icon(Icons.arrow_drop_down_outlined,
                      color: AppColors.primaryLight,
                      size: 35,
                    )
                  ],
                ),
              ),

            ),
            Spacer(),
            CustomElevatedButton(
              text: AppLocalizations.of(context)!.logout,
              backgroundColor: AppColors.redColor,
              borderColor: AppColors.redColor,
              isIcon: true,
              iconWidget: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.logout,
                      color: AppColors.whiteColor,
                      size: 35,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .02),
                      child: Text(
                        AppLocalizations.of(context)!.logout,
                        style: AppStyles.medium20White,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                //todo : log out
                eventListProvider.favouriteEventsList = [];
                Navigator.pushNamedAndRemoveUntil
                  (context, AppRoutes.loginRouteName, (route) => false,);
              },
            )
          ],
        ),
      ),
    );
  }

  void ShowLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBootomSheet(),
    );
  }

  void ShowThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}

/*
* ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                padding: EdgeInsets.symmetric(
                  vertical: height * .02,
                  horizontal: width * .02
                )
              ),
                onPressed: (){},
                child: Row(
                  children: [
                    Icon(Icons.logout,
                    color: AppColors.whiteColor,
                      size: 35,),
                    SizedBox(width: width * .02,),
                    Text(AppLocalizations.of(context)!.logout,
                    style: AppStyles.regular20White,)
                  ],
                ))
* */

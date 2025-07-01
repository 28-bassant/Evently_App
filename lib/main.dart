import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/home_screen.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

void main(){
  runApp( MultiProvider(
    providers: [
       ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
       ChangeNotifierProvider(create: (context) => AppThemeProvider(),),
    ],

      child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var langageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: Locale(langageProvider.appLanguage),
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName : (context)=>HomeScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}

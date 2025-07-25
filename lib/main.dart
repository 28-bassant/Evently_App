import 'package:evently_app/edit_event/edit_event.dart';
import 'package:evently_app/on_boarding/on_boarding_screen.dart';
import 'package:evently_app/on_boarding/on_boarding_screen1.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/add_event/add_event.dart';
import 'package:evently_app/ui/auth/Login/login_screen.dart';
import 'package:evently_app/ui/auth/Register/register_screen.dart';
import 'package:evently_app/ui/event_details/event_details.dart';
import 'package:evently_app/ui/home_screen.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  runApp( MultiProvider(
    providers: [
       ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
       ChangeNotifierProvider(create: (context) => AppThemeProvider(),),
      ChangeNotifierProvider(create: (context) => EventListProvider(),),
      ChangeNotifierProvider(create: (context) => UserProvider(),),
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
      initialRoute: AppRoutes.loginRouteName,
      routes: {
        AppRoutes.homeRouteName : (context)=>HomeScreen(),
        AppRoutes.onBoardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.onBoardingScreen1RouteName: (context) => OnBoardingScreen1(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.addEventRouteName: (context) => AddEvent(),
        AppRoutes.eventDetailsRouteName: (context) => EventDetails(),
        AppRoutes.editEventRouteName: (context) => EditEvent(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}

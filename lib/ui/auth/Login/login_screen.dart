import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var langageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool status = false;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: AssetImage(AppAssets.logoImage),
                  height: height * .20,
                ),
                SizedBox(height: height * .02),

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.email,
                        prefixIcon: themeProvider.appTheme == ThemeMode.light
                            ? Image(image: AssetImage(AppAssets.iconEmail))
                            : Image(image: AssetImage(AppAssets.darkEmailIcon)),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        onValidator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.please_enter_email;
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(text.trim());

                          if (!emailValid) {
                            return AppLocalizations.of(
                              context,
                            )!.please_enter_valid_email;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * .02),
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.password,
                        prefixIcon: themeProvider.appTheme == ThemeMode.light
                            ? Image(image: AssetImage(AppAssets.iconPassword))
                            : Image(
                                image: AssetImage(AppAssets.darkPasswordIcon),
                              ),
                        controller: passwordController,
                        keyboardType: TextInputType.number,
                        suffixIcon: themeProvider.appTheme == ThemeMode.light
                            ? Image(image: AssetImage(AppAssets.showIcon))
                            : Image(image: AssetImage(AppAssets.darkShowIcon)),
                        obscureText: true,
                        onValidator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.please_enter_password;
                          }
                          if (text.length < 6) {
                            return AppLocalizations.of(
                              context,
                            )!.password_must_be_at_least_6;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context)!.forget_password,
                              style: AppStyles.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * .02),
                      CustomElevatedButton(
                        text: AppLocalizations.of(context)!.login,
                        onPressed: () {
                          login();
                        },
                      ),
                      SizedBox(height: height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.do_not_have_account,
                            style: (themeProvider.appTheme == ThemeMode.light
                                ? AppStyles.medium16Black
                                : AppStyles.medium16White),
                          ),
                          SizedBox(width: width * .01),
                          TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.registerRouteName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.create_account,
                              style: AppStyles.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * .02),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: AppColors.primaryLight,
                              indent: width * .10,
                              endIndent: width * .04,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.or,
                            style: AppStyles.medium16Primary,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: AppColors.primaryLight,
                              indent: width * .04,
                              endIndent: width * .10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * .02),
                      CustomElevatedButton(
                        text: AppLocalizations.of(context)!.login_with_google,
                        textStyle: AppStyles.medium20Primary,
                        isIcon: true,
                        iconWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppAssets.iconGoogle),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * .02),
                              child: Text(
                                AppLocalizations.of(context)!.login_with_google,
                                style: AppStyles.medium20Primary,
                              ),
                            ),
                          ],
                        ),

                        //iconWidget: Image.asset(AppAssets.iconGoogle),
                        backgroundColor: AppColors.transparentColor,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * .02),
                Container(
                  child: FlutterSwitch(
                    width: width * .30,
                    height: height * .06,
                    valueFontSize: 25.0,
                    toggleSize: 45.0,
                    value: status,
                    borderRadius: 30.0,
                    padding: 8.0,
                    activeColor: themeProvider.appTheme == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.primaryDark,
                    inactiveColor: themeProvider.appTheme == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.primaryDark,
                    toggleBorder: Border.all(
                      color: AppColors.primaryLight,
                      width: 3,
                    ),
                    switchBorder: Border.all(
                      color: AppColors.primaryLight,
                      width: 2,
                    ),
                    activeIcon: langageProvider.appLanguage == 'en'
                        ? Image(image: AssetImage(AppAssets.egyptImage))
                        : Image(image: AssetImage(AppAssets.americaImage)),
                    inactiveIcon: langageProvider.appLanguage == 'ar'
                        ? Image(image: AssetImage(AppAssets.egyptImage))
                        : Image(image: AssetImage(AppAssets.americaImage)),

                    onToggle: (val) {
                      langageProvider.appLanguage == 'en'
                          ? langageProvider.changeLanguage('ar')
                          : langageProvider.changeLanguage('en');
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate() == true) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
    }
  }
}

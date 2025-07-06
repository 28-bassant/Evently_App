import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var langageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool status = false;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.register,
          style: themeProvider.appTheme == ThemeMode.light
              ? AppStyles.bold16Black
              : AppStyles.bold16Primary,
        ),
        centerTitle: true,
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? AppColors.whiteBgColor
            : AppColors.primaryDark,
      ),
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
                        hintText: AppLocalizations.of(context)!.name,
                        prefixIcon: themeProvider.appTheme == ThemeMode.light
                            ? Image(image: AssetImage(AppAssets.iconUser))
                            : Image(image: AssetImage(AppAssets.darkUserIcon)),
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        onValidator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.please_enter_name;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * .02),
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
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.re_password,
                        prefixIcon: themeProvider.appTheme == ThemeMode.light
                            ? Image(image: AssetImage(AppAssets.iconPassword))
                            : Image(
                                image: AssetImage(AppAssets.darkPasswordIcon),
                              ),
                        controller: rePasswordController,
                        keyboardType: TextInputType.number,
                        suffixIcon: themeProvider == ThemeMode.light
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
                          if (passwordController.text != text) {
                            return AppLocalizations.of(
                              context,
                            )!.re_password_does_not_match_password;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * .02),
                      CustomElevatedButton(
                        text: AppLocalizations.of(context)!.create_account,
                        onPressed: () {
                          register();
                        },
                      ),
                      SizedBox(height: height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.already_have_account,
                            style: (themeProvider.appTheme == ThemeMode.light
                                ? AppStyles.medium16Black
                                : AppStyles.medium16White),
                          ),
                          SizedBox(width: width * .01),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: AppStyles.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
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

  void register() {
    if (formKey.currentState!.validate() == true) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeRouteName);
    }
  }
}

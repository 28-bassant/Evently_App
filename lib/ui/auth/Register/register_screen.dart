import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/auth/Register/register_navigator.dart';
import 'package:evently_app/ui/auth/Register/register_screen_view_model.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen>
    implements RegisterNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: 'bassant@gmail.com',
  );
  TextEditingController passwordController = TextEditingController(
    text: '123456',
  );
  TextEditingController nameController = TextEditingController(text: 'Bassant');
  TextEditingController rePasswordController = TextEditingController(
    text: '123456',
  );
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.registerNavigator = this;
  }
  @override
  Widget build(BuildContext context) {
    var langageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool status = false;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
                              : Image(
                              image: AssetImage(AppAssets.darkUserIcon)),
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          onValidator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
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
                              : Image(
                              image: AssetImage(AppAssets.darkEmailIcon)),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          onValidator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
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
                              : Image(
                              image: AssetImage(AppAssets.darkShowIcon)),
                          obscureText: true,
                          onValidator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
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
                              : Image(
                              image: AssetImage(AppAssets.darkShowIcon)),
                          obscureText: true,
                          onValidator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
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
                              AppLocalizations.of(context)!
                                  .already_have_account,
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
      ),
    );
  }

  void register() async {
    if (formKey.currentState!.validate() == true) {
      viewModel.register(emailController.text, passwordController.text);
    }
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showLoading(String message) {
    // TODO: implement showLoading
    DialogUtils.showLoading(context: context, loadingMsg: message);
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
    DialogUtils.showMsg(context: context, content: message,
        postActionName: 'Ok');
  }
// void register() async {
//   if (formKey.currentState!.validate() == true) {
//     //todo : show loading
//     DialogUtils.showLoading(context: context, loadingMsg: 'Loading...');
//     try {
//       //todo : sign up in firebase auth
//       final credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//       //todo: ave user in fireStore
//       MyUser myUser = MyUser(
//           id: credential.user?.uid ?? '',
//           name: nameController.text,
//           email: emailController.text);
//       await FirebaseUtils.addUserToFireStore(myUser);
//       //todo: save user in provider
//       var userProvider = Provider.of<UserProvider>(context, listen: false);
//       userProvider.updateUser(myUser);
//       var eventListProvider = Provider.of<EventListProvider>(
//           context, listen: false);
//       eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
//       eventListProvider.getAllFavouriteEventsFromFireStore(
//           userProvider.currentUser!.id);
//
//       //todo: hide loading
//       DialogUtils.hideLoading(context: context);
//       //todo: show message success
//       DialogUtils.showMsg(context: context,
//           content: 'Register Successfully',
//           title: 'Success',
//           postActionName: 'OK',
//           postFunc: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => HomeScreen()),
//                   (Route<dynamic> route) => false,
//             );
//           }
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         //todo: hide loading
//         DialogUtils.hideLoading(context: context);
//         //todo: show message
//         DialogUtils.showMsg(context: context,
//           content: 'The password provided is too weak.',
//           title: 'Error',
//           postActionName: 'OK',
//
//         );
//       } else if (e.code == 'email-already-in-use') {
//         //todo: hide loading
//         DialogUtils.hideLoading(context: context);
//         //todo: show message
//         DialogUtils.showMsg(context: context,
//           content: 'The account already exists for that email.',
//           title: 'Error',
//           postActionName: 'OK',
//
//         );
//       } else if (e.code == 'network-request-failed') {
//         //todo: hide loading
//         DialogUtils.hideLoading(context: context);
//         //todo: show message
//         DialogUtils.showMsg(context: context,
//           content: 'A network error such as (timeout - interrupted connection or unreachable host) has occured.',
//           title: 'Error',
//           postActionName: 'OK',
//
//         );
//       }
//     } catch (e) {
//       DialogUtils.hideLoading(context: context);
//       //todo: show message
//       DialogUtils.showMsg(context: context,
//         content: e.toString(),
//         title: 'Error',
//         postActionName: 'OK',
//
//       );
//     }
//   }
// }
}


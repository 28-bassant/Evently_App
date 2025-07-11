import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  Color? borderColor;
  String hintText;
  TextStyle? hintStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  OnValidator onValidator;
  TextInputType? keyboardType;
  TextEditingController? controller;
  bool obscureText;
  int? maxLines;

  CustomTextFormField({
    super.key,
    this.maxLines,
    this.borderColor,
    required this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onValidator,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: builtTextFieldBorder(
          borderColor:
              borderColor ??
              (themeProvider.appTheme == ThemeMode.light
                  ? AppColors.greyColor
                  : AppColors.primaryLight),
        ),
        focusedBorder: builtTextFieldBorder(borderColor: borderColor),
        errorBorder: builtTextFieldBorder(borderColor: AppColors.redColor),
        errorStyle: AppStyles.medium16Grey.copyWith(color: AppColors.redColor),

        hintText: hintText,
        hintStyle:
            hintStyle ??
            (themeProvider.appTheme == ThemeMode.light
                ? AppStyles.medium16Grey
                : AppStyles.medium16White),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      controller: controller,
      maxLines: maxLines ?? 1,
      style: themeProvider.appTheme == ThemeMode.light
          ? AppStyles.medium16Black
          : AppStyles.medium16White,
      validator: onValidator,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }

  OutlineInputBorder builtTextFieldBorder({required Color? borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: borderColor ?? AppColors.greyColor,
        width: 1,
      ),
    );
  }
}

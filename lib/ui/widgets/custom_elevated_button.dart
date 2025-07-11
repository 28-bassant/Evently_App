import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  VoidCallback? onPressed;
  String text;
  TextStyle? textStyle;
  Color backgroundColor;
  Color borderColor;
  bool isIcon;
  Widget? iconWidget;
  MainAxisAlignment mainAxisAlignment;

  CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.textStyle,
    this.backgroundColor = AppColors.primaryLight,
    this.borderColor = AppColors.primaryLight,
    this.isIcon = false,
    this.iconWidget,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: height * .02),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        side: MaterialStateProperty.all(
          BorderSide(color: borderColor, width: 1),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      child: isIcon
          ? iconWidget
          // ? Row(
          //     mainAxisAlignment: mainAxisAlignment,
          //     children: [
          //       iconWidget!,
          //       Padding(
          //         padding: EdgeInsets.symmetric(horizontal: width * .02),
          //         child: Text(
          //           text,
          //           style: textStyle ?? AppStyles.medium20White,
          //         ),
          //       ),
          //     ],
          //   )
          : Text(text, style: textStyle ?? AppStyles.medium20White),
    );
  }
}

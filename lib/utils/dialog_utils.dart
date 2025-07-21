import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String loadingMsg,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: AppColors.primaryLight),
              SizedBox(width: 8),
              Text(loadingMsg, style: AppStyles.medium16Black),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  static void showMsg({
    required BuildContext context,
    String? title,
    required String content,
    String? postActionName,
    Function? postFunc,
    String? negativeActionName,
    Function? negativeFunc,
  }) {
    List<Widget>? actions = [];
    if (postActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(postFunc != null){
            //   postFunc.call();
            // }
            postFunc?.call();
          },
          child: Text(postActionName, style: AppStyles.bold14Primary),
        ),
      );
    }
    if (negativeActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(postFunc != null){
            //   postFunc.call();
            // }
            negativeFunc?.call();
          },
          child: Text(negativeActionName, style: AppStyles.bold14red),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? '', style: AppStyles.bold16Black),
          content: Text(content, style: AppStyles.medium16Black),
          actions: actions,
        );
      },
    );
  }
}

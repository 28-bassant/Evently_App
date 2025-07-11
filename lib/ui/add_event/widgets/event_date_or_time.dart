import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';

class EventDateOrTime extends StatelessWidget {
  String eventDateOrItemName;
  String eventDateOrItemIcon;
  String chooseDateOrTime;
  VoidCallback chooseDateOrTimeClicked;

  EventDateOrTime({
    required this.eventDateOrItemIcon,
    required this.eventDateOrItemName,
    required this.chooseDateOrTime,
    required this.chooseDateOrTimeClicked,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(
          eventDateOrItemIcon,
          color: themeProvider.iSDark()
              ? AppColors.whiteColor
              : AppColors.blackColor,
        ),
        SizedBox(width: width * .02),
        Text(
          eventDateOrItemName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            chooseDateOrTimeClicked();
          },
          child: Text(chooseDateOrTime, style: AppStyles.medium16Primary),
        ),
      ],
    );
  }
}

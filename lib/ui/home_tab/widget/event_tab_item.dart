import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventTabItem extends StatelessWidget {
  bool isSelected;
  String eventName;

  EventTabItem({super.key, required this.eventName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * .02),
      padding: EdgeInsets.symmetric(
        horizontal: width * .025,
        vertical: height * .002,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(46),
        border: Border.all(color: Theme.of(context).focusColor, width: 2),
        color: isSelected
            ? Theme.of(context).focusColor
            : AppColors.transparentColor,
      ),
      child: Text(
        eventName,
        style: isSelected
            ? Theme.of(context).textTheme.headlineSmall
            : AppStyles.medium16White,
      ),
    );
  }
}

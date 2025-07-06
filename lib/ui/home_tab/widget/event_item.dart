import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * .02,
        vertical: height * .01,
      ),
      height: height * .31,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(AppAssets.birthdayImage),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: height * .02,
              horizontal: width * .02,
            ),
            padding: EdgeInsets.symmetric(
              vertical: height * .002,
              horizontal: width * .02,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
            child: Column(
              children: [
                Text('21', style: AppStyles.bold20Primary),
                Text('Nov', style: AppStyles.bold14Primary),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: height * .02,
              horizontal: width * .02,
            ),
            padding: EdgeInsets.symmetric(
              vertical: height * .01,
              horizontal: width * .02,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'This is a Birthday Party ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ImageIcon(
                  AssetImage(AppAssets.unSelectedFavouriteIcon),
                  color: AppColors.primaryLight,
                  size: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

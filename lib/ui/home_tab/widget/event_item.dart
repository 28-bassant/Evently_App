import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/event.dart';
import '../../../providers/event_list_provider.dart';

class EventItem extends StatelessWidget {
  Event event;

  EventItem({super.key,
    required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    return
      Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * .02,
        vertical: height * .01,
      ),
      height: height * .31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(event.image),
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
                Text(
                    event.dateTime.day.toString()
                    , style: AppStyles.bold20Primary),
                Text(
                    DateFormat('MMM').format(event.dateTime)
                    , style: AppStyles.bold14Primary),
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
                  event.title,
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

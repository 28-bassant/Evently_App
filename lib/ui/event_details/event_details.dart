import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/event_list_provider.dart';
import '../../providers/user_provider.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Event args = ModalRoute.of(context)?.settings.arguments as Event;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text('Event Details', style: AppStyles.medium20Primary),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.editEventRouteName, arguments: args);
            },
            child: ImageIcon(AssetImage(AppAssets.editEventIcon)),
          ),
          SizedBox(width: width * .02),
          InkWell(
            onTap: () {
              DialogUtils.showMsg(
                  context: context,
                  content: 'Are you Sure you want to delete event?',
                  negativeActionName: 'No',
                  negativeFunc: () {
                    Navigator.pop(context);
                  },
                  postActionName: 'Yes',
                  postFunc: () {
                    var userProvider = Provider.of<UserProvider>(
                        context, listen: false);

                    eventListProvider.deleteEvent(
                        args, userProvider.currentUser!.id);
                    Navigator.pop(context);
                  }


              );
            },
            child: ImageIcon(
              AssetImage(AppAssets.deleteEventIcon),
              color: AppColors.redColor,
            ),
          ),
          SizedBox(width: width * .02),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(image: AssetImage(args.image)),
              ),
              SizedBox(height: height * .02),
              Text(args.title, style: AppStyles.medium20Primary),
              SizedBox(height: height * .02),
              CustomElevatedButton(
                text: '',
                backgroundColor: AppColors.transparentColor,
                borderColor: AppColors.primaryLight,
                isIcon: true,
                iconWidget: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: width * .02,
                        vertical: height * .012,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: width * .02),
                      child: ImageIcon(
                        AssetImage(AppAssets.eventDateIcon),
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yMMMd').format(args.dateTime),
                          style: AppStyles.medium16Primary,
                        ),
                        Text(args.time, style: AppStyles.medium16Black),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .02),
              CustomElevatedButton(
                backgroundColor: AppColors.transparentColor,
                text: '',
                isIcon: true,
                iconWidget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .02),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .02,
                          vertical: height * .01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryLight,
                        ),
                        child: Image.asset(AppAssets.locationIcon),
                      ),
                      SizedBox(width: width * .02),
                      Text('Cairo , Egypt', style: AppStyles.medium16Primary),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.primaryLight,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              Image(image: AssetImage(AppAssets.mapImage)),
              SizedBox(height: height * .02),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: AppStyles.medium16Black,
                      textAlign: TextAlign.start,
                    ),
                    Text(args.description, style: AppStyles.medium16Black),
                  ],
                ),
              ),
              SizedBox(height: height * .02),
            ],
          ),
        ),
      ),
    );
  }
}

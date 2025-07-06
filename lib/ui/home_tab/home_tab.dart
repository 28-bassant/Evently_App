import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/home_tab/widget/event_tab_item.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.regular14White,),
                Text('Route Academy',
                  style: AppStyles.bold24White,),

              ],
            ),
            Row(
              children: [
                Image(image: AssetImage(AppAssets.themeIcon)),
                SizedBox(width: width * .02,),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * .02,
                      vertical: height * .01
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadiusGeometry.circular(8)
                  ),

                  child: Text('En',
                    style: AppStyles.bold14Primary,),
                )
              ],
            )
          ],
        ),
        bottom: AppBar(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )
          ),
          toolbarHeight: height * .09,
          title: Column(
            children: [
              Row(
                children: [
                  ImageIcon(AssetImage(AppAssets.unSelectedMapIcon),
                    color: AppColors.whiteColor,),
                  SizedBox(width: width * .02,),
                  Text('Cairo , Egypt', style: AppStyles.medium14White,)

                ],
              ),
              SizedBox(height: height * .01,),
              DefaultTabController(

                  length: eventNameList.length,
                  child: TabBar(
                      onTap: (index) {
                        selectedIndex = index;
                        setState(() {

                        });
                      },
                      isScrollable: true,
                      dividerColor: AppColors.transparentColor,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: AppColors.transparentColor,
                      tabs: eventNameList.map((eventName) {
                        return EventTabItem(eventName: eventName,
                            isSelected: selectedIndex == eventNameList.indexOf(
                                eventName));
                      },).toList())
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: ListView.separated(
              itemBuilder: (context, index) => EventItem(),
              separatorBuilder: (context, index) {
                return SizedBox(height: height * .01,);
              },
              itemCount: 20))
        ],
      ),
    );
  }
}

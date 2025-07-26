import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/event.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/home_tab/widget/event_tab_item.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late EventListProvider eventListProvider;
  late UserProvider userProvider;
  late Event event;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //eventListProvider.getAllFavouriteEvents();

      eventListProvider.getAllEvents(userProvider.currentUser!.id);

    });
  }
  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    eventListProvider.getEventNameList(context);
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }


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
                Text(userProvider.currentUser!.name,
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

                  length: eventListProvider.eventNameList.length,
                  child: TabBar(
                      onTap: (index) {
                        eventListProvider.changeSelectedIndex(
                            index, userProvider.currentUser!.id);
                      },
                      isScrollable: true,

                      dividerColor: AppColors.transparentColor,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: AppColors.transparentColor,
                      tabs: eventListProvider.eventNameList.map((eventName) {
                        return EventTabItem(
                            eventName: eventName,
                            isSelected: eventListProvider.selectedIndex ==
                                eventListProvider.eventNameList.indexOf(
                              eventName,
                            ),
                            isSelectedBgColor: Theme
                                .of(context)
                                .dividerColor,
                            selecetdEventTextStyle: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall
                        );
                      },).toList())
              )
            ],
          ),
        ),
      ),
      body: eventListProvider.filterEventsList.isEmpty ?
      Center(
        child: Text(AppLocalizations.of(context)!.no_events_found,
          style: AppStyles.bold20Black,),
      )
          : Column(
        children: [
          Expanded(child: ListView.separated(
              itemBuilder: (context, index) =>
                  EventItem(event: eventListProvider.filterEventsList[index],),
              separatorBuilder: (context, index) {
                return SizedBox(height: height * .01,);
              },
              itemCount: eventListProvider.filterEventsList.length))
        ],
      ),
    );
  }

}

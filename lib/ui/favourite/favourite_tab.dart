import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/event_list_provider.dart';
import '../home_tab/widget/event_item.dart';

class FavouriteTab extends StatefulWidget {
  FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  TextEditingController searchController = TextEditingController();
  @override
  late EventListProvider eventListProvider;

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //eventListProvider.getAllFavouriteEvents();
      eventListProvider.getAllFavouriteEventsFromFireStore();
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .02),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .02),
                child: CustomTextFormField(
                  hintText: AppLocalizations.of(context)!.search,
                  hintStyle: AppStyles.bold14Primary,
                  borderColor: AppColors.primaryLight,
                  prefixIcon: Image.asset(AppAssets.iconSearch),
                  controller: searchController,
                ),
              ),
              SizedBox(height: height * .01),
              Expanded(
                child: eventListProvider.favouriteEventsList.isEmpty ?
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.no_favourite_events_found,
                    style: AppStyles.bold20Black,),
                )
                    : ListView.separated(
                  itemBuilder: (context, index) =>
                      EventItem(
                          event: eventListProvider.favouriteEventsList[index]),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height * .01);
                  },
                  itemCount: eventListProvider.favouriteEventsList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../home_tab/widget/event_item.dart';

class FavouriteTab extends StatelessWidget {
  FavouriteTab({super.key});

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                child: ListView.separated(
                  itemBuilder: (context, index) => Container(),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: height * .01);
                  },
                  itemCount: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

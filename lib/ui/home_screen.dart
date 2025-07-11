import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/favourite/favourite_tab.dart';
import 'package:evently_app/ui/home_tab/home_tab.dart';
import 'package:evently_app/ui/map/map_tab.dart';
import 'package:evently_app/ui/profile/profile_tab.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  var width;
  List<Widget> tabs = [
    HomeTab(), MapTab(), FavouriteTab(), ProfileTab()
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.addEventRouteName);
      },
        child: Icon(Icons.add,
          color: AppColors.whiteColor,
          size: 30,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(30),
          side: BorderSide(
              color: AppColors.whiteColor,
              width: 6
          ),
        ),
        backgroundColor: Theme
            .of(context)
            .primaryColor,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Theme
            .of(context)
            .primaryColor,
        child: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: AppColors.transparentColor
          ),
          child: BottomNavigationBar(

            selectedLabelStyle: AppStyles.bold12White,
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {

              });
            },
            items: [

              builtBottomNavigationBarItem(

                  SelectedImageIcon: AppAssets.HomeIcon,
                  unSelectedImageIcon: AppAssets.unSelectedHomeIcon,
                  label: AppLocalizations.of(context)!.home,
                  index: 0),
              builtBottomNavigationBarItem(
                  SelectedImageIcon: AppAssets.MapIcon,
                  unSelectedImageIcon: AppAssets.unSelectedMapIcon,
                  label: AppLocalizations.of(context)!.map,
                  index: 1),

              builtBottomNavigationBarItem(
                  SelectedImageIcon: AppAssets.FavouriteIcon,
                  unSelectedImageIcon: AppAssets.unSelectedFavouriteIcon,
                  label: AppLocalizations.of(context)!.favourite,
                  index: 2),
              builtBottomNavigationBarItem(
                  SelectedImageIcon: AppAssets.ProfileIcon,
                  unSelectedImageIcon: AppAssets.unSelectedProfileIcon,
                  label: AppLocalizations.of(context)!.profile,
                  index: 3),

            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem(
      {required String SelectedImageIcon,
        required String unSelectedImageIcon,
        required String label,
        required int index,}) {
    return BottomNavigationBarItem(
        icon: Image.asset(
            index == selectedIndex ? SelectedImageIcon : unSelectedImageIcon),
        label: label);
  }
}

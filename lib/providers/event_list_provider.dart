import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/toast_utils.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../models/event.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  List<Event> filterEventsList = [];
  List<Event> favouriteEventsList = [];
  List<String> eventNameList = [];
  int selectedIndex = 0;


  List<String> getEventNameList(BuildContext context) {
    return eventNameList = [
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
  }

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapShot =
        await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventsList = eventsList;
    filterEventsList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEvents() async {
    QuerySnapshot<Event> querySnapShot =
        await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventsList = eventsList.where((event) {
      return event.eventName == eventNameList[selectedIndex];
    }).toList();
    filterEventsList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEventsFromFireStore() async {
    var querySnapShot = await FirebaseUtils.getEventCollection()
        .orderBy('dateTime')
        .where('eventName', isEqualTo: eventNameList[selectedIndex])
        .get();
    filterEventsList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void UpdateEvents(Event event) {
    FirebaseUtils.getEventCollection().doc(event.id).
    update({'isFavourite': !event.isFavourite}).timeout(Duration(
      milliseconds: 500,

    ),
      onTimeout: () {
        ToastUtils.ShowToast(
            msg: 'Event Updated Successfully',
            bgColor: AppColors.greenColor,
            textColor: AppColors.whiteColor);
      },);
    selectedIndex == 0 ? getAllEvents() : getFilterEventsFromFireStore();
    //getAllFavouriteEvents();
    getAllFavouriteEventsFromFireStore();
    notifyListeners();
  }

  void getAllFavouriteEvents() async {
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils
        .getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    favouriteEventsList = eventsList.where((event) {
      return event.isFavourite == true;
    }).toList();
    favouriteEventsList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    },);
    notifyListeners();
  }

  void getAllFavouriteEventsFromFireStore() async {
    var querySnapShot = await FirebaseUtils.getEventCollection().
    orderBy('dateTime').where('isFavourite', isEqualTo: true).get();
    favouriteEventsList = querySnapShot.docs.map((doc) {
      return doc.data();
    }
    ).toList();electedIndex == 0 ? getAllEvents() : getFilterEventsFromFireStore();
    nnotifyListeners();

  }oid deleteEvent(Event event) {
    var querySnapShot = FirebaseUtils.getEventCollection()
        .doc(event.id)
        .delete()
        .timeout(
          Duration(milliseconds: 500),
          onTimeout: () {
            ToastUtils.ShowToast(
              msg: 'Event deleted Successfully',
              bgColor: AppColors.redColor,
              textColor: AppColors.whiteColor,
            );
          },
        );
    selectedIndex == 0 ? getAllEvents() : getFilterEventsFromFireStore();
    notifyListeners();
  }

  void changeSelectedIndex(int newIndex) {
    selectedIndex = newIndex;
    selectedIndex == 0 ? getAllEvents() : getFilterEventsFromFireStore();
  }
}

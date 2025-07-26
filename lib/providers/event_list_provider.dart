import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/toast_utils.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../models/event.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  List<Event> filterEventsList = [];
  List<Event> favouriteEventsList = [];
  List<String> eventNameList = [];
  int selectedIndex = 0;
  Event? updateEvent;
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

  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapShot =
    await FirebaseUtils.getEventCollection(uId).get();
    eventsList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventsList = eventsList;
    filterEventsList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getFilterEvents(String uId) async {
    QuerySnapshot<Event> querySnapShot =
    await FirebaseUtils.getEventCollection(uId).get();
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

  void getFilterEventsFromFireStore(String uId) async {
    var querySnapShot = await FirebaseUtils.getEventCollection(uId)
        .orderBy('dateTime')
        .where('eventName', isEqualTo: eventNameList[selectedIndex])
        .get();
    filterEventsList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void UpdateEvents(Event event, String uId) {
    FirebaseUtils.getEventCollection(uId).doc(event.id).
    update({'isFavourite': !event.isFavourite}).then((value) {
      ToastUtils.ShowToast(
          msg: 'Event Updated Successfully',
          bgColor: AppColors.greenColor,
          textColor: AppColors.whiteColor);
      selectedIndex == 0 ? getAllEvents(uId) : getFilterEventsFromFireStore(
          uId);
      //getAllFavouriteEvents();
      getAllFavouriteEventsFromFireStore(uId);
    },);


    //     .timeout(Duration(
    //   milliseconds: 500,
    //
    // ),
    //   onTimeout: () {
    //     ToastUtils.ShowToast(
    //         msg: 'Event Updated Successfully',
    //         bgColor: AppColors.greenColor,
    //         textColor: AppColors.whiteColor);
    // selectedIndex == 0 ? getAllEvents() : getFilterEventsFromFireStore();
    // //getAllFavouriteEvents();
    // getAllFavouriteEventsFromFireStore();
    //   },);

    notifyListeners();
  }

  void getAllFavouriteEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils
        .getEventCollection(uId).get();
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

  void getAllFavouriteEventsFromFireStore(String uId) async {
    var querySnapShot = await FirebaseUtils.getEventCollection(uId).
    orderBy('dateTime').where('isFavourite', isEqualTo: true).get();
    favouriteEventsList = querySnapShot.docs.map((doc) {
      return doc.data();
    }
    ).toList();
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEventsFromFireStore(uId);
    notifyListeners();
  }

  void deleteEvent(Event event, String uId) {
    var querySnapShot = FirebaseUtils.getEventCollection(uId)
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
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEventsFromFireStore(uId);
    notifyListeners();
  }

  void editEvent(Event event, String uId) async {
    await FirebaseUtils.getEventCollection(uId).doc(event.id).update(
        event.toFireStore());
    ToastUtils.ShowToast(
      msg: 'Event Edited Successfully',
      bgColor: AppColors.greenColor,
      textColor: AppColors.whiteColor,
    );
    notifyListeners();
  }

  void changeSelectedIndex(int newIndex, String uId) {
    selectedIndex = newIndex;
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEventsFromFireStore(uId);
  }
}

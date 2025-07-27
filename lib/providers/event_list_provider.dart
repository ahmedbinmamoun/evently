import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/model/event.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/firebase_utils.dart';
import 'package:event/utils/toastUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  List<Event> filterEventsList = [];
  List<String> eventNameList = [];
  List<Event> favoriteEventList = [];
  int selectedIndex = 0;

  List<String> getEventNameList(BuildContext context) {
    return eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sports,
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
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(
          uId,
        ).orderBy('event_date_time').get();
    eventsList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
    filterEventsList = eventsList;
    notifyListeners();
  }

  // void getFilterEvents()async{
  //   var querySnapshot = await FirebaseUtils.getEventCollection().get();
  //   eventsList = querySnapshot.docs.map((doc) {
  //     return doc.data();
  //   },).toList();
  //   filterEventsList = eventsList.where((event) {
  //     return event.eventName == eventNameList[selectedIndex];
  //   },).toList();
  //   notifyListeners();
  // }

  void getFilterEventsFromFireStore(String uId) async {
    var querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .orderBy('event_date_time')
            .where('event_name', isEqualTo: eventNameList[selectedIndex])
            .get();
    filterEventsList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
    notifyListeners();
  }

  void updateIsFavorite(Event event, String uId) {
    FirebaseUtils.getEventCollection(
      uId,
    ).doc(event.id).update({'is_favorite': !event.isFavorite}).then((value) {
      Toastutils.toastMsg(
        msg: 'Event updated',
        backgroundColor: AppColors.primaryLight,
        textColor: AppColors.whiteColor,
      );
      selectedIndex == 0
          ? getAllEvents(uId)
          : getFilterEventsFromFireStore(uId);
      getAllFavoriteEvent(uId);
    });

    notifyListeners();
  }

  void updateEvent(Event updatedEvent) {
    int index = eventsList.indexWhere((e) => e.id == updatedEvent.id);
    if (index != -1) {
      eventsList[index] = updatedEvent;
      notifyListeners();
    }
  }

  void getAllFavoriteEvent(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
    eventsList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();

    favoriteEventList =
        eventsList.where((event) {
          return event.isFavorite == true;
        }).toList();
    notifyListeners();
  }

  void getAllFavoriteEventFromFirsStore(String uId) async {
    var querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .orderBy('event_date_time')
            .where('is_favorite', isEqualTo: true)
            .get();
    favoriteEventList =
        querySnapshot.docs.map((doc) {
          return doc.data();
        }).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEventsFromFireStore(uId);
  }
}

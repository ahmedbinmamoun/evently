import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/model/event.dart';
import 'package:event/utils/app_assets.dart';
import 'package:event/utils/app_colors.dart';
import 'package:event/utils/firebase_utils.dart';
import 'package:event/utils/toastUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  List<Event> filterEventsList = [];
  List<Event> favoriteEventList = [];
  int selectedIndex = 0;
  Map<String,String> eventCategoryMap = {
    'all' : 'All',
    'sports' : 'Sports',
    'birthday' : 'Birthday',
    'meeting' : 'Meeting',
    'gaming' : 'Gaming',
    'workshop' : 'Workshop',
    'book_club' : 'Book Club',
    'exhibition' : 'Exhibition',
    'holiday' : 'Holiday',
    'eating' : 'Eating',
  };
  List<String> eventCategoryKeys = [];
  List<String> eventNameList = [];
  List<Event> searchedFavoriteList = [];

  List<String> eventIcons = [
    AppAssets.allIcon,
    AppAssets.sportIcon,
    AppAssets.birthdayIcon,
    AppAssets.meetingIcon,
    AppAssets.gamingIcon,
    AppAssets.workshopIcon,
    AppAssets.bookClubIcon,
    AppAssets.exhibitionIcon,
    AppAssets.holidayIcon,
    AppAssets.eatingIcon,
    
  ];

  List<String> getEventNameList(BuildContext context) {
    eventCategoryKeys = eventCategoryMap.keys.toList();
    return eventNameList = eventCategoryKeys.map((key) {
      switch (key) {
        case 'all':
          return AppLocalizations.of(context)!.all;
        case 'sports':
          return AppLocalizations.of(context)!.sports;
        case 'birthday':
          return AppLocalizations.of(context)!.birthday;
        case 'meeting':
         return AppLocalizations.of(context)!.meeting;
        case 'gaming':
          return AppLocalizations.of(context)!.gaming;
        case 'workshop':
          return AppLocalizations.of(context)!.workshop;
        case 'book_club':
          return AppLocalizations.of(context)!.book_club;
        case 'exhibition':
          return AppLocalizations.of(context)!.exhibition;
        case 'holiday':
          return AppLocalizations.of(context)!.holiday;
        case 'eating':
        return AppLocalizations.of(context)!.eating;
        default:
          return '';
      }
    }).toList();
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
    final selectedKey = eventCategoryKeys[selectedIndex];
    if (selectedKey == 'all') {
      getAllEvents(uId);
      return;
    }
    var querySnapshot = await FirebaseUtils.getEventCollection(uId)
        .orderBy('event_date_time')
        .where('event_name', isEqualTo: selectedKey)
        .get();
    filterEventsList = querySnapshot.docs.map((doc) => doc.data()).toList();
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
        searchedFavoriteList = favoriteEventList;
    notifyListeners();
  }


  void searchFavoriteEvents(String query) {
  if (query.isEmpty) {
    searchedFavoriteList = favoriteEventList;
  } else {
    searchedFavoriteList = favoriteEventList.where((event) {
      final lowerQuery = query.toLowerCase();
      return event.title.toLowerCase().contains(lowerQuery) ||
             event.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }
  notifyListeners();
}

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEventsFromFireStore(uId);
  }
}

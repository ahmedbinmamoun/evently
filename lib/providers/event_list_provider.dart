import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/model/event.dart';
import 'package:event/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier{

  List<Event> eventsList = [];
  List<Event> filterEventsList = [];
   List<String> eventNameList = [];
   List<Event> favoriteEventList = [];
   int selectedIndex = 0;
   Map<int,String> filterMap = {

   };

    List<String> getEventNameList(BuildContext context){
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

  void getAllEvents()async{
   QuerySnapshot<Event> querySnapshot = await  FirebaseUtils.getEventCollection()
   .orderBy('event_date_time')
   .get();
   eventsList = querySnapshot.docs.map((doc) {
     return doc.data();
   },).toList();
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
 
  void getFilterEventsFromFireStore()async{
    var querySnapshot = await FirebaseUtils.getEventCollection()
    .orderBy('event_date_time')
    .where('event_name',
    isEqualTo: eventNameList[selectedIndex]).get();
    filterEventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();
    notifyListeners();
  }
 
  void updateIsFavorite(Event event){
   FirebaseUtils.getEventCollection().doc(event.id)
   .update({'is_favorite':!event.isFavorite}).timeout(Duration(milliseconds: 500),
   onTimeout: (){
    print('updated');
   });
   selectedIndex ==0 ? getAllEvents() : getFilterEventsFromFireStore();
   getAllFavoriteEvent();
   notifyListeners();
  }

  void getAllFavoriteEvent()async{
    var querySnapshot = await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    },).toList();

    favoriteEventList = eventsList.where((event) {
      return event.isFavorite == true;
    },).toList();
    notifyListeners();
  }

  void getAllFavoriteEventFromFirsStore()async{
     var querySnapshot = await FirebaseUtils.getEventCollection().orderBy('event_date_time')
     .where('is_favorite',isEqualTo: true).get();
     favoriteEventList = querySnapshot.docs.map((doc) {
       return doc.data();
     },).toList();
     notifyListeners();

  }

  void changeSelectedIndex(int newSelectedIndex){
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getAllEvents() : getFilterEventsFromFireStore();
  }

}


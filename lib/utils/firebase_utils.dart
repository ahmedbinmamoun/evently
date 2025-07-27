import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/model/event.dart';
import 'package:event/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection().doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore:
              (snapshot, options) => Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter<MyUser>(
      fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()!),
       toFirestore: (myUser, options) => myUser.toFireStore(),
       );
  }

  static Future<void> addUserToFireStore(MyUser myUser){
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readDataFromFireStore(String id)async{
   var querySnapshot = await getUserCollection().doc(id).get();
   return querySnapshot.data();
  }

  static Future<void> addEventToFireStore(Event event,String uId) {
    CollectionReference<Event> collectionRef = getEventCollection(uId);
    DocumentReference<Event> docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Future<void> updateEvent(Event event,String uId) {
    CollectionReference<Event> collectionRef = getEventCollection(uId);
    DocumentReference<Event> docRef = collectionRef.doc(event.id);
    return docRef.update(event.toFireStore());
  }
}

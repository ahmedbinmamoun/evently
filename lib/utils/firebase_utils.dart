import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(){
   return FirebaseFirestore.instance.collection(Event.collectionName)
    .withConverter<Event>(
      fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!), 
      toFirestore: (event, options) => event.toFireStore(),);
  }
  static Future<void> addEventToFireStore(Event event){
    CollectionReference<Event> collectionRef = getEventCollection();
    DocumentReference<Event> docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}
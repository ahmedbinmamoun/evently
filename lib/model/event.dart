class Event {
  static const String collectionName = 'Events';
  String id ;
  String eventImage;
  String eventName;
  String title;
  String description;
  DateTime eventDateTime;
  String eventTime;
  bool isFavorite;

  Event({
    this.id = '',
  required this.eventImage,
  required this.eventName,
  required this.title,
  required this.description,required this.eventDateTime,required this.eventTime,
   this.isFavorite = false
   });

   Event.fromFireStore(Map<String, dynamic> data):this(
    id: data['id'],
    eventImage: data['event_image'],
    eventName: data['event_name'],
    title: data['title'],
    description: data['description'],
    eventDateTime: DateTime.fromMillisecondsSinceEpoch(data['event_date_time']),
    eventTime: data['event_time'],
    isFavorite: data['is_favorite'],
   );

   Map<String, dynamic> toFireStore(){
    return {
      'id': id,
      'event_image' : eventImage,
      'event_name' : eventName,
      'title' : title,
      'description' : description,
      'event_date_time' : eventDateTime.millisecondsSinceEpoch,
      'event_time' : eventTime,
      'is_favorite' : isFavorite,
    };
   }
}
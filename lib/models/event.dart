class Event {
  static const String collectionName = 'Events';
  String id;
  String title;
  String description;
  String image;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavourite;

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.image,
    required this.dateTime,
    required this.eventName,
    required this.time,
    this.isFavourite = false,
  });

  //todo: object => Json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'eventName': eventName,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      'isFavourite': isFavourite,
    };
  }

  //todo : Json => object
  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        image: data['image'],
        eventName: data['eventName'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
        time: data['time'],
        isFavourite: data['isFavourite'],
      );
}

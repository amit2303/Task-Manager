import 'package:cloud_firestore/cloud_firestore.dart';


class Task {
  String id;
  String user;
  String title;
  String description;

  DateTime deadline;
  Duration expectedDuration;

  bool isComplete = false;

  Task(
    this.id,
    this.user,
    this.title,
    this.description,

    this.deadline,
    this.expectedDuration,
    this.isComplete,  

  );

  
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'user':user,
      'description': description,

      'deadline': Timestamp.fromDate(deadline),

      'expectedDuration': expectedDuration.inHours,
      'isComplete': isComplete,
    };
  }

  factory Task.fromMap(String id, Map<String, dynamic> map) {
    return Task(
      id,
      map['user'],
      map['title'],
      map['description'],

      (map['deadline'] as Timestamp).toDate(),
      Duration(hours: map['expectedDuration']),
      map['isComplete'],
      // timeFromString(map['deadline_time'])

    );
  }
  // static TimeOfDay timeFromString(String timeString) {

  //   String timeFormat = timeString.replaceAll('TimeOfDay(', '').replaceAll(')', '');
  //   List<String> parts = timeFormat.split(':');
  //   int hour = int.parse(parts[0].trim());
  //   int minute = int.parse(parts[1].trim());

  //   return TimeOfDay(hour: hour, minute: minute);
  // }

  }




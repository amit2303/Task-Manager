import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/services/firestore_services.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:task_manager/services/notifi_services.dart';
import 'package:timezone/data/latest.dart' as tz;


class TaskFormPage extends StatefulWidget {
  final Task? task;

  TaskFormPage({this.task});

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final FirestoreService _firestoreService = FirestoreService();
  final NotificationService _notificationService = NotificationService();


  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  DateTime deadline =DateTime.now();
  Duration _expectedDuration = Duration(hours: 0);


    //loggedin USer
      final _auth = FirebaseAuth.instance;
      late User loggedInUser;

      void getCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        setState(() {
          loggedInUser = user;

        });
        // print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _notificationService.initNotification();
    getCurrentUser();

    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      deadline=widget.task!.deadline;
      _expectedDuration = widget.task!.expectedDuration;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      width: double.maxFinite,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),

            




              TextFormField(
              decoration: InputDecoration(
                labelText: 'Deadline',
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
              readOnly: true,
              onTap: () async {
          DateTime? picked =await DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          // onChanged: (date) {deadline=date;},
          // onConfirm: (date) {deadline=date;},
        );


                if (picked != null) {
                  setState(() {
                    deadline = picked;
                  });
                }
              },
              validator: (value) {
                if (deadline == null) {
                  return 'Please select a deadline';
                }
                return null;
              },
              controller: TextEditingController(
                text: deadline.toString(),
              ),
            ),






           



            




            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Expected Duration (Hours)',
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _expectedDuration = Duration(hours: int.parse(value));
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an expected duration';
                }
                return null;
              },
              controller: TextEditingController(
                text: 
                    _expectedDuration.inHours.toString(),
              ),
            ),
            SizedBox(height: 20),


            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Task task = Task(
                        widget.task?.id ?? '',
                        loggedInUser.email!,
                        _titleController.text,
                        _descriptionController.text,

                        deadline,
                        _expectedDuration,
                        widget.task?.isComplete ?? false,);

                    if (widget.task == null) {
                      // If the task is null, add a new task
                      _firestoreService.addTask(task);
                    } else {
                      // If the task is not null, update the existing task
                      _firestoreService.updateTask(task);
                    }

                        _notificationService.scheduleNotification(
      id: task.id.hashCode, // Unique ID for the notification
      title: task.title,
      body: 'Task deadline in 10 minutes!',
      scheduledNotificationDateTime: task.deadline.subtract(Duration(minutes: 10)),
    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  widget.task == null ? 'Create Task' : 'Update Task',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

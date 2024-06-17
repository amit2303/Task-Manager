import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/services/firestore_services.dart';
import 'package:task_manager/pages/login.dart';
import 'package:task_manager/pages/task_form_page.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/model/task_tile.dart';
import 'package:intl/intl.dart';

final FirestoreService _firestoreService = FirestoreService();

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

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



   void _signOut() async {
    try {
      await _auth.signOut();

      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Replace LoginPage with your login screen
      (Route<dynamic> route) => false, // Prevent going back to the tasks screen
    );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {

    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Tasks', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout,color: Colors.white,),
            onPressed: _signOut,
          ),
        ],
      ),
      body: StreamBuilder<List<Task>>(
        stream: _firestoreService.getTasks(loggedInUser.email!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data;
          return ListView.builder(
            itemCount: tasks!.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return TaskTile(
                task: task.title,
                description: task.description,
                // deadline_date: DateFormat.yMd().format(task.deadline_date),
                // deadline: task.deadline.toString(),
                deadline:DateFormat('dd/MM/yy hh:mm a').format(task.deadline),

                taskDuration: task.expectedDuration.inHours.toString(),
                ontap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                              child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: TaskFormPage(task: task),
                          )));
                },
                onLongPress: () {
                  _firestoreService.deleteTask(task.id);
                },
                isChecked: task.isComplete,
                toggleCheckbox: (bool? value) async {
                  await _firestoreService.toggleTaskCompletion(task);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                      child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TaskFormPage(),
                  )));
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_manager/services/notifi_services.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();
  runApp(TaskManager());
}


class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
      
    );
  }
}




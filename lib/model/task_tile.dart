import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskTile extends StatelessWidget {
  final String task;
  final String description;

  final String deadline;

  final String taskDuration;
  final bool isChecked;
  final Function(bool?)? toggleCheckbox;
  late Function() ontap;
  late Function() onLongPress;

   TaskTile({
    Key? key,
    required this.task,
    required this.description,

    required this.deadline,

    required this.taskDuration,
    required this.ontap,
    required this.onLongPress,
    required this.isChecked,
    required this.toggleCheckbox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
        side: const BorderSide(width: 1.0, color: Color.fromARGB(255, 0, 0, 0)), // Border color & width
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            
            title: Text(
              task,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  description,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.calendar_month, size: 16.0, color: Colors.black),
                    SizedBox(width: 4.0),
                    Text(deadline,style: TextStyle(fontSize: 14.0, color: Colors.grey),),


                    SizedBox(width: 10.0),




                    Icon(Icons.timer, size: 20.0, color: Colors.black),
                    SizedBox(width: 4.0),
                    Text('${taskDuration} Hours',style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      
                    ),
                  ],
                ),
              ],
            ),
            onTap: ontap,
            onLongPress: onLongPress,
                    ),
          ),
          Checkbox(
            fillColor: WidgetStateColor.resolveWith((states) => Colors.black),
            value: isChecked,
            onChanged: toggleCheckbox,
          ),],
      ),
    );
  }
}

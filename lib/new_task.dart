import 'package:flutter/material.dart';
import 'package:tababar/db_helper.dart';
import 'package:tababar/task_model.dart';
import 'constants.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool isComplete = false;

  String taskName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (val) {
                this.taskName = val;
              },
            ),
            Checkbox(
                value: isComplete,
                onChanged: (value) {
                  this.isComplete = value;
                  setState(() {});
                }),
            RaisedButton(
                child: Text('Add New Task'),
                onPressed: () {
                  DBHelper.myDatabase
                      .insertTask(Task(this.taskName, this.isComplete));
                      taskList.add(Task(this.taskName, this.isComplete));
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}

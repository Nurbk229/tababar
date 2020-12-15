import 'package:flutter/material.dart';
import 'package:tababar/task_model.dart';

import 'db_helper.dart';

List<Task> taskList = [];

Future getAllTask() async {
  List<Task> taskLists = List();
  await DBHelper.myDatabase
      .getAllTask()
      .then((value) => value.forEach((element) {
            taskLists.add(Task.fromMap(element));
          }))
      .whenComplete(() => taskList.addAll(taskLists));
}

Future<bool> deleteItem(BuildContext context, Task task) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to Delete Task ?"),
          actions: [
            FlatButton(
              child: Text("Yes"),
              onPressed: () async {
                Navigator.pop(context);
                return true;
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

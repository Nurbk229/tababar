import 'package:flutter/material.dart';
import 'package:tababar/constants.dart';
import 'package:tababar/db_helper.dart';
import 'package:tababar/new_task.dart';
import 'package:tababar/task_model.dart';

class TabBarPage extends StatefulWidget {
  User user;

  TabBarPage(this.user);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var i = 1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return NewTask();
                },
              ));
            }),
      ),
      appBar: AppBar(

        title: Text("My Tasks"),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: "All Task",
            ),
            Tab(
              text: "Complete Tasks",
            ),
            Tab(
              text: "InComplete Tasks",
            ),
          ],
          isScrollable: true,
        ),
      ),
      body: Column(children: [
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [AllTasks(), CompleteTasks(), InCompleteTasks()],
          ),
        ),
      ]),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: taskList
              .where((element) =>
                  element.isComplete == false || element.isComplete == true)
              .map((e) => TasksWidget(e, myFun))
              .toList()),
    );
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: taskList
              .where((element) => element.isComplete == true)
              .map((e) => TasksWidget(e, myFun))
              .toList()),
    );
  }
}

class InCompleteTasks extends StatefulWidget {
  @override
  _InCompleteTasksState createState() => _InCompleteTasksState();
}

class _InCompleteTasksState extends State<InCompleteTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: taskList
              .where((element) => element.isComplete == false)
              .map((e) => TasksWidget(e, myFun))
              .toList()),
    );
  }
}

// ignore: must_be_immutable
class TasksWidget extends StatefulWidget {
  Task task;
  Function function;

  TasksWidget(this.task, [this.function]);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // MyDatabase.myDatabase.deleteTask(this.widget.task.id);
                  // taskList.remove(this.widget.task);
                  deleteItem(context, widget.task).then((value)
                    {
                      DBHelper.myDatabase.deleteTask(widget.task.id);
                      taskList.remove(widget.task);
                      setState(() {
                        this.widget.function();
                      });
                    }
                  );
                }),
            Text(this.widget.task.taskName),
            Checkbox(
                value: widget.task.isComplete,
                onChanged: (value) {
                  this.widget.task.isComplete = value;
                  DBHelper.myDatabase.updateTask(this.widget.task);
                  setState(() {});
                  this.widget.function();
                })
          ],
        ),
      ),
    );
  }
}

class NewLecture extends StatefulWidget {
  @override
  _NewLectureState createState() => _NewLectureState();
}

class _NewLectureState extends State<NewLecture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New"),
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.blueAccent,
            );
          },
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(taskList[index].taskName),
              trailing: Checkbox(
                  value: taskList[index].isComplete,
                  onChanged: (value) {
                    taskList[index].isComplete = value;
                    setState(() {});
                  }),
            );
          },
          itemCount: taskList.length,
        ),
      ),
    );
  }
}

class Task2 extends StatefulWidget {
  @override
  _Task2 createState() => _Task2();
}

class _Task2 extends State<Task2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NewTask();
                  },
                ));
              })
        ],
        title: Text("New"),
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.black12,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(taskList[index].taskName),
                      Checkbox(
                          value: taskList[index].isComplete,
                          onChanged: (value) {
                            taskList[index].isComplete = value;
                            setState(() {});
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class User {
  String name;
  String email;

  User(this.name, this.email);
}

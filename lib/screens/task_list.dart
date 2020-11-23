import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hello_world/models/task.dart';

class TaskList extends StatefulWidget {
  TaskList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> taskList = List<Task>();

  TextEditingController controller = TextEditingController();

  void addTask(String text) {
    Task task = Task(text);
    setState(() {
      taskList.add(task);
    });
    controller.clear();
  }

  void setDone(Task task) {
    setState(() {
      task.done ? task.turnUndone() : task.turnDone();
    });
  }

  Widget snackBar(Task deletedItem) {
    return SnackBar(
      content: Text("Task deleted"),
      action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              taskList.add(deletedItem);
            });
          }),
    );
  }

  Widget item(Task task) {
    var formatter = DateFormat('dd/MM/yyyy');
    var formattedDate = formatter.format(task.date);

    return Builder(
      builder: (context) => Dismissible(
        key: Key(task.date.toString()),
        background: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onDismissed: (direction) => {
          setState(() {
            taskList.remove(task);
            Scaffold.of(context).showSnackBar(snackBar(task));
          })
        },
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                task.done ? Icons.check_box : Icons.check_box_outline_blank,
                size: 64.0,
                color: Colors.blue,
              ),
              padding: EdgeInsets.only(left: 10, right: 40.0, bottom: 40),
              onPressed: () => setDone(task),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${task.name}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: task.done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                Text(
                  '$formattedDate',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: TextField(
              onSubmitted: (value) => addTask(value),
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                  hintText: 'What do you need to do?'),
              controller: controller,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) => item(taskList[index]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Task List',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
        body: content());
  }
}

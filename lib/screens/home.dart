import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/task.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
      task.done? task.turnUndone() : task.turnDone();
    });
  }

  Widget item(Task task) {
    var formatter = DateFormat('dd/MM/yyyy');
    var formattedDate = formatter.format(task.date);

    return Dismissible(
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
        })
      },
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              task.done? Icons.check_box : Icons.check_box_outline_blank,
              size: 64.0,
              color: task.done? Colors.teal : Colors.black54,
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
                    decoration: task.done? TextDecoration.lineThrough : TextDecoration.none,
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
    );
  }

  Widget content() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextField(
            onSubmitted: (value) => addTask(value),
            style: TextStyle(
            fontSize: 18,
            ),
            controller: controller,
          ),
        ),
        Expanded(
            child: ListView.separated(
            itemCount: taskList.length,
            itemBuilder: (context, index) => item(taskList[index]),
              separatorBuilder: (context, index) => Divider(
                indent: 20,
                endIndent: 20,
                color: Colors.black45,
              ),
            )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Task List'),
        ),
        body: content());
  }
}

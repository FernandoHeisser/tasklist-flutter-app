import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget content() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'TaskList',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ),
          Container(
            child: Image.network(
              "https://icon-library.com/images/icon-task/icon-task-14.jpg",
              height: 300,
              width: 200,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              'Welcome to TaskList Flutter app',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Container(
            child: MaterialButton(
              height: 45,
              minWidth: 200,
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Color.fromRGBO(10, 111, 194, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Go to Task List page'),
              onPressed: () {
                Navigator.pushNamed(context, '/tasklist');
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: content()),
    );
  }
}

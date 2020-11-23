import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/screens/home.dart';
import 'package:hello_world/screens/task_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    ThemeData theme() {
      return ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          brightness: Brightness.light,
        ),
      );
    }

    return MaterialApp(
      title: 'Task List',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/tasklist': (context) => TaskList(),
      },
    );
  }
}

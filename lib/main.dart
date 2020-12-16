import 'package:exam_arrangement/screen/CancelPage.dart';
import 'package:exam_arrangement/screen/DutyPage.dart';
import 'package:flutter/material.dart';
import 'package:exam_arrangement/screen/AddDuty.dart';
import 'package:exam_arrangement/screen/login_screen.dart';
void main() => runApp(new MyApp());

final routes = {
  '/login_sqlite': (BuildContext context) => new LoginPage(),
  '/': (BuildContext context) => new LoginPage(),
  '/cancel_page': (BuildContext context) => new CancelPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
   // supportedLocales: const [Locale('en', 'GB')],
      title: 'Sqflite App',
      theme: new ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}

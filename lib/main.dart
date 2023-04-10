import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTasks',
      theme: ThemeData(
        // ignore: prefer_const_constructors
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black,
            onPrimary: Colors.white,
            secondary: Colors.black,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.blue,
            onBackground: Colors.blue,
            surface: Colors.transparent,
            onSurface: Colors.white),
        // textTheme: const TextTheme(bodyLarge: TextStyle(fontFamily: 'Open Sans', color: Colors.white))
      ),
      home: Home(),
    );
  }
}

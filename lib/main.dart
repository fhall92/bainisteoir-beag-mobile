import 'package:bainisteoir_beag/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bainisteoir Beag',
      theme: ThemeData(
        primaryColor: Color(0xffffffff),
      ),
      home: SplashScreen(),
    );
  }
}

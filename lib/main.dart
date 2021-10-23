import 'package:flutter/material.dart';

import 'Screens/HomeScreen.dart';
import 'Screens/loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primaryColor:Color(0xFF075E54),
        // accentColor: Color(0xFF128C7E),
        primarySwatch: Colors.teal,
      ),
      home: const LoginScreen(),
    );
  }
}


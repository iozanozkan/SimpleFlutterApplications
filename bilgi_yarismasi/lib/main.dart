import 'package:flutter/material.dart';
import 'package:bilgi_yarismasi/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BuildQuestionScreen());
  }
}

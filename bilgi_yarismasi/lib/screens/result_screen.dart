import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildResultScreen extends StatelessWidget {
  List<int> results;
  BuildResultScreen(this.results);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[700],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            buildExpanded("Doğru Cevap\n", 0),
            buildExpanded("Yanlış Cevap\n", 1)
          ],
        ),
      ),
    );
  }

  Expanded buildExpanded(String text, int index) {
    return Expanded(
      child: Center(
        child: Text(
          text + this.results[index].toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25.0, color: Colors.white),
        ),
      ),
    );
  }
}

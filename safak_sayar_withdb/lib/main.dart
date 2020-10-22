import 'package:flutter/material.dart';
import 'package:safak_sayar_withdb/screens/build_main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safak_sayar_withdb/screens/calculate_screen.dart';
import 'package:safak_sayar_withdb/models/info.dart';
import 'package:safak_sayar_withdb/screens/update_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [const Locale('tr', 'TR')],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Info info;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => BuildMainScreen(),
        "hesaplama": (context) => CalculateScreen(),
        "guncelle": (context) => UpdateScreen(info)
      },
    );
  }
}

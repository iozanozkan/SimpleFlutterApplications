import 'package:flutter/material.dart';
import 'package:safak_sayar_withdb/data/dbHelper.dart';
import 'dart:async';
import 'package:safak_sayar_withdb/models/info.dart';

class CalculateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalculateScreenState();
  }
}

class CalculateScreenState extends State {
  var dbHelper = DbHelper();
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate, terhisTarihi;
  DateTime _date = DateTime.now();
  int donem = 1, gecenGunSayisi, kalanGunSayisi;
  String izinSayisi;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text("Terhis Tarihi Hesapla"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildDateTimeField(context),
              buildTermField(),
              buildIzinSayisiField(),
              buildButtonField()
            ],
          ),
        ),
      ),
    );
  }

  buildDateTimeField(BuildContext context) {
    String metin;
    if (selectedDate == null)
      metin = "Sevk Tarihinizi Giriniz";
    else
      metin = dbHelper.dateFormat(selectedDate);
    return TextFormField(
      cursorColor: Colors.green[900],
      readOnly: true,
      decoration: InputDecoration(
          labelText: metin,
          labelStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.green[900],
          ),
          hintText: metin,
          hintStyle: TextStyle(
            color: Colors.green[900],
            fontSize: 16.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green[900], width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green[900], width: 2.0),
          )),
      onTap: () {
        setState(() {
          _selectDate(context);
        });
      },
    );
  }

  buildTermField() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      height: 60,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.green[900], width: 2.0)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: donem,
            items: [
              DropdownMenuItem(
                child: Text(
                  "Kısa Dönem (6 Ay/Er)",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 16.0,
                  ),
                ),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text(
                  "Uzun Dönem (12 Ay Yd.Sb./Yd.Asb.)",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 16.0,
                  ),
                ),
                value: 2,
              ),
            ],
            onChanged: (value) {
              setState(() {
                donem = value;
              });
            }),
      ),
    );
  }

  buildIzinSayisiField() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: TextFormField(
        onSaved: (newValue) => izinSayisi = newValue,
        keyboardType: TextInputType.number,
        cursorColor: Colors.green[900],
        decoration: InputDecoration(
            labelText: "Kalan İzin Sayısı (Gün)",
            labelStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.green[900],
            ),
            hintStyle: TextStyle(
              color: Colors.green[900],
              fontSize: 16.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green[900], width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green[900], width: 2.0),
            )),
      ),
    );
  }

  buildButtonField() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 100, right: 100),
      height: 50.0,
      child: RaisedButton(
          child: Text(
            "Terhis Tarihini Hesapla",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            formKey.currentState.save();
            Info info = Info(selectedDate, donem, izinSayisi);
            addToInfo(info);
          }),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Colors.green[700],
                    onPrimary: Colors.white,
                  ),
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child,
              );
            },
            context: context,
            initialDate: _date,
            firstDate: DateTime(_date.year - 1),
            lastDate: DateTime.now())
        .then((date) => selectedDate = date);

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
      });
    }
  }

  void addToInfo(Info info) async {
    await dbHelper.addToInfo(dbHelper.hesapla(info));
    Navigator.pop(context, true);
  }
}

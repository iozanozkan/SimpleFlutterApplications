import 'package:flutter/material.dart';
import 'package:safak_sayar_withdb/data/dbHelper.dart';
import 'package:safak_sayar_withdb/models/info.dart';
import 'package:safak_sayar_withdb/screens/calculate_screen.dart';
import 'package:safak_sayar_withdb/dictionary/sozler.dart';
import 'package:safak_sayar_withdb/screens/update_screen.dart';

class BuildMainScreen extends StatefulWidget {
  @override
  _BuildMainScreenState createState() => _BuildMainScreenState();
}

class _BuildMainScreenState extends State {
  var dbHelper = DbHelper();
  List<Info> infos;
  int count = 0;

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (count == 0) ? _buildMainScreen0() : _buildMainScreen(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green[800],
          icon: const Icon(Icons.calendar_today),
          label: Text("Hesapla"),
          elevation: 4.0,
          onPressed: () => goToCalculateScreen(),
        ));
  }

  _buildMainScreen0() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("images/unnamed.jpg"),
                fit: BoxFit.fill)),
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 70.0),
              child: Text(
                "TERHİS TARİHİNİZİN HESAPLANMASI İÇİN LÜTFEN HESAPLA BUTONUNA TIKLAYINIZ.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ],
        ));
  }

  _buildMainScreen() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage("images/unnamed.jpg"),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(bottom: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                child: (infos[0].kalanGunSayisi > 0)
                    ? (infos[0].kalanGunSayisi <= 81)
                        ? Text(
                            Dictionary.sozler[infos[0].kalanGunSayisi]
                                    .toUpperCase() +
                                "\n" +
                                "ŞAFAK : " +
                                infos[0].kalanGunSayisi.toString() +
                                "\n" +
                                Dictionary.sehirler[infos[0].kalanGunSayisi]
                                    .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                        : Text(
                            "ŞAFAK : " + infos[0].kalanGunSayisi.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                    : Center(
                        child: Text(
                          "HAYIRLI UĞURLU OLSUN. TERHİS OLDUN.",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      )),
            Divider(
              color: Colors.white,
            ),
            Container(
              child: Text(
                "TERHİS TARİHİ\n" +
                    dbHelper.dateFormat(this.infos[0].terhisTarihi),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Container(
              child: Text(
                "ASKERDE GEÇEN GÜN SAYISI\n" +
                    infos[0].gecenGunSayisi.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            // RaisedButton(
            //   onPressed: () {
            //     dbHelper.temizle();
            //   },
            // )
          ],
        ));

    // return ListView.builder(
    //     itemCount: count,
    //     itemBuilder: (BuildContext context, int position) {
    //       return Card(
    //         color: Colors.cyan,
    //         elevation: 2,
    //         child: ListTile(
    //           leading: CircleAvatar(
    //             backgroundColor: Colors.black12,
    //             child: Text("Pro"),
    //           ),
    //           title: Text(dbHelper.dateFormat(this.infos[position].sevkTarihi)),
    //           subtitle: Text(this.infos[position].donem.toString()),
    //           trailing: Text(this.infos[position].izinSayisi),
    //         ),
    //       );
    //     });
  }

  void getInfo() async {
    var future = dbHelper.getInfo();
    future.then((value) {
      setState(() {
        this.infos = value;
        this.count = value.length;
      });
    });
  }

  void goToCalculateScreen() async {
    bool result;
    if (count != 0) {
      result = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => UpdateScreen(this.infos[0])));
    } else {
      result = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CalculateScreen()));
    }
    if (result != null) {
      if (result) getInfo();
    }
  }
}

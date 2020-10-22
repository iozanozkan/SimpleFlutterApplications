import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:safak_sayar_withdb/models/info.dart';
import 'package:intl/intl.dart';

class DbHelper {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "safaksayar.db");
    var safakSayarDb =
        await openDatabase(dbPath, version: 1, onCreate: createDb);
    return safakSayarDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table safaksayar(id integer primary key, sevkTarihi text, terhisTarihi text, donem integer, kalanGunSayisi integer, gecenGunSayisi integer, izinSayisi text)");
  }

  Future<List<Info>> getInfo() async {
    Database db = await this.db;
    var result = await db.query("safaksayar");
    return List.generate(
        result.length, (index) => Info.fromObject(result[index]));
  }

  Future<int> addToInfo(Info item) async {
    Database db = await this.db;
    var result = await db.insert("safaksayar", item.toMap());
    return result;
  }

  Future<int> temizle() async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from safaksayar where id=1");
    return result;
  }

  Future<int> updateInfo(Info item) async {
    Database db = await this.db;
    var result = await db.update("safaksayar", item.toMap(), where: "id=1");
    return result;
  }

  Info hesapla(Info item) {
    if (item.donem == 1) {
      item.terhisTarihi = item.sevkTarihi.add(Duration(days: 184));
      item.terhisTarihi =
          item.terhisTarihi.add(Duration(days: -int.tryParse(item.izinSayisi)));
      item.kalanGunSayisi = item.terhisTarihi.difference(DateTime.now()).inDays;
      item.gecenGunSayisi = DateTime.now().difference(item.sevkTarihi).inDays;
    } else {
      item.terhisTarihi = item.sevkTarihi.add(Duration(days: 365));
      item.terhisTarihi =
          item.terhisTarihi.add(Duration(days: -int.tryParse(item.izinSayisi)));
      item.kalanGunSayisi = item.terhisTarihi.difference(DateTime.now()).inDays;
      item.gecenGunSayisi = DateTime.now().difference(item.sevkTarihi).inDays;
    }
    return item;
  }

  String dateFormat(DateTime time) {
    String _dateFormat = DateFormat("dd.MM.yyyy").format(time);
    return _dateFormat;
  }
}

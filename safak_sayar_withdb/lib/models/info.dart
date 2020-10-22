class Info {
  DateTime sevkTarihi, terhisTarihi;
  int id, donem, kalanGunSayisi, gecenGunSayisi;
  String izinSayisi;
  Info(this.sevkTarihi, this.donem, this.izinSayisi);
  //Info.without();
  //Info.withId(this.id);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["sevkTarihi"] = sevkTarihi.toString();
    map["terhisTarihi"] = terhisTarihi.toString();
    map["donem"] = donem;
    map["kalanGunSayisi"] = kalanGunSayisi;
    map["gecenGunSayisi"] = gecenGunSayisi;
    map["izinSayisi"] = izinSayisi;
    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  Info.fromObject(dynamic obj) {
    this.id = obj["id"];
    this.sevkTarihi = DateTime.parse(obj["sevkTarihi"]);
    this.terhisTarihi = DateTime.parse(obj["terhisTarihi"]);
    this.donem = obj["donem"];
    this.kalanGunSayisi = obj["kalanGunSayisi"];
    this.gecenGunSayisi = obj["gecenGunSayisi"];
    this.izinSayisi = obj["izinSayisi"];
  }
}

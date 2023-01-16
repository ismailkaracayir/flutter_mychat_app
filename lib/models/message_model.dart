import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? kimden;
  final String? kime;
  final bool? bendenMi;
  final String? mesaj;
  final String? video;
  final String? img;
  final String? konusmaSahibi;
  final Timestamp? date;

  Message(
      {this.kimden,
      this.kime,
      this.bendenMi,
      this.mesaj,
      this.video,
      this.img,
      this.date,
      this.konusmaSahibi});

  Map<String, dynamic> toMap() {
    return {
      'kimden': kimden,
      'kime': kime,
      'bendenMi': bendenMi,
      'mesaj': mesaj,
      'konusmaSahibi': konusmaSahibi,
      'date': date ?? FieldValue.serverTimestamp(),
      'img': img,
      'video': video,
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : kimden = map['kimden'],
        kime = map['kime'],
        bendenMi = map['bendenMi'],
        mesaj = map['mesaj'],
        video = map['video'],
        img = map['img'],
        konusmaSahibi = map['konusmaSahibi'],
        date = map['date'];

  @override
  String toString() {
    return 'Mesaj{kimden: $kimden, kime: $kime, bendenMi: $bendenMi, mesaj: $mesaj, date: $date}';
  }
}

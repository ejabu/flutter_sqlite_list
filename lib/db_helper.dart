import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = join(dir.path, 'main.db');
    final Database database =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) async {
    final String query = """ 
      CREATE TABLE product(
        id INTEGER PRIMARY KEY,
        name TEXT,
        qty INTEGER
      )
      """;

    await db.execute(query);
  }

  // Future<int> saveAyat(Ayat ayat) async {
  //   var dbClient = await db;
  //   int ayatId = await dbClient.transaction((txn) async {
  //     return await txn.rawInsert(
  //         """INSERT INTO daftar_ayat(main_index, surah_index, verse_index, bahasa, uthmanic, arabic_tashkel, arabic, progress, baris, baris_in_surah, page)
  //             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  //           """,
  //         [
  //           ayat.mainIndex,
  //           ayat.surahIndex,
  //           ayat.verseIndex,
  //           ayat.bahasa,
  //           ayat.uthmanic,
  //           ayat.arabicTashkeel,
  //           ayat.arabic,
  //           ayat.progress,
  //           ayat.baris,
  //           ayat.baris_in_surah,
  //           ayat.page,
  //         ]);
  //   });
  //   return ayatId;
  // }

  // Future<Surah> getSurahDetail({int surahIndex}) async {
  //   var dbClient = await db;
  //   var queryString = 'SELECT * FROM daftar_surah WHERE surah_index = $surahIndex';

  //   List<Map> list = await dbClient.rawQuery(queryString);
  //   var i = 0;
  //   Surah surah = Surah(
  //         id: list[i]["id"] as int,
  //         surah_index: list[i]["surah_index"] as int,
  //         surah_name: list[i]["surah_name"] as String,
  //         surah_arabic: list[i]["surah_arabic"] as String,
  //         surah_bahasa: list[i]["surah_bahasa"] as String,
  //         surah_jumlah_ayat: list[i]["surah_jumlah_ayat"] as int,
  //   );
  //   return surah;
  // }
  // Future<List<Surah>> getAllSurah({String pattern='', int limit=0}) async {
  //   var dbClient = await db;
  //   var queryString = 'SELECT * FROM daftar_surah LIMIT $limit';
  //   if (pattern.isNotEmpty){
  //     queryString = '''
  //                     SELECT *
  //                     FROM daftar_surah
  //                     WHERE (
  //                       surah_name LIKE \'%$pattern%\'
  //                       OR
  //                       surah_index LIKE \'%$pattern%\'
  //                     )
  //                     LIMIT $limit
  //                     ''';
  //   }
  //   List<Map> list = await dbClient.rawQuery(queryString);

  //   List<Surah> surah = List();
  //   for (int i = 0; i < list.length; i++) {
  //     surah.add(
  //       Surah(
  //         id: list[i]["id"] as int,
  //         surah_index: list[i]["surah_index"] as int,
  //         surah_name: list[i]["surah_name"] as String,
  //         surah_arabic: list[i]["surah_arabic"] as String,
  //         surah_bahasa: list[i]["surah_bahasa"] as String,
  //         surah_jumlah_ayat: list[i]["surah_jumlah_ayat"] as int,
  //       ),
  //     );
  //   }

  //   return surah;
  // }

  // Future<List<Ayat>> getAyat(int surahIndex) async {
  //   var dbClient = await db;
  //   List<Map> list = await dbClient.rawQuery('SELECT * FROM daftar_ayat WHERE surah_index = $surahIndex');

  //   List<Ayat> customer = List();
  //   for (int i = 0; i < list.length; i++) {
  //     customer.add(
  //       Ayat(
  //         id: list[i]["id"] as int,
  //         mainIndex: list[i]["main_index"] as int,
  //         surahIndex: list[i]["surah_index"] as int,
  //         verseIndex: list[i]["verse_index"] as int,
  //         bahasa: list[i]["bahasa"] as String,
  //         uthmanic: list[i]["uthmanic"] as String,
  //         arabicTashkeel: list[i]["arabic_tashkeel"] as String,
  //         arabic: list[i]["arabic"] as String,
  //         progress: list[i]["progress"] as int,
  //         baris: list[i]["baris"] as int,
  //         baris_in_surah: list[i]["baris_in_surah"] as int,
  //         page: list[i]["page"] as int,
  //       ),
  //     );
  //   }
  //   return customer;
  // }

}

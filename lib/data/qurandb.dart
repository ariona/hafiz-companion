import "dart:async";
import "dart:io";
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";
import "package:path_provider/path_provider.dart";

/*
  class QuranDatabase{
    static Database _db;

    Future<Database> get db async {
      if (_db != null)
        return _db;
      _db = await initDb();
      return _db;
    }

    initDb() async{
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path,"asset_wordbyword.db");

      await deleteDatabase(path);

      ByteData data = await rootBundle.load(join("assets","wordbyword.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);


      var theDb = await openDatabase(
        path,
        version:1,
        singleInstance: true,
      );
      return theDb;
    }

    Future getSurahs() async {
      var dbClient = await db;
      return await dbClient.rawQuery('SELECT * FROM surah_name');
    }

    Future getSurah(String id) async{
      var dbClient = await db;
      var result = await dbClient.rawQuery('SELECT * FROM quran WHERE surah_id=$id ORDER BY verse_id');

      return result.length == 0 ? null : result;
    }

    Future getAyahsRange(int surahid, int start, int end) async {
      var dbClient = await db;
      var result = await dbClient.rawQuery('SELECT * FROM quran WHERE surah_id=$surahid LIMIT ${end-start+1} OFFSET ${start-1}');
      return result.length == 0 ? null : result;
    }

    Future close() async {
      return db.close();
    }


  }
*/


  class QuranDatabase {
//    static final QuranDatabase _quranDatabase = new QuranDatabase._internal();
//
//    final String tableName = "surah_name";
//
//    Database db;
//
//    static QuranDatabase get() {
//      return _quranDatabase;
//    }

    static Database _db;

    Future<Database> get db async {
      if (_db != null)
        return _db;
      _db = await init();
      return _db;
    }

    Future init() async {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path,"asset_wordbyword.db");

      await deleteDatabase(path);

      ByteData data = await rootBundle.load(join("assets","wordbyword.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);

      var theDb = await openDatabase(
        path,
        version:1,
        singleInstance: true,
      );
      return theDb;
    }

    Future getSurahs() async {
      var dbClient = await db;
      return await dbClient.rawQuery('SELECT * FROM surah_name');
    }

    Future getSurahDetail(String id) async {
      var dbClient = await db;
      return await dbClient.rawQuery('SELECT * FROM surah_name WHERE surah_id=$id');
    }

    Future getSurah(String id) async{
      var dbClient = await db;
      var result = await dbClient.rawQuery('SELECT * FROM quran WHERE surah_id=$id ORDER BY verse_id');

      return result.length == 0 ? null : result;
    }

    Future getAyahsRange(int surahid, int start, int end) async {
      var dbClient = await db;
      var result = await dbClient.rawQuery('SELECT * FROM quran WHERE surah_id=$surahid ORDER BY verse_id LIMIT ${end-start+1} OFFSET ${start-1}');
      return result.length == 0 ? null : result;
    }

    Future close() async {
      var dbClient = await db;
      return dbClient.close();
    }

  }

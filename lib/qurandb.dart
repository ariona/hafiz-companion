import "dart:async";
import "dart:io";
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";
import "package:path_provider/path_provider.dart";

class QuranDatabase {
  static final QuranDatabase _quranDatabase = new QuranDatabase._internal();

  final String tableName = "surah_name";

  Database db;

  static QuranDatabase get() {
    return _quranDatabase;
  }

  QuranDatabase._internal();

  Future init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,"asset_wordbyword.db");

    await deleteDatabase(path);

    ByteData data = await rootBundle.load(join("assets","wordbyword.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);

    return db = await openDatabase(path, version:1);
  }

  Future getSurahs() async {
//    return await db.rawQuery('SELECT * FROM surah_name');
    return await db.query("surah_name");
  }

  Future getSurah(String id) async{
    var result = await db.rawQuery('SELECT * FROM quran WHERE surah_id=$id');
    
    return result.length == 0 ? null : result;
  }

  Future getAyahsRange(int surahid, int start, int end) async {
    var result = await db.rawQuery('SELECT * FROM quran WHERE surah_id=$surahid LIMIT ${end-start+1} OFFSET ${start-1}');
    return result.length == 0 ? null : result;
  }

  Future close() async {
    return db.close();
  }

}
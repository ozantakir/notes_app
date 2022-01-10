import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class DbHelper {
  static final String dbName ="yapilacaklar.sqlite";

  static Future<Database> reachDb() async{
    String dbRoad = join(await getDatabasesPath(),dbName);

    if(!await databaseExists(dbRoad)){
      ByteData data = await rootBundle.load("db/$dbName");

      List<int> bytes = data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);

      await File(dbRoad).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(dbRoad);
  }
}
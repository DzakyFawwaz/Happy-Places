import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AccessDatabase {
  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'places.db';
    var todoDatabase = openDatabase(path, version: 7, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Places (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT, 
        deskripsi TEXT, 
        date TEXT, 
        location TEXT,
        image TEXT

        )''');
  }
}

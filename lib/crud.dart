import 'package:belajar/access_db.dart';
import 'package:sqflite/sqflite.dart';

import 'class_penangkap.dart';

class CRUD {
  static const todoTable = 'Places';
  static const id = 'id';
  static const title = 'title';
  static const deskripsi = 'deskripsi';
  static const date = 'date';
  static const location = 'location';
  static const image = 'image';

  AccessDatabase dbHelper = new AccessDatabase();
  Future<int> insert(ClassPenangkap todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''INSERT INTO ${CRUD.todoTable}
    (
      ${CRUD.title},
      ${CRUD.deskripsi},
      ${CRUD.date},
      ${CRUD.location},
      ${CRUD.image}
      
    )
    VALUES (?,?,?,?,?)''';
    List<dynamic> params = [
      todo.title,
      todo.deskripsi,
      todo.date,
      todo.location,
      todo.image
    ];
    final result = await db.rawInsert(sql, params);
    return result;
  }

  Future<int> update(ClassPenangkap todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''UPDATE ${CRUD.todoTable}
    SET ${CRUD.title} = ?, ${CRUD.deskripsi} = ?, ${CRUD.date} = ?, ${CRUD.location} = ?, ${CRUD.image} =? 
    WHERE ${CRUD.id} = ?
    ''';
    List<dynamic> params = [
      todo.title,
      todo.deskripsi,
      todo.id,
      todo.date,
      todo.location,
      todo.image
    ];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

  Future<int> delete(ClassPenangkap todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''DELETE FROM ${CRUD.todoTable}
    WHERE ${CRUD.id} = ?
    ''';
    List<dynamic> params = [todo.id];
    final result = await db.rawDelete(sql, params);
    return result;
  }

  Future<List<ClassPenangkap>> getContactList() async {
    Database db = await dbHelper.initDb();
    final sql = '''SELECT * FROM ${CRUD.todoTable}''';
    final data = await db.rawQuery(sql);
    List<ClassPenangkap> todos = List();
    for (final node in data) {
      final todo = ClassPenangkap.fromMap(node);
      todos.add(todo);
    }
    return todos;
  }
}

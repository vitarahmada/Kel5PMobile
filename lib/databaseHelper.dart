import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

// createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE  transaksi(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        total INTEGER,
        type INTEGER,
        createdAt TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'transaksi.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String name, int total, int type, 
      String createdAt) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'total': total,
      'type': type,
      'createdAt': createdAt,
    };
    final id = await db.insert(' transaksi', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query(' transaksi', orderBy: "id");
  }

  // Read a single item by id
  // skarang tdk digunakan, untuk cadangan jika perlu
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query(' transaksi', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> totalPemasukan() async {
    final db = await SQLHelper.db();
    return db.rawQuery(
        "SELECT SUM(total) as totalPemasukan FROM  transaksi WHERE type = 1");
  }

  static Future<List<Map<String, dynamic>>> totalPengeluaran() async {
    final db = await SQLHelper.db();
    return db.rawQuery(
        "SELECT SUM(total) as totalPengeluaran FROM  transaksi WHERE type = 2");
  }

  // Update an item by id
  static Future<int> updateItem(int id, String name, int total, int type, 
      String createdAt) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'total': total,
      'type': type,
      'createdAt': createdAt,
    };

    final result =
        await db.update(' transaksi', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(" transaksi", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}

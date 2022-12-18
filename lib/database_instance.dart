import 'dart:io';
import 'transaksi_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance {
  final String databaseName = "catatan_keuangan.db";
  final int databaseVersion = 1;

  // Atribut di Model Transaksi
  final String namaTabel = 'transaksi';
  final String id = 'id';
  final String type = 'type';
  final String total = 'total';
  final String ket = 'ket';
  final String kategori = 'kategori';
  final String createdAt = 'created_at';
  final String updatedAt = 'updated_at';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, databaseName);
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $namaTabel ($id INTEGER PRIMARY KEY, $ket TEXT NULL, $kategori TEXT NULL, $type INTEGER, $total INTEGER ,$createdAt TEXT NULL, $updatedAt TEXT NULL)');
  }

  Future<List<TransaksiModel>> getAll() async {
    final data = await _database?.query(namaTabel);
    List<TransaksiModel> kosong = [];
    List<TransaksiModel> result =
        data?.map((e) => TransaksiModel.fromJson(e)).toList() ?? kosong;
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(namaTabel, row);
    return query;
  }

  Future<int> totalPemasukan() async {
    final queryMasuk = await _database?.rawQuery(
        "SELECT SUM(total) as totalPemasukan FROM $namaTabel WHERE type = 1");
    if (queryMasuk?.first['totalPemasukan'] == null) {
      return 0;
    }
    return int.parse(queryMasuk!.first['totalPemasukan'].toString());
  }

  Future<int> totalPengeluaran() async {
    final queryKeluar = await _database?.rawQuery(
        "SELECT SUM(total) as totalPengeluaran FROM $namaTabel WHERE type = 2");
    if (queryKeluar?.first['totalPengeluaran'] == null) {
      return 0;
    }
    return int.parse(queryKeluar!.first['totalPengeluaran'].toString());
  }

  Future<int> saldo() async {
    final queryMasuk = await _database?.rawQuery(
        "SELECT SUM(total) as totalPemasukan FROM $namaTabel WHERE type = 1");

    final queryKeluar = await _database?.rawQuery(
        "SELECT SUM(total) as totalPengeluaran FROM $namaTabel WHERE type = 2");

    if (queryMasuk?.first['totalPemasukan'] == null &&
        queryKeluar?.first['totalPengeluaran'] == null) {
      return 0;
    }
    if (queryMasuk?.first['totalPemasukan'] == null &&
        queryKeluar?.first['totalPengeluaran'] != null) {
      return (0 - int.parse(queryKeluar!.first['totalPengeluaran'].toString()));
    }
    if (queryMasuk?.first['totalPemasukan'] != null &&
        queryKeluar?.first['totalPengeluaran'] == null) {
      return int.parse(queryMasuk!.first['totalPemasukan'].toString());
    } else {
      return (int.parse(queryMasuk!.first['totalPemasukan'].toString()) -
          int.parse(queryKeluar!.first['totalPengeluaran'].toString()));
    }
  }

  Future<int> hapus(idTransaksi) async {
    final query = await _database!
        .delete(namaTabel, where: '$id = ?', whereArgs: [idTransaksi]);

    return query;
  }

  Future<int> update(int idTransaksi, Map<String, dynamic> row) async {
    final query = await _database!
        .update(namaTabel, row, where: '$id = ?', whereArgs: [idTransaksi]);
    return query;
  }

  Future<List<Map<String, Object?>>> getPerBulan(String bln) async {
    print(bln);
    final records = await _database?.rawQuery(
        "SELECT * FROM $namaTabel WHERE updated_at BETWEEN '$bln/1/2000' AND '$bln/31/2100'");
    if (records == null) {
      return [];
    }
    return records;
  }

  Future<int> totalPemasukanPerBulan(String bln) async {
    final queryMasuk = await _database?.rawQuery(
        "SELECT SUM(total) as totalPemasukan FROM $namaTabel WHERE type = 1 AND updated_at BETWEEN '$bln/1/2000' AND '$bln/31/2100'");
    if (queryMasuk?.first['totalPemasukan'] == null) {
      return 0;
    }
    return int.parse(queryMasuk!.first['totalPemasukan'].toString());
  }

  Future<int> totalPengeluaranPerBulan(String bln) async {
    final queryKeluar = await _database?.rawQuery(
        "SELECT SUM(total) as totalPengeluaran FROM $namaTabel WHERE type = 2 AND updated_at BETWEEN '$bln/1/2000' AND '$bln/31/2100'");
    if (queryKeluar?.first['totalPengeluaran'] == null) {
      return 0;
    }
    return int.parse(queryKeluar!.first['totalPengeluaran'].toString());
  }

  Future<int> saldoPerBulan(String bln) async {
    final queryMasuk = await _database?.rawQuery(
        "SELECT SUM(total) as totalPemasukan FROM $namaTabel WHERE type = 1 AND updated_at BETWEEN '$bln/1/2000' AND '$bln/31/2100'");

    final queryKeluar = await _database?.rawQuery(
        "SELECT SUM(total) as totalPengeluaran FROM $namaTabel WHERE type = 2 AND updated_at BETWEEN '$bln/1/2000' AND '$bln/31/2100'");

    if (queryMasuk?.first['totalPemasukan'] == null &&
        queryKeluar?.first['totalPengeluaran'] == null) {
      return 0;
    }
    if (queryMasuk?.first['totalPemasukan'] == null &&
        queryKeluar?.first['totalPengeluaran'] != null) {
      return (0 - int.parse(queryKeluar!.first['totalPengeluaran'].toString()));
    }
    if (queryMasuk?.first['totalPemasukan'] != null &&
        queryKeluar?.first['totalPengeluaran'] == null) {
      return int.parse(queryMasuk!.first['totalPemasukan'].toString());
    } else {
      return (int.parse(queryMasuk!.first['totalPemasukan'].toString()) -
          int.parse(queryKeluar!.first['totalPengeluaran'].toString()));
    }
  }
}
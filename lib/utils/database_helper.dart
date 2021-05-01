import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:traverse/models/db_record.dart';
import 'package:traverse/models/record.dart';

const String traverseTableName = 'traverse';

class Columns {
  static const id = 'id';
  static const date = 'date';
  static const firstLap = 'firstLap';
  static const secondLap = 'secondLap';
  static const thirdLap = 'thirdLap';

  Columns._();
}

class DatabaseHelper extends ChangeNotifier {
  static final _databaseName = 'traverse.db';
  static final _databaseVersion = 1;
  List<DBRecord> records = [];

  DatabaseHelper._();

  static final instance = DatabaseHelper._();
  static Database? _database;
  Future<Database> get database async {
    if (_database == null) _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Database db = await openDatabase(
      await getDatabasesPath() + '/' + _databaseName,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $traverseTableName ("
          "${Columns.id} INTEGER PRIMARY KEY, "
          "${Columns.date} INTEGER NOT NULL, "
          "${Columns.firstLap} INTEGER NOT NULL, "
          "${Columns.secondLap} INTEGER NOT NULL, "
          "${Columns.thirdLap} INTEGER NOT NULL)",
        );
      },
    );
    return db;
  }

  Future<int> insert(Record record) async {
    Database db = await database;
    final recordMap = record.toJson();
    final int id = await db.insert(traverseTableName, recordMap);
    if (id != 0) {
      DBRecord dbRecord = DBRecord.fromJson(record.toJson()..['id'] = id);
      records.add(dbRecord);
      notifyListeners();
    } else {
      print(db.isOpen);
    }
    return id;
  }

  Future<List<DBRecord>> queryAll() async {
    Database db = await database;
    List<Map<String, dynamic>> rows = await db.query(
      traverseTableName,
      columns: [
        Columns.id,
        Columns.date,
        Columns.firstLap,
        Columns.secondLap,
        Columns.thirdLap,
      ],
    );
    if (rows.isEmpty) return records = [];
    return records = rows.map((e) => DBRecord.fromJson(e)).toList();
  }

  Future<void> delete(int id) async {
    Database db = await database;
    int count = await db.delete(
      traverseTableName,
      where: '${Columns.id} = $id',
    );
    if (count > 0) {
      records.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

  static DatabaseHelper of(BuildContext context, {listen = true}) {
    return Provider.of<DatabaseHelper>(context, listen: listen);
  }
}

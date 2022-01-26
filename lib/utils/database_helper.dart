import 'package:flutter/cupertino.dart';
import 'package:itmo_climbing/models/db_record.dart';
import 'package:itmo_climbing/models/record.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/utils/value_utils.dart';

/// Name of table for storing traverse results
const String _traverseTableName = 'traverse';

enum ClassStatus {
  /// Not initialized
  notInitialized,

  /// Initialization not completed
  initializing,

  /// Initialized
  initialized,
}

class DatabaseHelper extends ChangeNotifier {
  static const _databaseName = 'climbing.db';
  final _traverseStore = intMapStoreFactory.store(_traverseTableName);

  /// List of travers results
  List<DBRecord> records = [];

  DatabaseHelper._();

  static final instance = DatabaseHelper._();
  static late Database _database;

  static ClassStatus get status => _status;
  static ClassStatus _status = ClassStatus.notInitialized;
  Future<ClassStatus>? initializationFuture;
  static late String appDataDirectory;

  Future<Database> get database async {
    if (status == ClassStatus.notInitialized) {
      _status = ClassStatus.initializing;
      initializationFuture = init();
      await initializationFuture!;
    } else if (status == ClassStatus.initializing) {
      await initializationFuture!;
    }
    return _database;
  }

  Future<ClassStatus> init() async {
    appDataDirectory = (await getApplicationDocumentsDirectory()).path;
    final databaseFactory = databaseFactoryIo;
    _database = await databaseFactory
        .openDatabase(p.join(appDataDirectory, _databaseName));
    _status = ClassStatus.initialized;
    notifyListeners();
    return _status;
  }

  Future<DBRecord> insert(Record record) async {
    final db = await database;
    final id = await _traverseStore.add(db, record.toJson());
    final dbRecord = DBRecord.fromJson(record.toJson()..['id'] = id);
    records.add(dbRecord);
    notifyListeners();
    return dbRecord;
  }

  Future<List<DBRecord>> queryAll() async {
    final db = await database;
    List<RecordSnapshot<int, Map<String, dynamic>>> rows =
        await _traverseStore.find(db);
    if (rows.isEmpty) return records = [];
    return records = rows.map((e) {
      Map<String, dynamic> recordJson = cloneMap(e.value);
      recordJson['id'] = e.key;
      return DBRecord.fromJson(recordJson);
    }).toList();
  }

  Future<void> delete(int id) async {
    final db = await database;
    final count = await _traverseStore.delete(
      db,
      finder: Finder(filter: Filter.custom((record) => record.key == id)),
    );
    if (count > 0) {
      records.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

  static DatabaseHelper of(BuildContext context, {bool listen = true}) {
    return Provider.of<DatabaseHelper>(context, listen: listen);
  }
}

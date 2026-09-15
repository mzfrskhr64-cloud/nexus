import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      'nexus.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        // سننشئ الجداول في الخطوة القادمة.
      },
    );
  }
}
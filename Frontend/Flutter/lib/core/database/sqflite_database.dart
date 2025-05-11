// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../tables/persons_table.dart';

class SqfliteDatabase {
  // Keep static for simplicity in this example, consider DI for larger apps
  static late final Database db;

  static Future<void> initialize() async {
    try {
      String path = await _getDbPath();
      db = await openDatabase(
        path,
        onCreate: _onCreate,
        version: 1,
      );
      print('Database initialized successfully at $path');
    } catch (e) {
      print('Error initializing database: $e');
      // Rethrow or handle appropriately
      rethrow;
    }
  }

  static Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    batch.execute(PersonsTable.create);
    // Add other table creations here if needed
    // batch.execute(AnotherTable.create);
    await batch.commit(noResult: true);
    print('Tables created successfully');
  }

  static Future<String> _getDbPath() async {
    String databasePath = await getDatabasesPath();
    // Use path.join for cross-platform compatibility
    return join(databasePath, 'tailor_app.db');
  }

  // Optional: Keep delete methods if needed for development/testing
  static Future<void> clearPersonTable() async {
    try {
      await db.delete(PersonsTable.personsTable);
      print('Person table cleared.');
    } catch (e) {
      print('Error clearing person table: $e');
    }
  }

  static Future<void> deleteDb() async {
    try {
      String path = await _getDbPath();
      await deleteDatabase(path);
      print('Database deleted.');
    } catch (e) {
      print('Error deleting database: $e');
    }
  }

  // Removed rawQuery methods as the repository uses type-safe methods
  // If you need raw queries elsewhere, you can keep them or add them back.
}

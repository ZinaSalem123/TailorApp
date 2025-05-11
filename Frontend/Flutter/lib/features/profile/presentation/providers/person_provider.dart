//A package in flutter
import 'package:sqflite/sqflite.dart';

//Core Folders
import '../../../../core/database/sqflite_database.dart';
import '../../../../core/models/sqlite_models/person_model.dart';
import '../../../../core/tables/persons_table.dart';

class PersonRepository {
  final Database _db = SqfliteDatabase.db;

  Future<PersonModel> addPerson(PersonModel person) async {
    try {
      final Map<String, Object?> personMap = person.toMap();
      if (person.id == null) {
        personMap.remove(PersonsTable.id);
      }
      final newId = await _db.insert(
        PersonsTable.personsTable,
        personMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return PersonModel(
        id: newId,
        height: person.height,
        weight: person.weight,
        age: person.age,
      );
    } catch (e) {
      // ignore: avoid_print
      print("Error adding person: $e");
      rethrow;
    }
  }

  Future<PersonModel?> getPersonById(int id) async {
    try {
      List<Map<String, Object?>> maps = await _db.query(
        PersonsTable.personsTable,
        where: '${PersonsTable.id} = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isNotEmpty) {
        return PersonModel.fromMap(maps.first);
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error getting person by ID $id: $e");
    }
    return null;
  }

  Future<PersonModel?> getFirstPerson() async {
    try {
      List<Map<String, Object?>> maps = await _db.query(
        PersonsTable.personsTable,
        limit: 1,
      );
      if (maps.isNotEmpty) {
        return PersonModel.fromMap(maps.first);
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error getting first person: $e");
    }
    return null;
  }

  Future<int> updatePerson(PersonModel person) async {
    try {
      if (person.id == null) {
        // ignore: avoid_print
        print("Error: Cannot update person without an ID.");
        return 0;
      }
      return await _db.update(
        PersonsTable.personsTable,
        person.toMap(), //
        where: '${PersonsTable.id} = ?',
        whereArgs: [person.id],
      );
    } catch (e) {
      // ignore: avoid_print
      print("Error updating person ID ${person.id}: $e");
      return 0;
    }
  }

  Future<int> deletePerson(int id) async {
    try {
      return await _db.delete(
        PersonsTable.personsTable,
        where: '${PersonsTable.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      // ignore: avoid_print
      print("Error deleting person ID $id: $e");
      return 0;
    }
  }
}

import 'package:quicknote2/models/note.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

late Database database;

class FfiDatabase {
  static const tableName = 'notes_1';

  static Future<void> insert(Note note) async {
    final db = database;

    final insertans = await db.insert(
      tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("insert ans : $insertans");
  }

  static Future<List<Note>> getAllNotes() async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (index) {
      return Note.fromMap(maps[index]);
    });
  }

  static Future<int> update(Note note) async {
    final db = database;
    return await db
        .update(tableName, note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<void> deleteNote(String id) async {
    final db = database;

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

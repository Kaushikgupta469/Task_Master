import 'dart:math';

import 'package:uuid/uuid.dart';

Uuid uuidInstance = const Uuid();

class Note {
  Note({
    required this.title,
    required this.note,
  }) {
    id = uuidInstance.v1();
    createdTime = DateTime.now().toIso8601String();
    trashedDate = "";
    color = Random().nextInt(10);
  }

  Note.load(
      {required this.id,
      required this.title,
      required this.note,
      required this.color,
      required this.createdTime,
      required this.trashed,
      required this.trashedDate});

  String title;
  String note;
  late int color;
  late String id;
  late String createdTime;
  late String trashedDate;
  late bool trashed = false;

  Note UpdateNoteContent(String note) {
    this.note = note;
    return this;
  }

  Note UpdateNoteTitle(String title) {
    this.title = title;
    return this;
  }

  Note UpdateTrashStatus() {
    if (trashed) {
      trashedDate = "";
      return this;
    }
    trashedDate = DateTime.now().toIso8601String();
    return this;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'color': color,
      'createdTime': createdTime,
      'trashedDate': trashedDate,
      'trashed': trashed ? 1 : 0,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note.load(
        title: map['title'],
        note: map['note'],
        id: map['id'],
        createdTime: map['createdTime'],
        trashedDate: map['trashedDate'],
        color: map['color'],
        trashed: map['trashed'] == 1);
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/models/note.dart';
import 'package:quicknote2/providers/note_provider.dart';
import 'package:quicknote2/utility/hash_formatter.dart';

// ignore: must_be_immutable
class NoteEditScreen extends HookConsumerWidget {
  NoteEditScreen({super.key, required this.note});
  NoteEditScreen.createNew({super.key}) {
    isNew = true;
    note = Note(title: "", note: "");
  }
  Note? note;
  bool isNew = false;

  Widget _noteEditScreenBody(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          ref
                              .read(notesProvider.notifier)
                              .updateNote(note!.UpdateNoteTitle(value));
                        },
                        maxLines: null,
                        initialValue: note?.title ?? "",
                        style: const TextStyle(fontSize: 22),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Title",
                            hintStyle: TextStyle(fontSize: 22)),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.push_pin_outlined))
                  ],
                ),
                TextFormField(
                  // keyboardType: TextInputType.text,
                  inputFormatters: [
                    NumberedBulletFormatter(),
                    unNumberedBulletFormatter(),
                  ],
                  onChanged: (value) {
                    ref
                        .read(notesProvider.notifier)
                        .updateNote(note!.UpdateNoteContent(value));
                  },
                  initialValue: note?.note ?? "",
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Note",
                  ),
                ),
                // ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isNew && !Platform.isAndroid
        ? _noteEditScreenBody(context, ref)
        : Scaffold(
            appBar: AppBar(),
            body: _noteEditScreenBody(context, ref),
          );
  }
}

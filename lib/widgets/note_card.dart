import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/models/note.dart';
import 'package:quicknote2/providers/note_provider.dart';
import 'package:quicknote2/providers/trash_notes.dart';
import 'package:quicknote2/screens/note_edit_screen.dart';
import 'package:quicknote2/utility/colors.dart';

class NoteCard extends HookConsumerWidget {
  NoteCard({super.key, required this.note});
  Note note;

  bool amIHovering = false;
  // Offset exitFrom = Offset(0, 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hover = useState(false);
    return MouseRegion(
      onEnter: (details) => hover.value = true,
      onExit: (details) => hover.value = false,
      child: GestureDetector(
        onTap: () {
          // openDialogWithNote(context, note);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteEditScreen(
                note: note,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Card(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                      color: const Color.fromARGB(255, 176, 176, 176),
                      width: cardColors[note.color] == Colors.white ? 1 : 0)),
              color: cardColors[note.color],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          note.title.substring(0, min(100, note.title.length)),
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                    FractionallySizedBox(
                        widthFactor: 1,
                        child: Text(
                          note.note.substring(0, min(100, note.note.length)),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        )),
                  ],
                ),
              ),
            ),
            if (hover.value)
              Positioned(
                bottom: 4,
                right: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!note.trashed)
                      IconButton(
                          onPressed: () {
                            ref
                                .read(notesProvider.notifier)
                                .removeNote(note.id);
                          },
                          tooltip: "Move to trash",
                          icon: const Icon(
                            CupertinoIcons.delete,
                            size: 16,
                            color: Colors.black,
                          )),
                    if (note.trashed)
                      IconButton(
                          tooltip: "Delete Permanently",
                          onPressed: () {
                            ref
                                .read(trashProvider.notifier)
                                .deletePermanently(note);
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 18,
                            color: Color.fromARGB(255, 17, 17, 17),
                          )),
                    if (note.trashed)
                      IconButton(
                          tooltip: "Restore",
                          onPressed: () {
                            ref.read(trashProvider.notifier).restore(note);
                          },
                          icon: const Icon(
                            Icons.restore_from_trash,
                            size: 18,
                            color: Color.fromARGB(255, 17, 17, 17),
                          )),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  void openDialogWithNote(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(32)),
        content: SingleChildScrollView(
          child: IntrinsicHeight(
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.5,
              child: NoteEditScreen(note: note),
            ),
          ),
        ),
      ),
    );
  }
}

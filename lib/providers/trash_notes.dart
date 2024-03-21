import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/database/database.dart';
import 'package:quicknote2/models/note.dart';
import 'package:quicknote2/providers/note_provider.dart';

class NotesTrash extends Notifier<List<Note>> {
  @override
  build() {
    List<Note> trashNotes = [];
    refresh();
    return trashNotes;
  }

  void refresh() async {
    final trashed = await FfiDatabase.getAllNotes();
    state = [
      ...trashed.where((note) {
        if (DateTime.parse(note.trashedDate).difference(DateTime.now()).inDays >
            7) {
          FfiDatabase.deleteNote(note.id);
          return false;
        }
        return note.trashed;
      })
    ];
  }

  void addToTrash(Note newItem) {
    newItem.UpdateTrashStatus();
    newItem.trashed = true;
    FfiDatabase.update(newItem);
    state = [newItem, ...state];
    // refresh();
  }

  void restore(Note restoreItem) {
    // state = [newItem, ...state];
    restoreItem.UpdateTrashStatus();
    restoreItem.trashed = false;
    FfiDatabase.update(restoreItem);
    // ref.read(notesProvider.notifier).addNew(restoreItem);
    state = [...state.where((note) => note.id != restoreItem.id)];
    ref.read(notesProvider.notifier).state = [
      restoreItem,
      ...ref.read(notesProvider.notifier).state
    ];
    // refresh();
  }

  void deletePermanently(Note note) {
    FfiDatabase.deleteNote(note.id);
    state = [...state.where((element) => element.id != note.id)];
  }
}

final trashProvider =
    NotifierProvider<NotesTrash, List<Note>>(() => NotesTrash());

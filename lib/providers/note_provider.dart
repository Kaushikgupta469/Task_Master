import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/database/database.dart';
import 'package:quicknote2/models/note.dart';
import 'package:quicknote2/providers/trash_notes.dart';

/// Notifier for the List of notes
/// provides
/// [Filter]
/// [getAllNotes]
/// [insert]
/// [delete]
/// [update]
class NotesProvider extends Notifier<List<Note>> {
  // Example function to load notes from the database

  @override
  List<Note> build() {
    refresh();
    return [];
  }

  void refresh() async {
    final notes = await FfiDatabase.getAllNotes();
    state = [...notes.reversed.where((element) => !element.trashed)];
  }

  List<Note> filter(String query) {
    if (query == "") {
      return state;
    }
    List<Note> filtered = [
      ...state.where((note) =>
          note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.note.toLowerCase().contains(query.toLowerCase()))
    ];
    return filtered;
  }

  void addNew(Note newNote) {
    FfiDatabase.insert(newNote);
    state = [newNote, ...state];
    refresh();
  }

  void updateNote(Note updatedNote) {
    bool found = false;
    state = [
      ...state.map((note) {
        if (note.id == updatedNote.id) {
          found = true;
          FfiDatabase.update(updatedNote);
          return updatedNote;
        }
        return note;
      })
    ];
    if (!found) {
      addNew(updatedNote);
    }
  }

  void removeNote(String id) {
    ref
        .read(trashProvider.notifier)
        .addToTrash(state.firstWhere((note) => note.id == id));
    // FfiDatabase.deleteNote(id);

    state = [...state.where((note) => note.id != id)];
    // refresh(); 
  }
}

///NotesProvider
/// NotfierProvider based on the todoNotifier
final notesProvider = NotifierProvider<NotesProvider, List<Note>>(() {
  return NotesProvider();
});

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/algorithms/lcs.dart';
import 'package:quicknote2/models/note.dart';
import 'package:quicknote2/providers/note_provider.dart';
import 'package:quicknote2/providers/search_query_provider.dart';

/// Filtered Notes Notifier
///
class FilteredNotes extends Notifier<List<Note>> {
  @override
  List<Note> build() {
    List<Note> completeList = ref.watch(notesProvider);
    String query = ref.watch(searchQueryProvider);
    if (query.isEmpty) {
      return completeList;
    }

    List<Note> filtered = [
      ...completeList.where((note) =>
          longestCommonSubsequence(
              query.toLowerCase(), (note.note + note.title).toLowerCase()) >=
          query.length - query.allMatches(" ").length)
    ];
    return filtered;
  }
}

/// Filtered Notes provider
/// 
final filteredNotesProvider = NotifierProvider<FilteredNotes, List<Note>>(() {
  return FilteredNotes();
});

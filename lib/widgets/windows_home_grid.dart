
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/providers/fab_context_provider.dart';
import 'package:quicknote2/providers/filtered_notes_provider.dart';
import 'package:quicknote2/providers/trash_notes.dart';
import 'package:quicknote2/utility/keys.dart';
import 'package:quicknote2/widgets/fab.dart';
import 'package:quicknote2/widgets/note_card.dart';
import 'package:visibility_detector/visibility_detector.dart';

class WindowsHomeGrid extends HookConsumerWidget {
  WindowsHomeGrid({super.key});
  WindowsHomeGrid.trashed({super.key}) {
    isTrashedScreen = true;
  }

  // late NotifierProvider<dynamic, List<Note>> provider;
  bool isTrashedScreen = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesList = isTrashedScreen
        ? ref.watch(trashProvider)
        : ref.watch(filteredNotesProvider);

    // ref.watch(fabContextProvider.notifier).state = false;
    // topFabKey.currentContext != null;
    return SingleChildScrollView(
      child: StaggeredGrid.count(
        crossAxisCount: crossCount(context),
        children: [
          VisibilityDetector(
            key: GlobalKey(),
            onVisibilityChanged: (VisibilityInfo info) {
              ref.read(fabContextProvider.notifier).state =
                  info.visibleFraction < 0.5;
            },
            child: FittedBox(
                key: topFabKey,
                child: const Padding(
                  padding: EdgeInsets.all(48.0),
                  child: FAB(),
                )),
          ),
          ...notesList.map((e) =>
              StaggeredGridTile.fit(
                  crossAxisCellCount: 1, child: NoteCard(note: e))),
        ],
      ),
    );
  }

  int crossCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) {
      return 6;
    } else if (width > 1000)
      return 5;
    else if (width > 700)
      return 3;
    else if (width > 550)
      return 2;
    else
      return 1;
  }
}

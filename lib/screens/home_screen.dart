import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/providers/fab_context_provider.dart';
import 'package:quicknote2/providers/filtered_notes_provider.dart';
import 'package:quicknote2/widgets/fab.dart';
import 'package:quicknote2/widgets/note_card.dart';
import 'package:quicknote2/widgets/search.dart';
import 'package:quicknote2/widgets/windows_home_grid.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //  FUNCTION
  //Body for the homescreen
  Widget _homeScreenBody(BuildContext context, WidgetRef ref) {
    final notesList = ref.watch(filteredNotesProvider);
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Platform.isWindows
            ? WindowsHomeGrid(
                // provider: filteredNotesProvider,
                )
            : ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  return NoteCard(note: notesList[index]);
                },
              ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          CustomSearchBar(),
          Expanded(
            child: _homeScreenBody(context, ref),
          ),
        ],
      ),
      floatingActionButton: ref.watch(fabContextProvider)
          ? const FAB()
          : const SizedBox(
              height: 0,
              width: 0,
            ),
      extendBodyBehindAppBar: true,
    );
  }
}

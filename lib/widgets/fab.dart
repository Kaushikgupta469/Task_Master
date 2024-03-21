import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:quicknote2/providers/dark_theme_provider.dart';
import 'package:quicknote2/screens/note_edit_screen.dart';

class FAB extends HookConsumerWidget {
  const FAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useHotKey(context, openDialogForNew);

    return MediaQuery.of(context).size.width > 500
        ? FloatingActionButton.large(
            backgroundColor: ref.watch(dartkThemeProvider)
                ? const Color.fromARGB(255, 255, 255, 255)
                : Colors.black,
            onPressed: () {
              Platform.isAndroid
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoteEditScreen.createNew(),
                      ),
                    )
                  : openDialogForNew(context);
            },
            child: Icon(
              Ionicons.add,
              size: 32,
              color: ref.watch(dartkThemeProvider)
                  ? Colors.black
                  : const Color.fromARGB(255, 255, 255, 255),
            ),
          )
        : FloatingActionButton(
            backgroundColor: ref.watch(dartkThemeProvider)
                ? const Color.fromARGB(255, 255, 255, 255)
                : Colors.black,
            onPressed: () {
              Platform.isAndroid
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoteEditScreen.createNew(),
                      ),
                    )
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: NoteEditScreen.createNew(),
                        ),
                      ),
                    );
            },
            child: Icon(
              Ionicons.add,
              size: 32,
              color: ref.watch(dartkThemeProvider)
                  ? Colors.black
                  : const Color.fromARGB(255, 255, 255, 255),
            ),
          );
  }

  void openDialogForNew(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(32)),
        scrollable: true,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          // height: MediaQuery.of(context).size.height * 0.1,
          child: NoteEditScreen.createNew(),
        ),
      ),
    );
  }
}

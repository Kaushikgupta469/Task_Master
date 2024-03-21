import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/providers/trash_notes.dart';
import 'package:quicknote2/widgets/windows_home_grid.dart';

class TrashScreen extends HookConsumerWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final trashProviderValue = ref.watch(trashProvider);

    return Scaffold(
      body: ref.watch(trashProvider).isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.trash,
                    size: min(
                          MediaQuery.of(context).size.height,
                          MediaQuery.of(context).size.width,
                        ) *
                        0.2,
                    color: const Color.fromARGB(255, 112, 112, 112),
                  ),
                  const Text(
                    "No Item in Trash",
                    style: TextStyle(
                      fontSize: 32,
                      color: Color.fromARGB(255, 112, 112, 112),
                    ),
                  )
                ],
              ),
            )
          : WindowsHomeGrid.trashed(
              // provider: trashProvider,
              ),
    );
  }
}

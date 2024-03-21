import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/providers/search_query_provider.dart';

class CustomSearchBar extends HookConsumerWidget {
  final searchController = useTextEditingController();

  CustomSearchBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: TextFormField(
        onChanged: (qry) {
          ref.read(searchQueryProvider.notifier).state = searchController.text;
          log("query given");
        },
        controller: searchController,
        decoration: const InputDecoration(
          icon: Icon(Icons.search),
          hintText: "search notes",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

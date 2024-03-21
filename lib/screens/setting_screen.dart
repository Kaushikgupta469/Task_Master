import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknote2/providers/dark_theme_provider.dart';

class SettingScreen extends HookConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SwitchListTile(
        title: const Text("Dark Mode"),
        value: ref.watch(dartkThemeProvider),
        onChanged: (value) {
          if (value) {
            setDarkMode();
          } else {
            removeDarkMode();
          }
          ref.read(dartkThemeProvider.notifier).state = value;
        },
      ),
    );
  }
}

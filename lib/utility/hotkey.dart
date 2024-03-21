// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:hotkey_manager/hotkey_manager.dart';
// import 'package:quicknote2/screens/note_edit_screen.dart';
// import 'package:quicknote2/widgets/fab.dart';

// void useHotKey(BuildContext context, Function shortcutCallback) {
//   // Function ?shortcutCallback;
//   useEffect(() {
//     bool shortCutActive = false;
//     // Create and register the hotkey
//     HotKey _hotKey = HotKey(
//       KeyCode.keyN,
//       modifiers: [KeyModifier.control],
//       scope: HotKeyScope.inapp,
//     );

//     hotKeyManager.register(
//       _hotKey,
//       keyDownHandler: (hotKey) {
//         if (shortCutActive) {
//           return;
//         }
//         shortCutActive = true;
//         shortcutCallback!(context);
//         shortCutActive = false;

//         print('onKeyDown+${hotKey.toJson()}');
//       },
//       keyUpHandler: (hotKey) {
//         print('onKeyUp+${hotKey.toJson()}');
//       },
//     );

//     // Unregister the hotkey on dispose
//     return () {
//       hotKeyManager.unregister(_hotKey);
//     };
//   }, []);
// }

// class GlobalShortcutInput extends HookConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return AlertDialog(
//       shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(32)),
//       scrollable: true,
//       content: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.5,
//         // height: MediaQuery.of(context).size.height * 0.1,
//         child: NoteEditScreen.createNew(),
//       ),
//     );
//   }
// }

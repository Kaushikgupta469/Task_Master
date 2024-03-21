import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quicknote2/database/database.dart';
import 'package:quicknote2/providers/dark_theme_provider.dart';
import 'package:quicknote2/screens/home_screen.dart';
import 'package:quicknote2/screens/setting_screen.dart';
import 'package:quicknote2/screens/trash_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;

Future<Database> initDatabase() async {
  sqfliteFfiInit();
  var databaseFactory = databaseFactoryFfi;
  OpenDatabaseOptions options = OpenDatabaseOptions(readOnly: false);
  // Databse _db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
  final io.Directory appDocumentsDir = await getApplicationDocumentsDirectory();

  //Create path for database
  String dbPath = p.join(appDocumentsDir.path, "databases", "myDb.db");
  final database = await databaseFactory.openDatabase(
    dbPath,
  );

  final checkTable = await database.query('sqlite_master');
  if (!checkTable.any((element) => element['name'] == 'notes_1')) {
    await database.execute('''
          CREATE TABLE notes_1 (
            id TEXT PRIMARY KEY,
            title TEXT,
            note TEXT,
            color INTEGER,
            createdTime TEXT,
            trashedDate TEXT,
            trashed INTEGER
          )
        ''');
  }
  return database;
}

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  database = await initDatabase();

  runApp(const ProviderScope(
    child: QuickNotesApp(),
  ));
}

class QuickNotesApp extends HookConsumerWidget {
  const QuickNotesApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    getDarkModeState(ref);
    final darkMode = ref.watch(dartkThemeProvider);
    return MaterialApp(
      restorationScopeId: "Test", // <-- Add this line
      debugShowCheckedModeBanner: false,
      theme: darkMode
          ? ThemeData(useMaterial3: true, brightness: Brightness.dark)
          : ThemeData(useMaterial3: true),
      home: Screen(),
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyQ, control: true):
            ButtonActivateIntent()
      },
    );
  }
}

class Screen extends HookConsumerWidget {
  Screen({
    super.key,
  });

  final List<Widget> destinatination = [
    const HomeScreen(),
    const TrashScreen(),
    const SettingScreen()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getDarkModeState(ref);
    final selectedIndex = useState(0);
    return Row(
      children: [
        NavigationRail(
          // indicatorColor: Colors.white,
          // backgroundColor: Theme.of(context).canvasColor.withBlue(),
          useIndicator: true,
          // selectedLabelTextStyle: const TextStyle(color: Colors.black),
          extended: MediaQuery.of(context).size.width > 500 ? true : false,
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.home), label: Text("Home")),
            NavigationRailDestination(
                icon: Icon(CupertinoIcons.trash), label: Text("Bin")),
            NavigationRailDestination(
                icon: Icon(Ionicons.settings_outline), label: Text("Settings")),
          ],
          selectedIndex: selectedIndex.value,
          onDestinationSelected: (value) => selectedIndex.value = value,
        ),
        const VerticalDivider(
          width: 1,
        ),
        Expanded(child: destinatination[selectedIndex.value]),
      ],
    );
  }
}

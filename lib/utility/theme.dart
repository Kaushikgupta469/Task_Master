import 'package:flutter/material.dart';

// final theme = ThemeData(
//     useMaterial3: true,
//     // colorScheme:
//     // const ColorScheme.dark(primary: Color.fromARGB(161, 215, 184, 144)),
//     // ColorScheme.fromSeed(seedColor: Colors.green),
//     textTheme: const TextTheme(),
//     appBarTheme: const AppBarTheme(
//       iconTheme: IconThemeData(color: Colors.black),
//       color: Colors.deepPurpleAccent,
//       foregroundColor: Colors.black,
//       systemOverlayStyle: SystemUiOverlayStyle(
//         //<-- SEE HERE
//         // Status bar color
//         statusBarColor: Colors.green,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.light,
//       ),
//     ));
final theme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    navigationRailTheme: const NavigationRailThemeData(
        // indicatorColor: Colors.red
        selectedLabelTextStyle: TextStyle(color: Colors.white))
    // colorScheme:
    // const ColorScheme.dark(primary: Color.fromARGB(161, 215, 184, 144)),
    // ColorScheme.fromSeed(seedColor: Colors.green),
    // textTheme: const TextTheme(),
    // appBarTheme: const AppBarTheme(
    //   iconTheme: IconThemeData(color: Colors.black),
    //   color: Colors.deepPurpleAccent,
    //   foregroundColor: Colors.black,
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     //<-- SEE HERE
    //     // Status bar color
    //     statusBarColor: Colors.green,
    //     statusBarIconBrightness: Brightness.dark,
    //     statusBarBrightness: Brightness.light,
    //   ),
    // )
    );

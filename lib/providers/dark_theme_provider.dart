import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPrefRef() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

// Obtain shared preferences.
void setDarkMode() async {
  final prefs = await getSharedPrefRef();
  await prefs.setBool('darkMode', true);
}

void removeDarkMode() async {
  final prefs = await getSharedPrefRef();
  await prefs.setBool('darkMode', false);
}

void getDarkModeState(WidgetRef ref) async {
  final prefs = await getSharedPrefRef();
  ref.read(dartkThemeProvider.notifier).state =
      prefs.getBool('darkMode') ?? false;
}

final dartkThemeProvider = StateProvider<bool>((ref) {
  return false;
});

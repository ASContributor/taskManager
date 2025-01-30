import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/provider/preference_provider.dart';
import 'package:taskmanagement/routes/generate_route.dart';
import 'package:taskmanagement/services/pref_database_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefDatabaseService().initHive();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(preferenceProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: Colors.purple[300]!,
          secondary: Colors.purple[300]!,
          surface: Colors.white,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.purple[300]!,
          secondary: Colors.purple[300]!,
          surface: const Color(0xFF1E1E1E),
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          scrimColor: Colors.transparent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        cardColor: const Color(0xFF2C2C2C),
        dialogBackgroundColor: const Color(0xFF1E1E1E),
        brightness: Brightness.dark,
        applyElevationOverlayColor: true,
      ),
      themeMode: mode.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      onGenerateRoute: Routes().onGenerateRoute,
    );
  }
}

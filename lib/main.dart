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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: mode.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      onGenerateRoute: Routes().onGenerateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskmanagement/models/preference.dart';
import 'package:taskmanagement/routes/generate_route.dart';
import 'package:taskmanagement/services/database_service.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      onGenerateRoute: Routes().onGenerateRoute,
    );
  }
}

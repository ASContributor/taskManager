import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskmanagement/models/preference.dart';

class PrefDatabaseService {
  late Box<Preference> preferencesBox;
  static const String _preferencesKey = 'preference';
  static const String _preferencesBox = 'preferencesBox';
  Future initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(sortOptionsAdapter());
    Hive.registerAdapter(PreferenceAdapter());
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox<Preference>(_preferencesBox);
  }

  Future<Preference> getPreference() async {
    preferencesBox = await Hive.openBox<Preference>(_preferencesBox);
    return preferencesBox.get(_preferencesKey) ?? Preference();
  }

  Future updateTheme(bool isDartMode) async {
    var preference = await getPreference();
    preference.isDarkMode = isDartMode;
    await preferencesBox.put(_preferencesKey, preference);
  }

  Future updateSortOption(sortOptions sortOption) async {
    var preference = await getPreference();
    preference.sortOption = sortOption;
    await preferencesBox.put(_preferencesKey, preference);
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskmanagement/models/preference.dart';

class PrefDatabaseService {
  late Box preferencesBox;
  static const String _preferencesKey = 'preference';
  Future initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PreferenceAdapter());
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    preferencesBox = await Hive.openBox<Preference>('preferencesBox');
  }

  Future getPreference() async {
    return preferencesBox.get(_preferencesKey);
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

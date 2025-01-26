import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/preference.dart';
import 'package:taskmanagement/services/pref_database_service.dart';

final prefProvider = Provider((ref) => PrefDatabaseService());

final preferenceProvider =
    StateNotifierProvider<PreferenceNotifier, Preference>((ref) {
  final prefDatabaseService = ref.watch(prefProvider);
  return PreferenceNotifier(prefDatabaseService);
});

class PreferenceNotifier extends StateNotifier<Preference> {
  final PrefDatabaseService _prefDatabaseService;
  PreferenceNotifier(this._prefDatabaseService) : super(Preference()) {
    loadPreference();
  }

  Future<void> loadPreference() async {
    state = (await _prefDatabaseService.getPreference());
  }

  void toggleTheme(bool isDarkMode) async {
    state =
        Preference(isDarkMode: !state.isDarkMode, sortOption: state.sortOption);
    await _prefDatabaseService.updateTheme(isDarkMode);
  }

  void updateTaskOrder(sortOptions option) async {
    state.sortOption = option;
    await _prefDatabaseService.updateSortOption(option);
  }
}

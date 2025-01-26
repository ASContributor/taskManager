import 'package:hive/hive.dart';

part 'preference.g.dart';

@HiveType(typeId: 1)
enum sortOptions {
  @HiveField(0)
  dateAsc,
  @HiveField(1)
  dateDesc,
  @HiveField(2)
  titleAsc,
  @HiveField(3)
  titleDesc,
}

@HiveType(typeId: 2)
class Preference extends HiveObject {
  @HiveField(0)
  sortOptions sortOption;

  @HiveField(1)
  bool isDarkMode;

  Preference({this.sortOption = sortOptions.dateAsc, this.isDarkMode = false});
}

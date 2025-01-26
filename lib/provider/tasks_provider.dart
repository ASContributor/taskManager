import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/preference.dart';
import 'package:taskmanagement/models/task.dart';
import 'package:taskmanagement/services/database_service.dart';

final databaseProvider = Provider((ref) => DatabaseService());

final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final database = ref.watch(databaseProvider);
  return TaskNotifier(database);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  final DatabaseService _databaseService;
  TaskNotifier(this._databaseService) : super([]) {
    loadTasks();
  }

  loadTasks() async {
    state = await _databaseService.getTasks();
  }

  addTask(Task task) async {
    await _databaseService.add(task);
    await loadTasks();
  }

  updateTask(Task task) async {
    await _databaseService.update(task);
    await loadTasks();
  }

  void deleteTask(int id) async {
    await _databaseService.delete(id);
    await loadTasks();
  }

  void deleteAll() async {
    await _databaseService.deleteAll();
    await loadTasks();
  }

  void sortTask(sortOptions sort) {
    final task = [...state];
    switch (sort) {
      case sortOptions.titleAsc:
        task.sort((a, b) => a.title.compareTo(b.title));
        break;
      case sortOptions.titleDesc:
        task.sort((a, b) => b.title.compareTo(a.title));
        break;
      case sortOptions.dateAsc:
        task.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case sortOptions.dateDesc:
        task.sort((a, b) => b.dueDate.compareTo(a.dueDate));
        break;
    }
    state = task;
  }
}

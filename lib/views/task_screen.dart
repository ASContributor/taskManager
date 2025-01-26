import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/task.dart';
import 'package:taskmanagement/provider/preference_provider.dart';
import 'package:taskmanagement/provider/tasks_provider.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    final prefrence = ref.watch(preferenceProvider);
    final task = ref.watch(tasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(tasksProvider.notifier).addTask(
                Task(
                  id: 0,
                  title: 'Task 1',
                  description: 'Description 1',
                  dueDate: DateTime.now(),
                  updatedAt: DateTime.now(),
                  createdAt: DateTime.now(),
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
      body: task.isEmpty
          ? const Center(
              child: Text('No Task Yet'),
            )
          : ListView.builder(
              itemCount: task.length,
              itemBuilder: (context, index) {
                final taskItem = task[index];
                return ListTile(
                  title: Text(taskItem.title),
                  subtitle: Text(taskItem.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(tasksProvider.notifier).deleteTask(taskItem.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}

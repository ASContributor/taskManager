import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanagement/models/preference.dart';
import 'package:taskmanagement/models/task.dart';
import 'package:taskmanagement/provider/preference_provider.dart';
import 'package:taskmanagement/provider/tasks_provider.dart';
import 'package:taskmanagement/views/dashbard/custom_drawer.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  ValueNotifier<bool> isGrid = ValueNotifier(false);
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    final prefrence = ref.watch(preferenceProvider);
    final task = ref.watch(tasksProvider);
    final taskNotifier = ref.read(tasksProvider.notifier);
    final prefNotifier = ref.read(preferenceProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<sortOptions>(
            icon: const Icon(Icons.sort),
            onSelected: (sortOptions value) {
              prefNotifier.updateTaskOrder(value);
              taskNotifier.sortTask(value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: sortOptions.dateAsc,
                  child: Text('Date ↑'),
                ),
                PopupMenuItem(
                  value: sortOptions.dateDesc,
                  child: Text('Date ↓'),
                ),
                PopupMenuItem(
                  value: sortOptions.titleAsc,
                  child: Text('Title ↑'),
                ),
                PopupMenuItem(
                  value: sortOptions.titleDesc,
                  child: Text('Title ↓'),
                ),
              ];
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              taskNotifier.deleteAll();
            },
          ),
          IconButton(
            icon: Icon(
              prefrence.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              prefNotifier.toggleTheme(
                !prefrence.isDarkMode,
              );
            },
          ),
        ],
        title: const Text('Task Management'),
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialogBox(context);
        },
        child: const Icon(Icons.add),
      ),
      body: task.isEmpty
          ? const Center(
              child: Text('No Task Yet'),
            )
          : SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ToggleButtons(
                          isSelected: [isGrid.value, !isGrid.value],
                          onPressed: (index) {
                            setState(() {
                              isGrid.value = index == 0;
                            });
                          },
                          children: [Icon(Icons.grid_on), Icon(Icons.list)]),
                    ],
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: isGrid,
                      builder: (context, value, child) =>
                          _BuildListOrGrid(task, value),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _BuildListOrGrid(List<Task> task, bool isGrid) {
    return isGrid
        ? GridView.builder(
            itemCount: task.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
            itemBuilder: (context, index) {
              final taskItem = task[index];
              return Card(
                child: Column(
                  children: [
                    Text(taskItem.title),
                    Text(taskItem.description),
                    Text(
                        'Due Date: ${taskItem.dueDate.day}/${taskItem.dueDate.month}/${taskItem.dueDate.year}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _titleController.text = taskItem.title;
                            _descriptionController.text = taskItem.description;
                            _selectedDate = taskItem.dueDate;
                            dialogBox(context, id: taskItem.id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            ref
                                .read(tasksProvider.notifier)
                                .deleteTask(taskItem.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: task.length,
            itemBuilder: (context, index) {
              final taskItem = task[index];
              return ListTile(
                title: Text(taskItem.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description: ${taskItem.description}"),
                    Text(
                        'Due Date: ${taskItem.dueDate.day}/${taskItem.dueDate.month}/${taskItem.dueDate.year}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _titleController.text = taskItem.title;
                        _descriptionController.text = taskItem.description;
                        _selectedDate = taskItem.dueDate;
                        dialogBox(context, id: taskItem.id);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        ref
                            .read(tasksProvider.notifier)
                            .deleteTask(taskItem.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
  }

  Future<dynamic> dialogBox(BuildContext context, {int id = 0}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Add Task'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Pick Due Date'
                    : 'Due Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    _selectedDate = date;
                    (context as Element).markNeedsBuild();
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (id != 0) {
                ref.read(tasksProvider.notifier).updateTask(
                      Task(
                        id: id,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        dueDate: _selectedDate ?? DateTime.now(),
                        updatedAt: DateTime.now(),
                        createdAt: DateTime.now(),
                      ),
                    );
              } else {
                ref.read(tasksProvider.notifier).addTask(
                      Task(
                        id: 0,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        dueDate: _selectedDate ?? DateTime.now(),
                        updatedAt: DateTime.now(),
                        createdAt: DateTime.now(),
                      ),
                    );
              }

              _titleController.clear();
              _descriptionController.clear();
              _selectedDate = null;
              Navigator.of(context).pop();
              return;
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}

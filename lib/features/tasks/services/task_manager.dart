import '../models/task.dart';
import 'task_repository.dart';

class TaskManager {
  TaskManager({
    required this._repository,
  });

  final TaskRepository _repository;

  List<Task> get tasks => _repository.getTasks();

  Future<void> loadTasks() async {
    await _repository.loadTasks();
  }

  Future<void> addTask({
    required String title,
    String? description,
    DateTime? dueDate,
  }) async {
    final task = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      dueDate: dueDate,
    );

    await _repository.addTask(task);
  }

  Future<void> toggleTask(String id) async {
    final task = tasks.firstWhere(
      (task) => task.id == id,
    );

    await _repository.updateTask(
      task.copyWith(
        isCompleted: !task.isCompleted,
      ),
    );
  }

  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
  }
}
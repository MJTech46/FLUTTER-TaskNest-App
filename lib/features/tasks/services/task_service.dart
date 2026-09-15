import 'package:shared_preferences/shared_preferences.dart';

import 'task_manager.dart';
import 'task_repository.dart';

final taskManager = TaskManager(
  repository: TaskRepository(
    preferences: SharedPreferencesAsync(),
  ),
);
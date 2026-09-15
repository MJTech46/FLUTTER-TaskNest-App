import 'package:flutter/material.dart';

import 'app/app.dart';
import 'features/tasks/services/task_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await taskManager.loadTasks();

  runApp(const TaskNestApp());
}
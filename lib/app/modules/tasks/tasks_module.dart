import 'package:provider/provider.dart';

import '../../core/auth/auth_provider.dart';
import '../../core/modules/todo_list_module.dart';
import '../../services/tasks/tasks_service.dart';
import 'task_create_controller.dart';
import 'tasks_create_page.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(
          bindings: [
            ChangeNotifierProvider<TaskCreateController>(
              create: (context) => TaskCreateController(
                tasksService: context.read<TasksService>(),
              ),
            ),
          ],
          routers: {
            '/tasks/create': (context) {
              final authProvider = Provider.of<TodoListAuthProvider>(
                context,
                listen: false,
              );
              final userId = authProvider.userId;
              if (userId == null) {
                throw Exception('User ID not available');
              }
              return TasksCreatePage(
                controller: context.read<TaskCreateController>(),
                userId: userId,
              );
            },
          },
        );
}

import '../../models/task_model.dart';
import '../../models/week_task_model.dart';

abstract interface class TasksService {
  Future<void> save(DateTime date, String description, String userId);
  Future<List<TaskModel>> getToday(String userId);
  Future<List<TaskModel>> getTomorrow(String userId);
  Future<WeekTaskModel> getWeek(String userId);
  Future<void> checkOrUncheckTask(TaskModel task);
}

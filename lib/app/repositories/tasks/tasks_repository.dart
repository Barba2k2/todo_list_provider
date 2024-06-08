import '../../models/task_model.dart';

abstract interface class TasksRepository {
  Future<void> save(DateTime date, String description, String userId);
  Future<List<TaskModel>> findByPeriod(DateTime satrt, DateTime end, String userId);
  Future<void> checkOrUncheckTask(TaskModel task);
}

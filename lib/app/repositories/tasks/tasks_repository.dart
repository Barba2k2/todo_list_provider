import '../../models/task_model.dart';

abstract interface class TasksRepository {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByPeriod(DateTime satrt, DateTime end);
}

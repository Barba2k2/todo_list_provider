import 'dart:developer';

import '../../core/database/sqlite_connection_factory.dart';
import '../../models/task_model.dart';
import './tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description, String userId) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      await conn.insert(
        'todo',
        {
          'id': null,
          'descricao': description,
          'data_hora': date.toIso8601String(),
          'finalizado': 0,
          'user_id': userId,
        },
      );
      log('Task saved: $description, $date, $userId');
    } catch (e, s) {
      log('Error on save task on Repository', error: e, stackTrace: s);
    }
  }

  @override
  Future<List<TaskModel>> findByPeriod(
    DateTime start,
    DateTime end,
    String userId,
  ) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqliteConnectionFactory.openConnection();

    final result = await conn.rawQuery(
      '''
        SELECT *
        FROM todo
        WHERE data_hora BETWEEN ? AND ?
        AND user_id = ?
        ORDER BY data_hora
      ''',
      [
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
        userId,
      ],
    );

    log('Tasks retrieved: ${result.length} tasks for user $userId between $startFilter and $endFilter');
    return result
        .map(
          (e) => TaskModel.loadFromDB(e),
        )
        .toList();
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final finished = task.finished ? 1 : 0;
    await conn.rawUpdate(
      '''
        UPDATE todo
        SET finalizado = ?
        WHERE id = ?
        AND user_id = ?
      ''',
      [
        finished,
        task.id,
        task.userId,
      ],
    );
    log('Task updated: ${task.id} - finished: $finished');
  }
}

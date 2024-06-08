class TaskModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;
  final String userId;

  TaskModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finished,
    required this.userId,
  });

  factory TaskModel.loadFromDB(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      description: task['descricao'],
      dateTime: DateTime.parse(task['data_hora']),
      finished: task['finalizado'] == 1,
      userId: task['user_id'],
    );
  }

  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    bool? finished,
    String? userId,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      finished: finished ?? this.finished,
      userId: userId ?? this.userId,
    );
  }
}

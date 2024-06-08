class TaskModel {
  final int id;
  final String descirption;
  final DateTime dateTime;
  final bool finished;

  TaskModel({
    required this.id,
    required this.descirption,
    required this.dateTime,
    required this.finished,
  });

  factory TaskModel.loadFromDB(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      descirption: task['descricao'],
      dateTime: DateTime.parse(task['data_hora']),
      finished: task['finalizado'] == 1,
    );
  }
}

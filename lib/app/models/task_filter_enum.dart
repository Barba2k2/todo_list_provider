enum TaskFilterEnum {
  today,
  tomorrow,
  week,
}

extension TaskFilterDescription on TaskFilterEnum {
  String get description {
    switch (this) {
      case TaskFilterEnum.today:
        return 'TASK\'S DE HOJE';
      case TaskFilterEnum.tomorrow:
        return 'TASK\'S DE AMANHÃ';
      case TaskFilterEnum.week:
        return 'TASK\'S DA SEMANA';
    }
  }
}

import 'dart:developer';

import '../../core/notifier/default_change_notifier.dart';
import '../../models/task_filter_enum.dart';
import '../../models/task_model.dart';
import '../../models/total_tasks_models.dart';
import '../../models/week_task_model.dart';
import '../../services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  var filterSelect = TaskFilterEnum.today;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDate;
  bool showFinishingTasks = false;
  String? userId;

  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    if (userId == null) return;

    final allTasks = await Future.wait(
      [
        _tasksService.getToday(userId!),
        _tasksService.getTomorrow(userId!),
        _tasksService.getWeek(userId!),
      ],
    );

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    );

    log('Total tasks loaded: Today: ${todayTotalTasks?.totalTasks}, Tomorrow: ${tomorrowTotalTasks?.totalTasks}, Week: ${weekTotalTasks?.totalTasks}');
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    if (userId == null) return;

    filterSelect = filter;

    showLoading();

    notifyListeners();

    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday(userId!);
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow(userId!);
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek(userId!);
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (selectedDate != null) {
        filterByDay(selectedDate!);
      } else if (initialDateOfWeek != null) {
        filterByDay(initialDateOfWeek!);
      }
    } else {
      selectedDate = null;
    }

    if (!showFinishingTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
    }

    log('Tasks found: ${filteredTasks.length} tasks for filter $filterSelect');
    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDate = date;
    filteredTasks = allTasks.where((task) => task.dateTime == date).toList();
    log('Tasks filtered by day: ${filteredTasks.length} tasks for date $date');
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelect);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();

    final taskUpdate = task.copyWith(finished: !task.finished);
    await _tasksService.checkOrUncheckTask(taskUpdate);

    hideLoading();
    refreshPage();
  }

  void showOrHideFinishingTasks() {
    showFinishingTasks = !showFinishingTasks;
    refreshPage();
  }

  void clearTasks() {
    todayTotalTasks = null;
    tomorrowTotalTasks = null;
    weekTotalTasks = null;
    allTasks = [];
    filteredTasks = [];
    initialDateOfWeek = null;
    selectedDate = null;
    log('Tasks cleared');
    notifyListeners();
  }
}

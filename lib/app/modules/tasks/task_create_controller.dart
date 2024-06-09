import 'dart:developer';

import '../../core/notifier/default_change_notifier.dart';
import '../../services/tasks/tasks_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;
  String? _userId;

  TaskCreateController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  set selectedDate(DateTime? selectDate) {
    resetState();
    _selectedDate = selectDate;
    log('Controller Selected Date: $_selectedDate');
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  set userId(String? userId) {
    _userId = userId;
  }

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null && _userId != null) {
        log('Saving Task: $description, $_selectedDate, $_userId');
        await _tasksService.save(
          _selectedDate!,
          description,
          _userId!,
        );
        log('Controller - Saved Task');
        success();
      } else {
        setError('Data da task não selecionada');
      }
    } catch (e, s) {
      log('Error on saving task', error: e, stackTrace: s);
      setError('Erro ao salvar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}

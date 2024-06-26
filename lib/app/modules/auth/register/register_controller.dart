import 'dart:developer';

import '../../../core/notifier/default_change_notifier.dart';
import '../../../exceptions/auth_exception.dart';
import '../../../services/user/user_service.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserService _userService;

  RegisterController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();

      notifyListeners();

      final user = await _userService.register(email, password);

      if (user != null) {
        //$ Success
        success();
      } else {
        //$ Error
        setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e, s) {
      setError(e.message);
      log('Error: $error\nStackTrace: $s');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}

import 'dart:developer';

import '../../../core/auth/auth_provider.dart';
import '../../../core/notifier/default_change_notifier.dart';
import '../../../exceptions/auth_exception.dart';
import '../../../services/user/user_service.dart';
import '../../home/home_controller.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  final HomeController _homeController;
  final TodoListAuthProvider _authProvider;
  String? infoMessage;

  bool _isDisposed = false;

  LoginController({
    required UserService userService,
    required HomeController homeController,
    required TodoListAuthProvider authProvider,
  })  : _userService = userService,
        _homeController = homeController,
        _authProvider = authProvider;

  bool get hasInfo => infoMessage != null;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  bool get disposed => _isDisposed;

  Future<void> login(String email, String passowrd) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.login(email, passowrd);
      log('User: $user');

      if (user != null) {
        log('User ID: ${_authProvider.userId}');
        _homeController.userId = _authProvider.userId;
        _homeController.clearTasks();
        success();
      } else {
        setError('Usuário ou senha inválidos!');
      }
    } on AuthException catch (e, s) {
      log('Error on login user', error: e, stackTrace: s);
      setError(e.message);
    } finally {
      if (!disposed) {
        hideLoading();
        notifyListeners();
      }
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();

      infoMessage = null;

      notifyListeners();

      await _userService.forgotPassword(email);

      infoMessage = 'E-mail de recuperação de senha foi enviado!';
    } on AuthException catch (e, s) {
      log('AuthException Error', error: e, stackTrace: s);

      setError(e.message);
    } catch (e, s) {
      log('Error on forgot password', error: e, stackTrace: s);

      setError('Erro ao recuperar a senha');
    } finally {
      if (!disposed) {
        hideLoading();
        notifyListeners();
      }
    }
  }

  Future<void> googleLogin() async {
    try {
      await _userService.logout();
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.googleLogin();

      log('User: $user');

      if (user != null) {
        log('User ID: ${_authProvider.userId}');
        _homeController.userId = _authProvider.userId;
        _homeController.clearTasks();
        success();
      } else {
        _userService.logout();
        setError('Erro ao realizar login com o Google');
      }
    } on AuthException catch (e, s) {
      log('Error on google login', error: e, stackTrace: s);
      _userService.logout();
      setError(e.message);
    } finally {
      if (!disposed) {
        hideLoading();
        notifyListeners();
      }
    }
  }

  Future<void> logout() async {
    await _userService.logout();
    _homeController.clearTasks();
    notifyListeners();
  }
}

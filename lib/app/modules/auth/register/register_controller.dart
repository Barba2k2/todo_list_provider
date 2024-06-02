import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../exceptions/auth_exception.dart';
import '../../../services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      error = null;
      success = false;

      notifyListeners();

      final user = await _userService.register(email, password);

      if (user != null) {
        //$ Success
        success = true;
      } else {
        //$ Error
        error = 'Erro ao registrar usuário';
      }
    } on AuthException catch (e, s) {
      error = e.message;
      log('Error: $error\nStackTrace: $s');
    } finally {
      notifyListeners();
    }
  }
}

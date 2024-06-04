import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/user/user_service.dart';
import '../navigator/todo_list_navigator.dart';

class TodoListAuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  TodoListAuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService;

  Future<void> logout() => _userService.logout();

  User? get user => _firebaseAuth.currentUser;

  void loadListener() {
    _firebaseAuth.userChanges().listen(
          (_) => notifyListeners(),
        );

    _firebaseAuth.idTokenChanges().listen(
      (user) {
        if (user != null) {
          TodoListNavigator.to.pushNamedAndRemoveUntil(
            '/home',
            (route) => false,
          );
        } else {
          TodoListNavigator.to.pushNamedAndRemoveUntil(
            '/login',
            (route) => false,
          );
        }
      },
    );
  }
}

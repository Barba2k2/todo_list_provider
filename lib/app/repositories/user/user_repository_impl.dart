// ignore_for_file: deprecated_member_use
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../exceptions/auth_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  const UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      log('Error registering user', error: e, stackTrace: s);
      if (e.code == 'email-already-in-use') {
        final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(
          email,
        );
        if (loginTypes.contains('password')) {
          throw AuthException(
            message: 'Email já utilizado, por favor escolha outro e-mail',
          );
        } else {
          throw AuthException(
            message:
                'Você já se cadastrou com esse e-mail, por favor use-o para entrar!!',
          );
        }
      } else {
        throw AuthException(
          message: e.message ?? 'Erro ao cadastar usuário',
        );
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredentials.user;
    } on PlatformException catch (e, s) {
      log('Error logging in user', error: e, stackTrace: s);
      throw AuthException(
        message: e.message ?? 'Erro ao realizar login',
      );
    } on FirebaseAuthException catch (e, s) {
      log('Error logging in user', error: e, stackTrace: s);
      throw AuthException(
        message: e.message ?? 'Erro ao realizar login',
      );
    }
  }
}

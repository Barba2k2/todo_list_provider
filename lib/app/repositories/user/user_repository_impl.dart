import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../exceptions/auth_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({
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
            message: 'Email já utilizada, por favor escolha outro e-mail',
          );
        } else {
          throw AuthException(
            message:
                'Você já se cadastrou com o Google, por favor use-o para entrar!!',
          );
        }
      } else {
        throw AuthException(
          message: e.message ?? 'Erro ao cadastar usuário',
        );
      }
    }
  }
}

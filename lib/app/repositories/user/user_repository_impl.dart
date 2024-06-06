// ignore_for_file: deprecated_member_use, body_might_complete_normally_nullable
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google.com')) {
        throw AuthException(
          message:
              'Cadastro realizado com o Google, não pode ser recuparado a senha',
        );
      } else {
        throw AuthException(
          message:
              'E-mail não cadastrado, por favor verifique o e-mail informado',
        );
      }
    } on PlatformException catch (e, s) {
      log('Error on forgot password', error: e, stackTrace: s);
      throw AuthException(
        message:
            'Erro ao enviar e-mail de recuperação de senha, por favor tente novamente',
      );
    }
  }

  @override
  Future<User?> googleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();

      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(
          googleUser.email,
        );

        if (loginMethods.contains('password')) {
          throw AuthException(
            message:
                'Você já se cadastrou com esse e-mail, por favor use-o para entrar!!',
          );
        } else {
          final googleAuth = await googleUser.authentication;

          final firebaseCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          var userCredetial = await _firebaseAuth.signInWithCredential(
            firebaseCredential,
          );

          return userCredetial.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      log('Error on google login', error: e, stackTrace: s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
          message:
              'Você já se cadastrou com o Google, por favor use-o para entrar!!',
        );
      } else {
        throw AuthException(
          message: e.message ?? 'Erro ao realizar login com o Google',
        );
      }
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}

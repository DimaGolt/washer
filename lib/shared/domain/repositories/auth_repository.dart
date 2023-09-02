import 'package:firebase_auth/firebase_auth.dart';
import 'package:washu/shared/data/app_auth_repository.dart';

abstract class AuthRepository {
  Future<User> createUserWithEmail(String email, String password, String fullName);

  Future<User> loginEmail(String email, String password);

  Future<User> loginGoogle();

  Future<void> forgotPassword(String email);

  void signOut();

  factory AuthRepository.build() => AppAuthRepository();
}

class AuthException implements Exception {
  final String message;

  AuthException({required this.message});

  @override
  String toString() {
    return message;
  }
}

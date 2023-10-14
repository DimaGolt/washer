import 'package:firebase_auth/firebase_auth.dart';
import 'package:washer/shared/domain/repositories/auth_repository.dart';
import 'package:washer/shared/utils/string_regexp.dart';

class MockAuthRepository implements AuthRepository {
  @override
  User get user => throw UnimplementedError();

  @override
  Future<User> createUserWithEmail(String email, String password, String fullName) async {
    Future.delayed(const Duration(seconds: 1));
    if (!email.matchesEmail()) {
      throw AuthException(message: 'Bad email');
    }
    if (!password.matchesPassword()) {
      throw AuthException(message: 'Bad password');
    }
    return FirebaseAuth.instance.currentUser!;
  }

  @override
  Future<User> loginEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!email.matchesEmail()) {
      throw AuthException(message: 'Bad email');
    }
    if (!password.matchesPassword()) {
      throw AuthException(message: 'Bad password');
    }
    return FirebaseAuth.instance.currentUser!;
  }

  @override
  Future<User> loginGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    return FirebaseAuth.instance.currentUser!;
    //TODO: give random user
  }

  @override
  void signOut() {
    // TODO: take user
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!email.matchesEmail()) {
      throw AuthException(message: 'Bad email');
    }
    throw AuthException(message: 'Mock email sent');
  }
}

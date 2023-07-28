import 'package:washu/shared/domain/repositories/auth_repository.dart';
import 'package:washu/shared/utils/string_regexp.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<String?> createUserWithEmail(String email, String password) async {
    Future.delayed(const Duration(seconds: 1));
    if(!email.matchesEmail()) {
      return 'Bad email';
    }
    if(!password.matchesPassword()) {
      return 'Bad password';
    }
    //TODO: give user
  }

  @override
  Future<String?> loginEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if(!email.matchesEmail()) {
      return 'Bad email';
    }
    if(!password.matchesPassword()) {
      return 'Bad password';
    }
    //TODO: give user
  }

  @override
  Future<String?> loginGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    //TODO: give random user
  }

  @override
  void signOut() {
    // TODO: take user
  }

}
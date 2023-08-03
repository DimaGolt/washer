import 'package:washu/shared/data/app_auth_repository.dart';

abstract class AuthRepository {
  Future<String?> createUserWithEmail(String email, String password);
  Future<String?> loginEmail(String email, String password);
  Future<String?> loginGoogle();
  void signOut();

  factory AuthRepository.build() => AppAuthRepository();
}
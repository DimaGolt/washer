abstract class AuthRepository {
  Future<String?> createUserWithEmail(String email, String password);
  Future<String?> loginEmail(String email, String password);
  Future<String?> loginGoogle();
  void signOut();
}
import 'package:washu/shared/data/mock/mock_auth_repository.dart';
import 'package:washu/shared/data/remote/remote_auth_repository.dart';
import 'package:washu/shared/domain/repositories/auth_repository.dart';

class AppAuthRepository implements AuthRepository {
  final _remote = RemoteAuthRepository();
  final _mock = MockAuthRepository();

  @override
  Future<String?> createUserWithEmail(String email, String password) {
    return _remote.createUserWithEmail(email, password);
  }

  @override
  Future<String?> loginEmail(String email, String password) {
    return _remote.loginEmail(email, password);
  }

  @override
  Future<String?> loginGoogle() {
    return _remote.loginGoogle();
  }

  @override
  void signOut() {
    return _remote.signOut();
  }

  @override
  Future<String?> forgotPassword(String email) {
    return _remote.forgotPassword(email);
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:washu/shared/data/remote/remote_auth_repository.dart';
import 'package:washu/shared/domain/repositories/auth_repository.dart';

class AppAuthRepository implements AuthRepository {
  User? _user;

  @override
  User? get user => _user;

  final _remote = RemoteAuthRepository();

  @override
  Future<User> createUserWithEmail(String email, String password, String fullName) async {
    _user = await _remote.createUserWithEmail(email, password, fullName);
    return user!;
  }

  @override
  Future<User> loginEmail(String email, String password) async {
    _user = await _remote.loginEmail(email, password);
    return user!;
  }

  @override
  Future<User> loginGoogle() async {
    _user = await _remote.loginGoogle();
    return user!;
  }

  @override
  void signOut() {
    return _remote.signOut();
  }

  @override
  Future<void> forgotPassword(String email) {
    return _remote.forgotPassword(email);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:washu/shared/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteAuthRepository implements AuthRepository {
  final _auth = FirebaseAuth.instance;

  @override
  User get user => throw UnimplementedError();

  @override
  Future<User> createUserWithEmail(String email, String password, String fullName) async {
    String? error;
    User user;
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(fullName);
      user = credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      } else {
        error = 'Unknown error occurred';
      }
      throw AuthException(message: error);
    } catch (e) {
      throw AuthException(message: 'Unknown error occurred');
    }
    return user;
  }

  @override
  Future<User> loginEmail(String email, String password) async {
    String? error;
    User user;
    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      user = credential.user!;
      debugPrint('Logged in with ${credential.user?.email} as ${credential.user?.displayName}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      } else {
        error = 'Unknown error occurred';
      }
      throw AuthException(message: error);
    }
    return user;
  }

  @override
  Future<User> loginGoogle() async {
    User user;
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    try {
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final credential = await _auth.signInWithCredential(googleCredential);
      user = credential.user!;
    } catch (e) {
      throw AuthException(message: 'Unknown error occurred');
    }
    return user;
  }

  @override
  void signOut() async {
    await _auth.signOut();
    debugPrint('Logged out');
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: 'Unknown error occurred');
    }
  }
}

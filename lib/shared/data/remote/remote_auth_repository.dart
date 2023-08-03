import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:washu/shared/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteAuthRepository implements AuthRepository {
  final _auth = FirebaseAuth.instance;

  @override
  Future<String?> createUserWithEmail(String email, String password) async {
    String? error;
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(credential.user?.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      } else {
        error = 'Unknown error occurred';
      }
    } catch (e) {
      error = 'Unknown error occurred';
    }
    return error;
  }

  @override
  Future<String?> loginEmail(String email, String password) async {
    String? error;
    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      debugPrint('Logged in with ${credential.user?.email}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      } else {
        error = 'Unknown error occurred';
      }
    }
    return error;
  }

  @override
  Future<String?> loginGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Once signed in, return the UserCredential
    try {
      // Create a new credential
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final credential = await _auth.signInWithCredential(googleCredential);
      debugPrint('Logged in with ${credential.user?.email} as ${credential.user?.displayName}');
    } catch (e) {
      debugPrint(e.toString());
      return 'Unknown error occurred';
    }
  }

  @override
  void signOut() async {
    await _auth.signOut();
    debugPrint('Logged out');
  }
}

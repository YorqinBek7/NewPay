import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  /// It takes an email and password, and returns a UserCredential object
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The password for the new account.
  ///
  /// Returns:
  ///   A Future<UserCredential>
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// `logIn` is an asynchronous function that takes in an email and password, and then signs the user in
  /// with Firebase
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The user's password.
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

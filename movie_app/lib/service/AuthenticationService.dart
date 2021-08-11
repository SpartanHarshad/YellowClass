import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:movie_app/model/User.dart';

class AuthenticationService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _firebaseUser(auth.User? user) {
    if (user == null) {
      return User('0', 'User Not Found');
    }
    return User(user.uid, user.email);
  }

  /// Changed to authStateChanges as it updates depending on more cases.
  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_firebaseUser);
  }

  Future<int> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 0;
    } on auth.FirebaseAuthException catch (e) {
      return 1;
    }
  }

  Future<int> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 0;
    } on auth.FirebaseAuthException catch (e) {
      return 1;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

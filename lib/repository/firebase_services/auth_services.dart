import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  Future login(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      return e;
    }
  }

  Future register(String email, String password) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      return e;
    }
  }

  void signOut() {
    auth.signOut();
  }
}

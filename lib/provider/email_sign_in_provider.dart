import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class EmailSignInProvider extends ChangeNotifier {
  String? _email;
  String? _password;

  String get email => _email!;

  String get password => _password!;

  EmailSignInProvider(this._email, this._password);

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

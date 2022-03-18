import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

/*
A class for handling Firebase Google Authentication
 */
class GoogleSignInProvider extends ChangeNotifier{
  //attributes
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  //getters
  GoogleSignInAccount get user => _user!;

  //functions
  /*
  Main Google Login Method.
  On call : Creates an authentication token using google account.
   */
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
/*
  Logout function for google authentications.
 */
  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

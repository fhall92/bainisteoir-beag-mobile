import 'package:firebase_auth/firebase_auth.dart';
import 'User.dart';

class AuthFunctions {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _user(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Allow sign in without providing email or password.
  //This will be used automatically for use with the ROTA database
  //Where names are linked to the current device via the uid
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _user(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

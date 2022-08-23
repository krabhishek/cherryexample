import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CherryCloneFirebaseUser {
  CherryCloneFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

CherryCloneFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CherryCloneFirebaseUser> cherryCloneFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<CherryCloneFirebaseUser>(
        (user) => currentUser = CherryCloneFirebaseUser(user));

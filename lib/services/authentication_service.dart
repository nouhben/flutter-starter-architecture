import 'package:chatt_squad/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CustomUser _userFromFirebaseUser(User firebaseUser) => firebaseUser == null
      ? null
      : CustomUser(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName,
          email: firebaseUser.email,
          phone: firebaseUser.phoneNumber ?? '',
        );
// On auth state change we need to logout the user
  // then map it to our costume user instead of the default firebaseUser
  Stream<CustomUser> get user => _auth
      .authStateChanges()
      .map((User firebaseUser) => _userFromFirebaseUser(firebaseUser));

  Future<CustomUser> signInAnon() async {
    try {
      final UserCredential result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      return null;
    }
  }

  Future<CustomUser> signInWithEmailAndPassword(
      {final String email, final String password}) async {
    final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebaseUser(result.user);
    try {} catch (e) {
      return null;
    }
  }

  Future<CustomUser> registerWithEmailAndPassword({
    final String email,
    final String password,
  }) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //set up the database user data by using his uid to link it with firestore
      // await DatabaseService(uid: result.user.uid).updateUserData(
      //   sugars: '0',
      //   strength: 100,
      //   name: 'Dummy name',
      // );
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}

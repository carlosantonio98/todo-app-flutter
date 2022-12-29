import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';


enum AuthStatus{
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth;
  late GoogleSignInAccount _googleUser;
  UserModel _user = UserModel();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  AuthStatus _status = AuthStatus.Uninitialized;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen((User? user) { _onAuthStateChanged(user as UserModel); });

    /* FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
    // do whatever you want based on the firebaseUser state
    }); */

    /* FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null)
        _navigatorKey.currentState!
            .pushReplacementNamed(LoginScreen.routeName);
      else
        _navigatorKey.currentState!
            .pushReplacementNamed(HomeScreen.routeName);
    }); */

  }

  Future<void> _onAuthStateChanged(UserModel? user) async {
    if (user == null) {
      _status = AuthStatus.Unauthenticated;
    } else {
      DocumentSnapshot userSnap = await _db
        .collection('users')
        .doc(user.id)
        .get();

      _user.setFromFireStore(userSnap);
      _status = AuthStatus.Authenticated;
    }

    notifyListeners();
  }

  Future<UserModel?> googleSignIn() async {
    _status = AuthStatus.Authenticating;
    notifyListeners();

    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      _googleUser = googleUser;

      final AuthCredential credential = GoogleAuthProvider
        .credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      UserModel user = authResult.user as UserModel;
      await updateUserData( user );
    } catch (e) {
      _status = AuthStatus.Uninitialized;
      notifyListeners();
      return null;
    }
  }

  Future<DocumentSnapshot> updateUserData(UserModel user) async {
    DocumentReference userRef = _db
      .collection('users')
      .doc(user.id);

    userRef.set({
      'uid': user.id,
      'email': user.email,
      'lastSign': DateTime.now(),
      'photoURL': user.photoURL,
      'displayName': user.displayName,
    }, SetOptions(merge: true));

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  void signOut() {
    _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  AuthStatus get status => _status;
  UserModel get user => _user;
  GoogleSignInAccount get googleUser => _googleUser;

}


// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/models/user_model.dart';

enum AuthStatus{
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth;
  late GoogleSignInAccount _googleUser;
  final UserModel _user = UserModel();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Set auth status to uninitialized
  AuthStatus _status = AuthStatus.Uninitialized;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>["email"]);

  AuthService() :
  _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(( user ) => _onAuthStateChanged( user ));
  }

  Future _onAuthStateChanged( user ) async {
    if ( user == null ) {
      // Set auth status to Unauthenticated
      _status = AuthStatus.Unauthenticated;
    } else {
      DocumentSnapshot userSnap = await _db
        .collection('users')
        .doc( user.uid )
        .get();

      _user.setFromFireStore( userSnap );

      // Set auth status to Authenticated
      _status = AuthStatus.Authenticated;
    }

    // Notify listeners of all changes
    notifyListeners();
  }


  Future googleSignIn() async {
    // Set auth status to Authenticating
    _status = AuthStatus.Authenticating;

    // Notify listeners of all changes
    notifyListeners();

    try {
      // Trigger the authentication flow
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      // Asigment the googleUser to _googleUser
      _googleUser = googleUser;

      // Create a new credential 
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // Once signed in, return the UserCredential. Asynchronously signs in to Firebase with the given 3rd-party credentials, returns additional identity provider data. If the user doesn't have an account already, one will be created automatically.
      UserCredential authResult = await _auth.signInWithCredential(credential);
      
      // Load the user data to our model
      UserModel user = UserModel(
        id:          authResult.user?.uid         ?? '',
        email:       authResult.user?.email       ?? '',
        photoURL:    authResult.user?.photoURL    ?? '',
        displayName: authResult.user?.displayName ?? ''
      );

      // Resturn the userData
      await updateUserData( user );
    } catch (e) {
      // Set auth status to Uninitialized
      _status = AuthStatus.Uninitialized;

      // Notify listeners of all changes
      notifyListeners();

      return null;
    }
  }




  Future updateUserData( user ) async {
    DocumentReference userRef = _db
      .collection('users')
      .doc(user.id);

    userRef.set({
      'id':          user.id,
      'email':       user.email,
      'lastSign':    DateTime.now(),
      'photoURL':    user.photoURL,
      'displayName': user.displayName,
    }, SetOptions( merge: true ));

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  signOut() {
    FirebaseAuth.instance.signOut();

    // Set auth status to Unauthenticated
    _status = AuthStatus.Unauthenticated;

    // Notify listeners of all changes
    notifyListeners();
  }

  AuthStatus get status              => _status;
  UserModel get user                 => _user;
  GoogleSignInAccount get googleUser => _googleUser;
}
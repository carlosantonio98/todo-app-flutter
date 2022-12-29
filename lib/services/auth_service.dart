import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/login_page.dart';

enum AuthStatus{
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  late FirebaseAuth _auth;
  late GoogleSignInAccount _googleUser;
  UserModel _user = UserModel();

  late FirebaseFirestore _db = FirebaseFirestore.instance;

  // Set auth status to uninitialized
  AuthStatus _status = AuthStatus.Uninitialized;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>["email"]);








  AuthService() :
  _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(( user ) => _onAuthStateChanged( user ));
  }







  Future _onAuthStateChanged( user ) async {

    // print('MI EMAIL ES: !!!!!!!!!!!!!!!!!!'+user.email+'!!!!!!!!!!!!');
    print(user);

    if ( user == null ) {
      print('!!!!!!!!!!!!!!!!!!!!!!!!!ENTRE MAL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');

      // Set auth status to Unauthenticated
      _status = AuthStatus.Unauthenticated;

    } else {
      print('!!!!!!!!!!!!!!!!!!!!!!!!!ENTRE BIEN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      DocumentSnapshot userSnap = await _db
        .collection('users')
        .doc( user.uid )
        .get();

      print(userSnap.data());

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
        id: authResult.user?.uid ?? '',
        email: authResult.user?.email ?? '',
        photoURL: authResult.user?.photoURL ?? '',
        displayName: authResult.user?.displayName ?? ''
      );

      /* print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(user.id + user.displayName + user.email);
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"); */
      
      // Resturn the userData
      await updateUserData( user );

      print('!!!!!!!!!!!!!!!!!Entre al try!!!!!!!!!!!!!!');

    } catch (e) {

      print('!!!!!!!!!!!!!!!!!Entre al catch!!!!!!!!!!!!!!!');
      print(e);

      // Set auth status to Uninitialized
      _status = AuthStatus.Uninitialized;

      // Notify listeners of all changes
      notifyListeners();

      return null;

    }
  }




  Future updateUserData( user ) async {

    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(user.id + user.displayName + user.email);
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    DocumentReference userRef = _db
      .collection('users')
      .doc(user.id);

    userRef.set({
      'id': user.id,
      'email': user.email,
      'lastSign': DateTime.now(),
      'photoURL': user.photoURL,
      'displayName': user.displayName,
    }, SetOptions(merge: true));

    print("!!!!!!!!!!!!!!!!!!!!!!!!!Update");

    DocumentSnapshot userData = await userRef.get();

    return userData;

  }



  // 2. signInWithGoogle()
  /*signInWithGoogle() async {

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential 
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }*/





  // 3. Sign out
  signOut() {
    FirebaseAuth.instance.signOut();

    // Set auth status to Unauthenticated
    _status = AuthStatus.Unauthenticated;

    // Notify listeners of all changes
    notifyListeners();
  }




  // 1. handleAuthState()
  // Determine if the user is authenticated
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }







  AuthStatus get status => _status;
  UserModel get user => _user;
  GoogleSignInAccount get googleUser => _googleUser;
}


/**
 * 
 * 
Holds fields describing a signed in user's identity, following [GoogleSignInUserData].


Initializes global sign-in configuration settings.

The [signInOption] determines the user experience. [SigninOption.games] is only supported on Android.

The list of [scopes] are OAuth scope codes to request when signing in. These scope codes will determine the level of data access that is granted to your application by the user. The full list of available scopes can be found here:

Starts the interactive sign-in process.

Returned Future resolves to an instance of [GoogleSignInAccount] for a successful sign in or null in case sign in process was aborted.

Holds authentication tokens after sign in.

Retrieve [GoogleSignInAuthentication] for this account.

[shouldRecoverAuth] sets whether to attempt to recover authentication if user action is needed. If an attempt to recover authentication fails a [PlatformException] is thrown with possible error code [kFailedToRecoverAuthError].


This class should be used to either create a new Google credential with an access code, or use the provider to trigger user authentication flows.

Asynchronously signs in to Firebase with the given 3rd-party credentials (e.g. a Facebook login Access Token, a Google ID Token/Access Token pair, etc.) and returns additional identity provider data.

 * 
 * 
 **/
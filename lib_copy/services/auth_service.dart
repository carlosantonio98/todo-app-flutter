import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/login_page.dart';

class AuthService with ChangeNotifier {

  // 2. signInWithGoogle()
  signInWithGoogle() async {
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
  }

  // 3. Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
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
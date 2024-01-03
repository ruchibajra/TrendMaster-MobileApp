import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> _handleSignIn() async {
    try {
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      // Create GoogleAuthProvider credentials
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in to Firebase with Google credentials
      return await _auth.signInWithCredential(credential);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Google Sign-In Demo"),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                UserCredential? userCredential = await _handleSignIn();
                if (userCredential != null) {
                  print("User signed in: ${userCredential.user!.displayName}");
                }
              },
              child: Text("Sign In with Google"),
            ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   // onPressed: _handleSignOut,
            //   child: Text("Sign Out"),
            // ),
          ],
        ),
      ),
    );
  }
}

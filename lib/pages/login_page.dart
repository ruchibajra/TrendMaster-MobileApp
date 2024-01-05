import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trendmasterass2/pages/company_homepage.dart';
import 'package:trendmasterass2/pages/creator_homepage.dart';
import 'package:trendmasterass2/pages/usertype_page.dart';
import '../model/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  // text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image Section
              Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 230,
                  fit: BoxFit.contain,
                ),
              ),

              // Text Fields Section
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      // Username Textfield
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Enter Email Address",
                          labelText: "Email Address",
                        ),
                      ),
                      SizedBox(height: 10),

                      // Password Textfield
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Login Button
              FractionallySizedBox(
                widthFactor: 0.85,
                child: ElevatedButton(
                  onPressed: () => onPressed(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white),
                  child: Text("Login"),
                ),
              ),
              SizedBox(height: 10),

              // Forgotten Password Section
              Container(
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PasswordResetScreen()),
                      ),
                  child: Text("Forgotten Password?",
                      style: TextStyle(color: Colors.red)),
                ),
              ),

              SizedBox(height: 20,),
              Text('-OR-'),
              
              SizedBox(height: 20,),

              Container(
                width: 320,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                ),// Adjust the radius as needed

                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.info_rounded,
                        color: Colors.teal, // Change the color to your desired color
                      ),
                      SizedBox(width: 10),
                      Text(
                        'New to TrendMaster?',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(width: 10),
                      FractionallySizedBox(
                        // widthFactor: 0.4, // Adjust the widthFactor to make it smaller
                        child: TextButton(
                          onPressed: () => onPressedSignupType(context),
                          style: TextButton.styleFrom(
                            primary: Colors.teal, // Text color
                          ),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.teal, // Change the underline color
                // Add underline for link style
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )




            ],
          )),
    );
  }

  // Login Button Function
  void onPressed(BuildContext context) {
    signInAcc(emailController.text, passwordController.text);
  }

  // login function
  void signInAcc(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        User? user = userCredential.user;

        if (user != null) {
          print('User UID: ${user.uid}'); // Add this line to check UID

          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (userSnapshot.exists) {
            String userType = userSnapshot['userType'];
            FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
            User? user = _auth.currentUser;

            if (userType == 'Company') {
              CompanyModel companyModel =
              CompanyModel.fromMap(userSnapshot.data()!);
              companyModel.updateUid(user!.uid);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        CompanyHomePage(companyModel: companyModel)),
              );
            } else if (userType == 'Creator') {
              UserModel userModel = UserModel.fromMap(userSnapshot.data()!);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        CreatorHomePage(userModel: userModel)),
              );
            } else {
              Fluttertoast.showToast(msg: 'User details not found');
            }
          }
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  // Usertype Page Call Funciton
  void onPressedSignupType(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UsertypePage()));
  }

  //Sign in with google function
  // signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser
  //       ?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   Fluttertoast.showToast(msg: 'test');
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  // // Sign in with google function
  // signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser
  //       ?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   // Navigator.push(
  //   //     context, MaterialPageRoute(builder: (context) => mainpage()));
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}

// Password Reset Screen
class PasswordResetScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onPressedPasswordReset(BuildContext context) async {
    if (emailController.text.isNotEmpty) {
      try {
        await _auth.sendPasswordResetEmail(email: emailController.text);
        Fluttertoast.showToast(msg: 'Password reset email sent');
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: 'Please enter your email address');
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Reset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter Email Address",
                labelText: "Email",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onPressedPasswordReset(context),
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}

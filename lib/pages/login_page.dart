import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trendmasterass2/pages/company_homepage.dart';
import 'package:trendmasterass2/pages/creator_homepage.dart';
import 'package:trendmasterass2/pages/usertype_page.dart';
import 'company_registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // firebase
  final _auth = FirebaseAuth.instance;

  // Function of on press buttons
  void onPressed(BuildContext context) {
    signIn(emailController.text, passwordController.text);
  }

  void onPressedSignupType(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => UsertypePage()));
  }

  void onPressedSignupCompany(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder:(context) => CompanyRegistrationScreen()));
  }

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
                        hintText: "Enter Username or Email Address",
                        labelText: "Username or Email",
                      ),
                    ),
                    SizedBox(height: 10),

                    // Password Textfield
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Button Section

            // Login Button
            FractionallySizedBox(
              widthFactor: 0.85,

              child: ElevatedButton(
                onPressed: () => onPressed(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                child: Text("Login"),
              ),
            ),
            SizedBox(height: 10),

            // Forgotten Password
            Container(
              child: TextButton(
                onPressed: () =>  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PasswordResetScreen()),
                ),
                child: Text("Forgotten Password?", style: TextStyle(color: Colors.red)),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                // color: Colors.green,
                width: 330,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text("-OR-", style: TextStyle(fontSize: 20)),
                        SizedBox(height: 20),
                        FractionallySizedBox(
                          widthFactor: 0.97,
                          child: ElevatedButton(
                            onPressed: () => onPressedSignupType(context),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                            child: Text("CREATE NEW ACCOUNT"),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.97,
                          child: ElevatedButton(
                            onPressed: () {
                              signInWithGoogle();
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                            child: Text("Sign up with Google"),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.97,
                          child: ElevatedButton(
                            onPressed: () => onPressed(context),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                            child: Text("Sign up with Facebook"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )

      ),
    );
  }

  //Sign in with Google
  signInWithGoogle() async{

    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;


    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken ,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }


  //login function
 void signIn(String email, String password) async {
   if (_formKey.currentState!.validate()) {
     try{
       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
           email: email,
           password: password);

       User? user = userCredential.user;

       if(user != null){
         DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
             .collection('users')
             .doc(user.uid)
             .get();

         if (userSnapshot.exists){
           String userType = userSnapshot['userType'];

           if(userType == 'Company'){
             Navigator.of(context).pushReplacement(
               MaterialPageRoute(builder: (context) => CompanyHomePage()),
             );
           } else if(userType == 'Creator'){
             Navigator.of(context).pushReplacement(
               MaterialPageRoute(builder: (context) => CreatorHomePage()),
             );
           }else{
             Fluttertoast.showToast(msg: 'User details not found');
           }
         }
       }
     } catch(e){
       Fluttertoast.showToast(msg: e.toString());
     }
   }
 }
}


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




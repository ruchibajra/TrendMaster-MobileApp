import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendmasterass2/pages/company_homepage.dart';
import 'package:trendmasterass2/pages/creator_registration.dart';
import 'package:trendmasterass2/pages/usertype_page.dart';
import 'company_registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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

  bool _obscurePassword = true;

  // Function of on press buttons
  void onPressed(BuildContext context) {
    signIn(emailController.text, passwordController.text);
  }

  void onPressedSignupType(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UsertypePage()),
    );
  }

  void onPressedSignupCompany(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CompanyRegistrationScreen()),
    );
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
                      // obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: Text("Login"),
              ),
            ),
            SizedBox(height: 10),

            Text(
              "Forgotten Password?",
              style: TextStyle(color: Colors.red),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                            ),
                            child: Text("CREATE NEW ACCOUNT"),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.97,
                          child: ElevatedButton(
                            onPressed: () => onPressedSignupCompany(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                            ),
                            child: Text("Sign up with Google"),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.97,
                          child: ElevatedButton(
                            onPressed: () => onPressed(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                            ),
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
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CompanyHomePage()),
        ),
      })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}

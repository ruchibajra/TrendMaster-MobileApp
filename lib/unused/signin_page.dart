// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});
//
//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }
//
// class _SignupPageState extends State<SignupPage> {
//
//   TextEditingController emailTextController = TextEditingController();
//   TextEditingController passwordTextController = TextEditingController();
//   TextEditingController phoneTextController = TextEditingController();
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool validateEmail(String value) {
//     Pattern pattern =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regex = RegExp(pattern.toString());
//     return (!regex.hasMatch(value)) ? false : true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Column(
//         children: [
//
//           const SizedBox(height: 150,),
//           // Text Fields Section
//           Container(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               child: Column(
//                 children: [
//                   // Email Textfield
//                   TextField(
//                     controller: emailTextController,
//                     decoration: InputDecoration(
//                       hintText: "Enter Email Address",
//                       labelText: "Email Address",
//                     ),
//                   ),
//                   SizedBox(height: 10),
//
//                   // Phone Textfield
//                   TextField(
//                     controller: phoneTextController,
//                     decoration: InputDecoration(
//                       hintText: "Enter Phone Number",
//                       labelText: "Phone Number ",
//                     ),
//                   ),
//                   SizedBox(height: 10),
//
//
//                   // Password Textfield
//                   TextField(
//                     obscureText: true,
//                     controller: passwordTextController,
//                     decoration: InputDecoration(
//                       hintText: "Enter Password",
//                       labelText: "Password",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // Login Button
//           FractionallySizedBox(
//             widthFactor: 0.85,
//             child: ElevatedButton(
//               onPressed: () async {
//                 if (validateEmail(emailTextController.text)) {
//                   try {
//                     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//                       email: emailTextController.text,
//                       password: passwordTextController.text,
//                     );
//                     print("User Signed Up: ${userCredential.user}");
//                   } on FirebaseAuthException catch (e) {
//                     print("Error: ${e.message}");
//                   }
//                 } else {
//                   print("Please enter a valid email address.");
//                 }
//               },
//               child: Text(
//                 "Sign in",
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.black,
//                     fontFamily: "Inika"),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
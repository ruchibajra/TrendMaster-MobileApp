import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendmasterass2/model/user_model.dart';

import 'company_homepage.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  @override
  _CompanyRegistrationScreenState createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState
    extends State<CompanyRegistrationScreen> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Widget companyInformation(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Company Information',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: companyNameController,
          decoration: InputDecoration(
            labelText: 'Company Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),

        TextFormField(
          controller: addressController,
          decoration: InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  //Online Presence
  Widget onlinePresence(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          'Company Online Presence',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // You can add a file upload field for the company logo here.
        // Example: FileUploadWidget(),
        SizedBox(height: 20),
        Text(
          'Website URL (if applicable)',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        TextFormField(
          controller: websiteController,
          decoration: InputDecoration(
            labelText: 'Website URL',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );

  }

  //Social Media Profiles
  Widget socialMediaProfile(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Social Media Profiles (if applicable)',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10), // Added spacing here
        TextFormField(
          controller: facebookController,
          decoration: InputDecoration(
            labelText: 'Company Facebook Profile',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10), // Added spacing here
        TextFormField(
          controller: twitterController,
          decoration: InputDecoration(
            labelText: 'Company Twitter Profile',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10), // Added spacing here
        TextFormField(
          controller: linkedinController,
          decoration: InputDecoration(
            labelText: 'Company LinkedIn Profile',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // Description Section
  Widget buildDescription() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Description',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Tell us about your company',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  //Signup Function
  void signUp(String email, String password) async {
    // if (_formKey.currentState!.validate)
    await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => postDetailsToFirestore());
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    CompanyModel userModel = CompanyModel(
      email: user!.email,
      uid: user.uid,
      userType: 'Company',
      name: companyNameController.text,
      address: addressController.text,
      phone: phoneController.text,
      website: websiteController.text,
      linkedin: linkedinController.text,
      facebook: facebookController.text,
      twitter: twitterController.text,
      description: descriptionController.text,
    );

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account Created Successfully!");

    Navigator.pushAndRemoveUntil(
        (context), MaterialPageRoute(builder: (context) => CompanyHomePage()), (
        route) => false);
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Influencer Registration'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
                children: <Widget>[
                  companyInformation(),
                  onlinePresence(),
                  socialMediaProfile(),
                  buildDescription(),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        signUp(emailController.text, passwordController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        minimumSize: Size(150, 50),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
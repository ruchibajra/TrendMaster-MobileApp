import 'package:flutter/material.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  @override
  _CompanyRegistrationScreenState createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState
    extends State<CompanyRegistrationScreen> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); // Added password controller
  TextEditingController websiteController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Registration'),
        // backgroundColor: Colors.red, // Change the app bar background color to red
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

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
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Phone',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Password', // Added Password Field
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(height: 20),
              Text(
                'Company Logo',
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
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement the company registration logic here.
                    // You can access the entered data using the controller.text properties.
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal, // Set button color to red
                    minimumSize: Size(150, 50), // Set button size
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
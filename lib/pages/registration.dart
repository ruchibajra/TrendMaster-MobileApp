import 'package:flutter/material.dart';
enum Gender { Male, Female }

class InfluencerRegistrationScreen extends StatefulWidget {
  @override
  _InfluencerRegistrationScreenState createState() => _InfluencerRegistrationScreenState();
}

class _InfluencerRegistrationScreenState extends State<InfluencerRegistrationScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController instagramSubscriberController = TextEditingController();
  TextEditingController youtubeSubscriberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? selectedGender;
  List<String> selectedNiches = [];

  List<Map<String, dynamic>> getNicheList() {
    return [
      {'niche': 'Fashion', 'color': Colors.teal},
      {'niche': 'Motivate', 'color': Colors.teal},
      {'niche': 'Food Vlog', 'color': Colors.teal},
      {'niche': 'Entertainment', 'color': Colors.teal},
      {'niche': 'Informative', 'color': Colors.teal},
      {'niche': 'Makeup', 'color': Colors.teal},
      {'niche': 'Content Creator', 'color': Colors.teal},
      {'niche': 'Model', 'color': Colors.teal},
      {'niche': 'Comedy', 'color': Colors.teal},
    ];
  }

  //Personal Info Section
  Widget buildPersonalInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: firstNameController,
          decoration: InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: middleNameController,
          decoration: InputDecoration(
            labelText: 'Middle Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: lastNameController,
          decoration: InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Address',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        TextFormField(
          controller: addressController,
          decoration: InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Gender',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Select Gender',
            border: OutlineInputBorder(),
          ),
          value: selectedGender,
          onChanged: (String? value) {
            setState(() {
              selectedGender = value;
            });
          },
          items: <String>['Male', 'Female'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
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
          'Password',
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
      ],
    );
  }

  //Social Media Section
  Widget buildSocialMediaProfiles() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Social Media Profiles',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextFormField(
                  controller: instagramController,
                  decoration: InputDecoration(
                    labelText: 'Instagram Handle',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: instagramSubscriberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Subscribers',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextFormField(
                  controller: youtubeController,
                  decoration: InputDecoration(
                    labelText: 'YouTube Channel (if applicable)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: youtubeSubscriberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Subscribers',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Niche Section
  Widget buildNicheSelection() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Niche/Category',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Select Niche*',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: getNicheList().map((location) {
                return OutlinedButton(
                  onPressed: () {
                    setState(() {
                      selectedNiches.contains(location['niche'])
                          ? selectedNiches.remove(location['niche'])
                          : selectedNiches.add(location['niche']);
                    });
                  },
                  child: Text(
                    location['niche'],
                    style: TextStyle(
                      color: selectedNiches.contains(location['niche']) ? Colors
                          .white : location['color'],
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: selectedNiches.contains(location['niche'])
                        ? location['color']
                        : null,
                    backgroundColor: selectedNiches.contains(location['niche'])
                        ? location['color']
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
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
            labelText: 'Tell us about yourself',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // Override Section
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Influencer Registration'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          // Add a GlobalKey<FormState> for form validation
          // key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildPersonalInformation(),
              buildSocialMediaProfiles(),
              buildNicheSelection(),
              buildDescription(),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement registration logic
                    // Validate form and save data to Firebase
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    minimumSize: Size(150, 50),
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




import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trendmasterass2/model/imageModel.dart';
import 'package:trendmasterass2/pages/company_homepage.dart';
import 'package:trendmasterass2/pages/promote_page.dart';
import '../model/user_model.dart';
import 'company_notification_page.dart';

class CompanyProfile extends StatefulWidget {
  final CompanyModel companyModel;
  CompanyProfile({Key? key, required this.companyModel}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Widget> galleryImages = List.filled(
    6,
    Image.asset('assets/images/company_h1.png', height: 80, width: 80),
  );

  String imageUrl = '';
  File? _image;
  final imagePicker = ImagePicker();
  Key _imageKey = UniqueKey();

  Future<void> imagePickerMethod() async {
    XFile? localFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (localFile != null) {
        _image = File(localFile.path);
        uploadPicture();
        Fluttertoast.showToast(msg: "Profile Picture Uploaded Successfully.");
      } else {
        Fluttertoast.showToast(msg: "No File Selected");
      }
    });
  }

  Future<String?> uploadPicture() async {
    String fileName = _image!.path.split('/').last;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(fileName);

    try {
      await referenceImageToUpload.putFile(_image!);
      imageUrl = await referenceImageToUpload.getDownloadURL();
      await Future.delayed(Duration(seconds: 1));
      postDetailsToFirestore();
    } catch (error) {
      print('Error uploading image: $error');
      return null;
    }
  }

  void postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    try {
      ImageModel imageModel = ImageModel(
        email: widget.companyModel.email,
        image: imageUrl.toString(),
      );

      await firebaseFirestore.collection("image_store").doc().set(imageModel.toMap());

      await user?.updateProfile(photoURL: imageUrl);

      if (user != null) {
        await firebaseFirestore.collection("users").doc(user.uid).update({
          'profileImage': imageUrl,
        });
      }

      setState(() {
        _imageKey = UniqueKey(); // Force refresh the image
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Navigation error: $e");
    }
  }

  Future<void> launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could not launch $url");
    }
  }

  Widget buildContactInfoWithIcon(String label, IconData icon, String? info, {bool clickable = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              icon,
              size: 20,
              color: Colors.teal,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 2),
                if (clickable)
                  GestureDetector(
                    onTap: () {
                      launchURL(info);
                    },
                    child: Text(
                      info ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  )
                else
                  Text(
                    info ?? "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSocialMediaIcon(IconData icon, String? link) {
    return GestureDetector(
      onTap: () {
        launchURL(link);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 24, color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Company Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.teal,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 5,
                        backgroundImage: _image != null
                            ? Image.file(_image!, key: _imageKey).image
                            : user?.photoURL != null
                            ? Image.network(user!.photoURL!, key: _imageKey).image
                            : AssetImage('assets/images/company_h1.png') as ImageProvider<Object>?,
                      ),
                    ),
                    Positioned(
                      bottom: -4,
                      right: -25,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: CircleBorder(),
                        ),
                        onPressed: () {
                          imagePickerMethod();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Personal Details Section
              Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 10),
                      buildContactInfoWithIcon('Name', Icons.business, widget.companyModel.name),
                      buildContactInfoWithIcon('Address', Icons.location_on, widget.companyModel.address),
                      buildContactInfoWithIcon('Email', Icons.email, widget.companyModel.email),
                      buildContactInfoWithIcon('Phone', Icons.phone, widget.companyModel.phone),
                      buildContactInfoWithIcon('Website', Icons.link, widget.companyModel.website),

                    ],
                  ),
                ),
              ),
              // Social Media Links Section
              Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Social Media Links',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        // color: Colors.grey[200],
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSocialMediaColumn('assets/images/fb_logo.png', widget.companyModel.facebook ?? ''),
                            SizedBox(width: 10,),
                            _buildSocialMediaColumn('assets/images/linkedin_logo.png', widget.companyModel.linkedin ?? ''),
                            SizedBox(width: 10,),
                            _buildSocialMediaColumn('assets/images/twitter_logo.png', widget.companyModel.twitter?? ''),
                            SizedBox(width: 10,),



                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Company Description Section
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Company Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.companyModel.description ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index != 3) {
            Navigator.of(context).pop();
            switch (index) {
              case 0:
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CompanyHomePage(companyModel: widget.companyModel)),
                );
                break;
              case 1:
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PromotionPage(companyModel: widget.companyModel)),
                );
                break;
              case 2:
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotificationPage(companyModel: widget.companyModel)),
                );
                break;
            }
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Promotion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

// Function to add social media links
  Widget _buildSocialMediaColumn(String imagePath, String mediaUrl) {
    return InkWell(
      onTap: () {
        _launchSocialMedia(mediaUrl);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 30, width: 35),
          SizedBox(height: 10),
        ],
      ),
    );
  }

// Function to launch Social Medias
  void _launchSocialMedia(String mediaUrl) async {
    try {
      await launch(
        mediaUrl,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
    } catch (e) {
      print('Error launching media url : $e');
    }
  }


}



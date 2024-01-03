import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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
  int followersCount = 10000;
  List<Widget> galleryImages = [
    Image.asset('assets/images/company_h1.png', height: 80, width: 80),
    Image.asset('assets/images/company_h1.png', height: 80, width: 80),
    Image.asset('assets/images/company_h1.png', height: 80, width: 80),
    Image.asset('assets/images/company_h1.png', height: 80, width: 80),
    Image.asset('assets/images/company_h1.png', height: 80, width: 80),
    Image.asset('assets/images/company_h1.png', height: 80, width: 80),
  ];

  String imageUrl = '';
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadUrl;

  Future imagePickerMethod() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? localFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (localFile != null) {
        _image = File(localFile.path);
        uploadPicture();
        Fluttertoast.showToast(msg: "Selected");
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
      Fluttertoast.showToast(msg: "Upload Picture Successful");
    } catch (error) {
      print('Error uploading image: $error');
      Fluttertoast.showToast(msg: "Upload Picture Function Failed");
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

      Fluttertoast.showToast(msg: "Image Uploaded Successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Navigation error: $e");
    }
  }

  void _increaseFollowers() {
    setState(() {
      followersCount += 100;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    imagePickerMethod();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider<Object>?
                        : null,
                  ),
                ),
                SizedBox(width: 17),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.business_center, size: 24, color: Colors.teal),
                          SizedBox(width: 8),
                          Text(
                            ' ${widget.companyModel.name}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: 24,
                            color: Colors.teal,
                          ),
                          SizedBox(width: 8),
                          Text(
                            ' ${widget.companyModel.address}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 24,
                            color: Colors.teal,
                          ),
                          SizedBox(width: 8),
                          Text(
                            ' ${widget.companyModel.follower}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox
                        (height: 20),
                    ],
                  ),
                ),
              ],
            ),
            Text(' ${widget.companyModel.description}'),
            SizedBox(height: 50),
            Divider(
              color: Colors.black87,
              thickness: 1,
              height: 20,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Gallery",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0,
              ),
              itemCount: galleryImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.teal,
                  child: galleryImages[index],
                );
              },
            ),
          ],
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
                  MaterialPageRoute(builder: (context) => CompanyHomePage(companyModel: widget.companyModel)), // Navigate to CompanyHomePage
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
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
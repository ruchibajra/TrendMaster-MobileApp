import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trendmasterass2/model/imageModel.dart';
import '../model/user_model.dart';

class CompanyProfile extends StatefulWidget {
  final CompanyModel companyModel;
  CompanyProfile({Key? key, required this.companyModel}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}
class _CompanyProfileState extends State<CompanyProfile> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  int followersCount = 10000; // Initial followers count
  List<Widget> galleryImages = [
    Image.asset(
      'assets/images/company_h1.png',
      height: 80,
      width: 80,
    ),
    Image.asset(
      'assets/images/company_h1.png',
      height: 80,
      width: 80,
    ),
    Image.asset(
      'assets/images/company_h1.png',
      height: 80,
      width: 80,
    ),
    Image.asset(
      'assets/images/company_h1.png',
      height: 80,
      width: 80,
    ),
    Image.asset(
      'assets/images/company_h1.png',
      height: 80,
      width: 80,
    ),
    Image.asset(
      'assets/images/company_h1.png',
      height: 80,
      width: 80,
    ),
  ];

  String imageUrl = '';

  postDetailsToFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    try {
      ImageModel imageModel = ImageModel(
        email: widget.companyModel.email,
        image: imageUrl. toString(),
      );

      await firebaseFirestore
          .collection("image_store")
          .doc()
          .set(imageModel.toMap());

      Fluttertoast.showToast(msg: "Image Uploaded Successfully.");

    } catch (e) {
      Fluttertoast.showToast(msg: "Navigation error: $e");
    }
  }

  //some initial image upload initialization code
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadUrl;

  //image picking from our device
  Future imagePickerMethod()async{
    ImagePicker imagePicker = ImagePicker();
    XFile? localFile = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${localFile?.path}');

    setState(() {
      if(localFile != null){
        _image = File(localFile.path);
        uploadPicture();
        Fluttertoast.showToast(msg: "Selected");
      }else
      {
        Fluttertoast.showToast(msg: "No File Selected");
      }
    });
  }

  Future<String?> uploadPicture() async{
    // Get the file name from the path
    String fileName = _image!.path.split('/').last;
    //Get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    // Create a reference to storage root
    Reference referenceImageToUpload = referenceDirImages.child(fileName);
    try{
      //Store the file
      await referenceImageToUpload.putFile(_image!);
      imageUrl= await referenceImageToUpload.getDownloadURL();
      // Add a small delay
      await Future.delayed(Duration(seconds: 1));
      await postDetailsToFirestore();
      Fluttertoast.showToast(msg: "Upload Picture Successful.");

    }catch(error){
      print('Error uploading image: $error');
      Fluttertoast.showToast(msg: "Upload Picture Function Failed");
      return null;
    }
  }

  void _increaseFollowers() {
    setState(() {
      followersCount += 100; // Increase followers count by 100
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white, // Set the color to white
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Company Profile"),
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo and Text Below Logo
            Row(
              children: [
                //Upload Photo Section
                GestureDetector(
                  onTap: () {
                    imagePickerMethod();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!) as ImageProvider<Object>?
                        : null, // Set to null to remove the default logo
                  ),
                ),
                SizedBox(width: 17),



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
                                fontWeight: FontWeight.bold
                            ),
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
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            // Display the uploaded image


            Text(' ${widget.companyModel.description}',
            ),
            SizedBox(height: 50),


            Divider(
              color: Colors.black87,
              thickness: 1,
              height: 20,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 20),
            // Gallery Section
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
// GridView for Images
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Set the number of columns
                crossAxisSpacing: 6.0, // Set the spacing between columns
                mainAxisSpacing: 6.0, // Set the spacing between rows
              ),
              itemCount: galleryImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.teal, // Set the background color
                  child: Image.asset(
                    'assets/images/food.png', // Replace with the actual image path
                    fit: BoxFit.cover, // Choose the appropriate fit
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, size: 30, color: Colors.grey),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30, color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 30, color: Colors.grey),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30, color: Colors.grey),
            label: 'Profile',
          ),
        ],
      ),

    );
  }
}

void main() {
  runApp(MaterialApp(
    // home: CompanyProfile(),
  ));
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trendmasterass2/model/user_model.dart';
import 'package:trendmasterass2/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/work_request_model.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:firebase_auth/firebase_auth.dart';

class CreatorHomePage extends StatefulWidget {
  final UserModel userModel;

  CreatorHomePage({Key? key, required this.userModel}) : super(key: key);

  @override
  _CreatorHomePageState createState() => _CreatorHomePageState();
}

class _CreatorHomePageState extends State<CreatorHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white), // Set the icon color to white

      ),
      body: _buildBody(),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                Container(
                  color: Colors.teal,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                SizedBox(width: 5),
                                Text( "Welcome Creator !",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),

                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${widget.userModel.firstName ?? ''} ${widget.userModel.middleName ?? ''} ${widget.userModel.lastName ?? ''}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person, size: 30, color: Colors.grey),
                        title: Text('Profile', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ProfilePage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.home, size: 30, color: Colors.grey),
                        title: Text('Home', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, size: 30, color: Colors.grey),
                        title: Text('Notification', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => NotificationPage(userModel: widget.userModel)),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout, size: 30, color: Colors.grey),
                        title: Text('Logout', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          _showLogoutPopup(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),


      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.teal,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home , color: Colors.white70,),
                onPressed: () {
                  _onTabTapped(0);
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white70,),
                onPressed: () {
                  _onTabTapped(2);
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white70,),
                onPressed: () {
                  _onTabTapped(1);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text('Yes', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHome();
      case 1:
        return ProfilePage();
      case 2:
        return NotificationPage(userModel: widget.userModel);
      default:
        return Container();
    }
  }

  Widget _buildHome() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('campaign_details').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<Map<String, dynamic>> campaignData = snapshot.data!.docs
              .map<Map<String, dynamic>>(
                  (doc) => doc.data() as Map<String, dynamic>)
              .toList();

          return PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: campaignData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CampaignDetailsPage(userModel: widget.userModel, campaignData: campaignData[index]),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: campaignData[index]['image'] as String? ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              campaignData[index]['title'] as String? ?? '',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),

                            subtitle: Text(
                              "by ${ campaignData[index]['companyName'] as String? ?? ''}",
                              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CampaignDetailsPage(userModel: widget.userModel, campaignData: campaignData[index]),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                            ),
                            child: Text("View Campaign", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}




///////////////////////////////////////////////////////////////////////////////////////////////


class CampaignDetailsPage extends StatefulWidget {
  UserModel userModel;
  final Map<String, dynamic> campaignData;
  CampaignDetailsPage({required this.userModel, required this.campaignData});

  @override
  State<CampaignDetailsPage> createState() => _CampaignDetailsPageState();
}

class _CampaignDetailsPageState extends State<CampaignDetailsPage> {
  bool _workRequestSent = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  WorkRequestModel? _fetchedWorkRequest;


  @override
  void initState() {
    super.initState();
    _fetchWorkRequestData().then((workRequestDoc) {
      _updateWorkRequestSent(workRequestDoc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaign Details"),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white), // Set the icon color to white

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.campaignData['image'] as String? ?? '',
                    fit: BoxFit.cover,

                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  widget.campaignData['title'] as String? ?? '',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              // SizedBox(height: 16.0),
              Center(
                child: Text('by ${widget.campaignData['companyName'] as String? ?? ''}', style:
                TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic

                ),),
              ),
              SizedBox(height: 16.0),


              Center(
                child: Text('Description', style:
                TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,

                ),),
              ),

              Text(
                widget.campaignData['description'] as String? ?? '',
                style: TextStyle(fontSize: 18, ),
                textAlign: TextAlign.justify,


              ),
              SizedBox(height: 8.0),

              Text(
                "Creator's Location (Preferred): ${widget.campaignData['location'] as String? ?? ''}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8.0),
              Text(
                "Area of Expertise: ${widget.campaignData['niche'] as String? ?? ''}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8.0),
              Text(
                "No. of Creators Wanted:  ${widget.campaignData['count'].toString()}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8.0),
              Text(
                "Budget: Rs.${widget.campaignData['budget'] as String? ?? ''}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 25),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (!_workRequestSent) {
                      _showConfirmationPopup(
                        context,
                        "Are you sure you want to work together? ",
                      );
                    } else {
                      // Toggle back to "Let's work together" when clicked again
                      setState(() {
                        _showCancellationPopup(
                          context,
                          "Are you sure you want to cancel your work request with ${widget.campaignData['companyName'] ?? ''}?",
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _workRequestSent
                          ? 'Work Request Sent'
                          : "Let's Work Together",
                      style: TextStyle(fontSize: 16),
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

  postDetailsToFirestore() async {

    WorkRequestModel workRequestModel = WorkRequestModel(
      senderId: widget.userModel.email,
      receiverId:widget.campaignData['userId'] as String? ?? '',
      status: 'Pending',
      fname: widget.userModel.firstName,
      mname: widget.userModel.middleName,
      lname: widget.userModel.lastName,
    );

    try {
      CollectionReference workRequestsCollection = firebaseFirestore.collection('campaign_requests');

      // Use the where clause to filter the documents based on creator and company emails
      QuerySnapshot workRequestsQuery = await workRequestsCollection
          .where('receiverId', isEqualTo: widget.campaignData['userId'] as String? ?? '')
          .where('senderId', isEqualTo:  widget.userModel.email)
          .get();

      // Check if there are any matching documents
      if (workRequestsQuery.docs.isNotEmpty) {
        DocumentSnapshot workRequestDoc = workRequestsQuery.docs.first;

        // Update the document with the new status
        await workRequestsCollection
            .doc(workRequestDoc.id)
            .update({'status': "Pending"});
      } else {
        await firebaseFirestore
            .collection("campaign_requests")
            .doc()
            .set(workRequestModel.toMap());
      }
    } catch (e) {
      print('Error updating work request status: $e');
    }
  }

  Future<DocumentSnapshot?> _fetchWorkRequestData() async {
    try {
      // Get a reference to the 'work_requests' collection
      CollectionReference workRequestsCollection = firebaseFirestore.collection('campaign_requests');

      // Use the where clause to filter the documents based on creator and company emails
      QuerySnapshot workRequestsQuery = await workRequestsCollection
          .where('receiverId', isEqualTo: widget.campaignData['userId'] as String? ?? '')
          .where('senderId', isEqualTo: widget.userModel.email )
          .get();

      // Check if there are any matching documents
      if (workRequestsQuery.docs.isNotEmpty) {
        // Assuming you only expect one document, you can access the first one
        DocumentSnapshot workRequestDoc = workRequestsQuery.docs.first;

        // Convert the document data to a WorkRequestModel object
        setState(() {
          _fetchedWorkRequest = WorkRequestModel.fromMap(workRequestDoc.data() as Map<String, dynamic>);
        });
      } else {
        print('No matching work request found');
      }
    } catch (e) {
      print('Error fetching work request data: $e');
    }
  }

  void _updateWorkRequestSent(DocumentSnapshot? workRequestDoc) {
    setState(() {
      _workRequestSent = workRequestDoc != null && workRequestDoc['status'] == 'Pending';
    });
  }

  // Function to show cancellation confirmation dialog in the center
  void _showCancellationPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  'Cancellation',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red, // Title in red color
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  message,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal, // Teal background color
                        side: BorderSide(color: Colors.red), // Red border
                      ),
                      onPressed: () {
                        // Update the status to "Cancelled" in Firestore
                        if (_workRequestSent == true) {
                          _updateWorkRequestStatus('Cancelled');
                        }

                        setState(() {
                          _workRequestSent = false;
                        });
                        Navigator.of(context).pop();
                        _showToast(
                            "Work request cancelled successfully"); // Show toast here
                      },
                      child: Text('Yes', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal, // Teal color for the "No" button
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to show confirmation dialog in the center
  void _showConfirmationPopup(BuildContext context, String message) {
    // Check if there is already a work request with the same creator and company email
    if (_workRequestSent == true) {
      Fluttertoast.showToast(msg: "Work request already sent");
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: () {
                        _updateWorkRequestStatus('Pending');

                        setState(() {
                          _workRequestSent = true;
                        });
                        postDetailsToFirestore();
                        Navigator.of(context).pop();
                        _showToast(
                            "Work request sent successfully"); // Show toast here
                      },
                      child: Text('Yes', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal, // Teal color for the "No" button
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to update the status in Firestore based on conditions
  void _updateWorkRequestStatus(String newStatus) async {
    if (_workRequestSent == true) {
      try {
        CollectionReference workRequestsCollection = firebaseFirestore.collection('campaign_requests');

        // Use the where clause to filter the documents based on creator and company emails
        QuerySnapshot workRequestsQuery = await workRequestsCollection
            .where('receiverId', isEqualTo: widget.campaignData['userId'] as String? ?? '')
            .where('senderId', isEqualTo: widget.userModel.email )
            .get();

        // Check if there are any matching documents
        if (workRequestsQuery.docs.isNotEmpty) {
          // Assuming you only expect one document, you can access the first one
          DocumentSnapshot workRequestDoc = workRequestsQuery.docs.first;

          // Update the document with the new status
          await workRequestsCollection
              .doc(workRequestDoc.id)
              .update({'status': newStatus});

          // Optional: You can also update the local state if needed
          setState(() {
            _fetchedWorkRequest = WorkRequestModel.fromMap(workRequestDoc.data() as Map<String, dynamic>);
          });
        } else {
          print('No matching work request found');
        }
      } catch (e) {
        print('Error updating work request status: $e');
      }
    }
  }

  // Function to show FlutterToast
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.teal,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}



/////////////////////////////////////////////////////////////////////////////////////



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  File? _image;
  String imageUrl = '';
  final imagePicker = ImagePicker();
  Key _imageKey = UniqueKey();

  Future<void> imagePickerMethod() async {
    XFile? localFile =
    await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (localFile != null) {
        _image = File(localFile.path);
        uploadPicture();
        // You can add your own UI feedback here
      } else {
        // You can add your own UI feedback here
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal, // Teal theme
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display Profile Picture
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user?.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final userData =
                    snapshot.data!.data() as Map<String, dynamic>;
                    String profileImageUrl =
                        userData['profileImage'] as String? ?? '';

                    // Display the profile picture or a default image
                    Widget profileImageWidget = profileImageUrl.isEmpty
                        ? Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.grey,
                    )
                        : CircleAvatar(
                      radius: 50,
                      key: _imageKey,
                      backgroundImage: NetworkImage(profileImageUrl),
                    );

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Profile Picture
                        GestureDetector(
                          onTap: () {
                            imagePickerMethod();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                // width: 140,
                                // height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.teal, // Teal border color
                                    width: 5.0,
                                  ),
                                ),
                                child: profileImageWidget,
                              ),
                              Positioned(
                                bottom: 5,
                                right: -15,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black, // Black button color
                                    shape: CircleBorder(),
                                  ),
                                  onPressed: () {
                                    imagePickerMethod();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
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

                        // Full Namea
                        Text(
                          '${userData['firstName'] ?? ''}${userData['middleName']?? '' } ${userData['lastName'] ?? ''}',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal), // Teal color
                        ),

                        SizedBox(height: 10),

                        // Email
                        Text(user?.email ?? '',
                            style: TextStyle(
                                fontSize: 16, color: Colors.black87)),

                        SizedBox(height: 10),

                        // Phone
                        Text(userData['phone'] ?? '',
                            style: TextStyle(
                                fontSize: 16, color: Colors.black87)),

                        SizedBox(height: 10),

                        // Address
                        Text(userData['address'] ?? '',
                            style: TextStyle(
                                fontSize: 16, color: Colors.black87)),

                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialMediaColumn('assets/images/fb_logo.png', userData['facebook'] as String? ?? ''),
                            SizedBox(width: 10,),

                            _buildSocialMediaColumn('assets/images/insta_logo.png', userData['instagram'] as String? ?? ''),
                            SizedBox(width: 10,),

                            _buildSocialMediaColumn('assets/images/youtube_logo.png', userData['youtube'] as String? ?? ''),
                            SizedBox(width: 10,),


                          ],
                        ),

                        ElevatedButton(
                          onPressed: () {
                            // Add the functionality to update the profile here
                            // You can call a function or navigate to another screen for updating

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UpdateCreator()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal, // Set the button color to tealish
                          ),
                          child: Text(
                            'Update Profile',
                            style: TextStyle(color: Colors.white), // Set the text color to white
                          ),
                        ),// SizedBox(height: 10),

                        // Description
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.teal, // Teal border color
                              // width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.grey.shade100, // Light grey background
                          ),
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About Me:',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal), // Teal color
                              ),
                              SizedBox(height: 10),
                              Text(
                                userData['description'] ?? '',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> uploadPicture() async {
    String fileName = _image!.path.split('/').last;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('profile_images');
    Reference referenceImageToUpload = referenceDirImages.child(fileName);

    try {
      await referenceImageToUpload.putFile(_image!);
      imageUrl = await referenceImageToUpload.getDownloadURL();
      await postDetailsToFirestore();
      Fluttertoast.showToast(msg: 'Profile Picture Uploaded Successfully');
      // You can add your own UI feedback here
    } catch (error) {
      print('Error uploading image: $error');
      // You can add your own UI feedback here
      return null;
    }
  }

  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    try {
      await user?.updateProfile(photoURL: imageUrl);

      if (user != null) {
        await firebaseFirestore.collection("users").doc(user.uid).update({
          'profileImage': imageUrl,
        });
      }

      setState(() {
        _imageKey = UniqueKey(); // Force refresh the image
      });

      // You can add your own UI feedback here
    } catch (e) {
      print('Navigation error: $e');
      // You can add your own UI feedback here
    }
  }
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


//////////////////////////////////////////////////
class UpdateCreator extends StatefulWidget {
  @override
  _UpdateCreatorState createState() => _UpdateCreatorState();
}

class _UpdateCreatorState extends State<UpdateCreator> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramSubscriberController = TextEditingController();
  TextEditingController youtubeSubscriberController = TextEditingController();
  TextEditingController facebookSubscriberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  String? selectedGender;
  List<String> selectedNiches = [];

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  void fetchUserDetails() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
      await _firestore.collection("users").doc(user.uid).get();

      if (userDoc.exists) {
        setState(() {
          firstNameController.text = userDoc['firstName'];
          addressController.text = userDoc['address'];
          phoneController.text = userDoc['phone'];
          selectedGender = userDoc['gender'];
          emailController.text = userDoc['email'];
          instagramController.text = userDoc['instagram'];
          youtubeController.text = userDoc['youtube'];
          facebookController.text = userDoc['facebook'];
          instagramSubscriberController.text =
              userDoc['instagramSubscriber'].toString();
          youtubeSubscriberController.text =
              userDoc['youtubeSubscriber'].toString();
          facebookSubscriberController.text =
              userDoc['facebookSubscriber'].toString();
          descriptionController.text = userDoc['description'];
          rateController.text = userDoc['rate'].toString();
          selectedNiches = List.from(userDoc['niche']);
          middleNameController.text = userDoc['middleName'];
          lastNameController.text = userDoc['lastName'];
        });
      }
    }
  }


  void updateProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      UserModel userModel = UserModel(
        email: user.email,
        uid: user.uid,
        userType: 'Creator',
        firstName: firstNameController.text,
        middleName: middleNameController.text,
        lastName: lastNameController.text,
        address: addressController.text,
        gender: selectedGender.toString(),
        phone: phoneController.text,
        instagram: instagramController.text,
        youtube: youtubeController.text,
        facebook: facebookController.text,
        instagramSubscriber: int.parse(instagramSubscriberController.text),
        youtubeSubscriber: int.parse(youtubeSubscriberController.text),
        facebookSubscriber: int.parse(facebookSubscriberController.text),
        niche: selectedNiches.toString(),
        description: descriptionController.text,
        rate: double.parse(rateController.text),
      );

      await _firestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap())
          .then((_) {
        // Show a success popup when the profile is updated
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Profile Updated", style: TextStyle(color: Colors.teal)),
              content: Text("Your profile has been updated successfully!", style: TextStyle(color: Colors.teal)),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK", style: TextStyle(color: Colors.teal)),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        // Handle any error that might occur during the update
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error", style: TextStyle(color: Colors.teal)),
              content: Text("An error occurred while updating your profile.", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.teal,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK", style: TextStyle(color: Colors.teal)),
                ),
              ],
            );
          },
        );
      });
    }
  }




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
        SizedBox(height: 10),
        TextFormField(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

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
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextFormField(
                  controller: facebookController,
                  decoration: InputDecoration(
                    labelText: 'Facebook Handle',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: facebookSubscriberController,
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
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rate',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

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
          'Select Niche',
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
                      color: selectedNiches.contains(location['niche'])
                          ? Colors.white
                          : location['color'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Influencer Profile'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
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
                    updateProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    minimumSize: Size(150, 50),
                  ),
                  child: const Text(
                    'Update Profile',
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


////////////////////////////////////////////////////////////////////////////////////////



class NotificationPage extends StatefulWidget {
  final UserModel userModel;
  NotificationPage({Key? key, required this.userModel}) : super(key: key);


  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getNotifications() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('work_requests')
        .where('receiverId', isEqualTo: widget.userModel.email )
        .get();
    return querySnapshot.docs;
  }

  void refreshPage() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getNotifications(),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('You have no any notificaitons yet.'),
            );
          } else {
            List<DocumentSnapshot> notifications = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var notification in notifications)
                      NotificationItem(

                        //name should come of company
                        // profileImage: notification['profileImage'],
                        name: notification['fname'] ?? '',
                        status: notification['status'] ?? '',
                        senderId: notification['senderId'] ?? '',
                        userModel: widget.userModel,
                        companyModel: CompanyModel(),
                        firebaseFirestore: firebaseFirestore,
                        refreshPage: refreshPage,
                      ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }
        },
      ),

    );
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////

class NotificationItem extends StatelessWidget {
  // final String profileImage;
  final String name;
  final String status;
  final String senderId;
  final UserModel userModel;
  final CompanyModel companyModel;
  final FirebaseFirestore firebaseFirestore;
  final void Function() refreshPage;

  NotificationItem({
    // required this.profileImage,
    required this.name,
    required this.status,
    required this.senderId,
    required this.userModel,
    required this.companyModel,
    required this.firebaseFirestore,
    required this.refreshPage,
  });

  @override
  Widget build(BuildContext context) {
    bool isWorkRequestPending = status == 'Pending';
    bool isWorkRequestAccepted = status == 'Accepted';
    bool isWorkRequestDeclined = status == 'Declined';

    return Card(
      elevation: 2,
      child: ListTile(

        title: Text(
          "${name}",
          style: TextStyle(fontWeight: FontWeight.bold,),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('wants to work with you'),
            SizedBox(height: 8),
            Text(
              status,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isWorkRequestPending)
                  ElevatedButton(
                    onPressed: () {
                      _updateWorkRequestStatus('Accepted', context, senderId);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Accepted Work Request of: ${name}'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Accept'),
                  ),
                SizedBox(width: 8),
                if (isWorkRequestPending || isWorkRequestAccepted)
                  OutlinedButton(
                    onPressed: () {
                      _showDeclineConfirmationDialog(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text('Decline'),
                  ),
              ],
            ),
            SizedBox(height: 8),
            // Add more widgets as needed...
          ],
        ),
      ),
    );
  }

  void _showDeclineConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Decline Work Request'),
          content: Text(
            'You won\'t be able to accept the work request after declining. By tapping confirm, you will decline the work request sent by ${name}. Are you sure you want to decline?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateWorkRequestStatus('Declined', context, senderId);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Declined Work Request of: ${name}'),
                  ),

                );

                Navigator.of(dialogContext).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _updateWorkRequestStatus(String newStatus, BuildContext context, String email) async {
    try {
      CollectionReference workRequestsCollection =
      firebaseFirestore.collection('work_requests');

      QuerySnapshot workRequestsQuery = await workRequestsCollection
          .where('receiverId', isEqualTo: userModel.email)
          .where('senderId', isEqualTo: email)

          .get();

      if (workRequestsQuery.docs.isNotEmpty) {
        DocumentSnapshot workRequestDoc = workRequestsQuery.docs.first;

        String currentStatus = workRequestDoc['status'];

        if (currentStatus != 'Declined') {
          await workRequestsCollection
              .doc(workRequestDoc.id)
              .update({'status': newStatus});

          // Refresh the page after updating the status
          refreshPage();
        } else {
          // The work request has already been declined, notify the user or handle accordingly
          print('Cannot accept a declined work request');
        }
      } else {
        print('No matching work request found');
      }
    } catch (e) {
      print('Error updating work request status: $e');
    }
  }



}
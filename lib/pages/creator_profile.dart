import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendmasterass2/model/work_request_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/user_model.dart';

class InfluencerProfile extends StatefulWidget {
  final UserModel userModel;
  final CompanyModel companyModel;
  final bool workRequestSent;

  InfluencerProfile(
      {Key? key, required this.userModel, required this.companyModel, required this.workRequestSent})
      : super(key: key);

  @override
  State<InfluencerProfile> createState() => _InfluencerProfileState();
}

class _InfluencerProfileState extends State<InfluencerProfile> {
  bool _workRequestSent = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  WorkRequestModel? _fetchedWorkRequest;

  @override
  void initState() {
    super.initState();
    _fetchWorkRequestData();
    _workRequestSent = widget.workRequestSent;
  }

  void _fetchWorkRequestData() async {
    try {
      // Get a reference to the 'work_requests' collection
      CollectionReference workRequestsCollection = firebaseFirestore.collection('work_requests');

      // Use the where clause to filter the documents based on creator and company emails
      QuerySnapshot workRequestsQuery = await workRequestsCollection
          .where('receiverId', isEqualTo: widget.userModel.email)
          .where('senderId', isEqualTo: widget.companyModel.email)
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
        title: Text("Creator's Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Profile Description Section
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${widget.userModel.firstName ?? ''} ${widget.userModel.middleName ?? ''} ${widget.userModel.lastName ?? ''}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.red,
                          ),
                          Text(
                            "${widget.userModel.address}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        '${widget.userModel.description}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Area of Expertise',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              '${widget.userModel.niche}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.teal[100],
                      ),
                      height: 60,
                      width: 250,
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          if (!_workRequestSent) {
                            _showConfirmationPopup(context,
                                "Are you sure you want to work with ${widget.userModel.firstName ?? ''} ${widget.userModel.middleName ?? ''} ${widget.userModel.lastName ?? ''}?");
                          } else {
                            // Toggle back to "Let's work together" when clicked again
                            setState(() {
                              _showCancellationPopup(context,
                                  "Are you sure you want to cancel your work request with ${widget.userModel.firstName ?? ''} ${widget.userModel.middleName ?? ''} ${widget.userModel.lastName ?? ''}?");
                            });
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _workRequestSent
                                  ? "Work Request Sent"
                                  : "Let's work together",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _workRequestSent
                                  ? ""
                                  : "Creators Rate Per Creative: Rs. 5000/-",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Social Media Details Section
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSocialMediaColumn(
                      'assets/images/fb_logo.png',
                      '${widget.userModel.facebookSubscriber}',
                    ),
                    _buildSocialMediaColumn(
                      'assets/images/insta_logo.png',
                      '${widget.userModel.instagramSubscriber}',
                    ),
                    _buildSocialMediaColumn(
                      'assets/images/youtube_logo.png',
                      '${widget.userModel.youtubeSubscriber}',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Worked With Companies
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Worked with Companies",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCompanyLogo('assets/images/logo.png'),
                        _buildCompanyLogo('assets/images/logo.png'),
                        _buildCompanyLogo('assets/images/logo.png'),
                        _buildCompanyLogo('assets/images/logo.png'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 36,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          "ADD MORE",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Gallery
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildGalleryImage('assets/images/logo.png'),
                        _buildGalleryImage('assets/images/logo.png'),
                        _buildGalleryImage('assets/images/logo.png'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildGalleryImage('assets/images/logo.png'),
                        _buildGalleryImage('assets/images/logo.png'),
                        _buildGalleryImage('assets/images/logo.png'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 36,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          "ADD MORE",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }















  // Function to add social media links
  Widget _buildSocialMediaColumn(String imagePath, String followers) {
    return InkWell(
      onTap: () {
        if (imagePath.contains('fb_logo.png')) {
          _launchSocialMedia('https://www.facebook.com/profile.php?id=100008392064480');
        } else if (imagePath.contains('insta_logo.png')) {
          _launchSocialMedia('https://www.instagram.com/ruuuchi.b/');
        } else if (imagePath.contains('youtube_logo.png')) {
          _launchSocialMedia('https://www.youtube.com/watch?v=4T7HwLGNiuw&ab_channel=ChillVibes');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 50, width: 50),
          SizedBox(height: 10),
          Text(
            followers,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
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

// Function to upload picture in profile
  Widget _buildCompanyLogo(String imagePath) {
    return Image.asset(imagePath, height: 80, width: 80);
  }

  Widget _buildGalleryImage(String imagePath) {
    return Image.asset(imagePath, height: 80, width: 80);
  }

  postDetailsToFirestore() async {

    User? user = _auth.currentUser;

    WorkRequestModel workRequestModel = WorkRequestModel(
      senderId: widget.companyModel.email,
      receiverId: widget.userModel.email,
      status: 'Pending'
    );

    try {
      CollectionReference workRequestsCollection = firebaseFirestore.collection('work_requests');

      // Use the where clause to filter the documents based on creator and company emails
      QuerySnapshot workRequestsQuery = await workRequestsCollection
          .where('receiverId', isEqualTo: widget.userModel.email)
          .where('senderId', isEqualTo: widget.companyModel.email)
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
            .collection("work_requests")
            .doc()
            .set(workRequestModel.toMap());
      }
    } catch (e) {
      print('Error updating work request status: $e');
    }
  }



  // Function to update the status in Firestore based on conditions
  void _updateWorkRequestStatus(String newStatus) async {
    Fluttertoast.showToast(msg: 'out function');

    if (_workRequestSent == true) {
      Fluttertoast.showToast(msg: 'inside the function');
      Text('hello');
      try {
        CollectionReference workRequestsCollection = firebaseFirestore.collection('work_requests');

        // Use the where clause to filter the documents based on creator and company emails
        QuerySnapshot workRequestsQuery = await workRequestsCollection
            .where('receiverId', isEqualTo: widget.userModel.email)
            .where('senderId', isEqualTo: widget.companyModel.email)
            .get();

        // Check if there are any matching documents
        if (workRequestsQuery.docs.isNotEmpty) {
          // Assuming you only expect one document, you can access the first one
          DocumentSnapshot workRequestDoc = workRequestsQuery.docs.first;

          // Update the document with the new status
          await workRequestsCollection
              .doc(workRequestDoc.id)
              .update({'status': "newStatus"});

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
                        // Update the status to "Cancelled" in Firestore
                        if (_workRequestSent == true) {
                          _updateWorkRequestStatus('Cancelled');
                        }

                        setState(() {
                          _workRequestSent = false;
                        });
                        // postDetailsToFirestore();
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

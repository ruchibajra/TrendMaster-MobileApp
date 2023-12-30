import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user_model.dart';




class InfluencerProfile extends StatefulWidget {
  final UserModel userModel;
  final bool workRequestSent;

  InfluencerProfile({Key? key, required this.userModel, required this.workRequestSent}) : super(key: key);

  @override
  State<InfluencerProfile> createState() => _InfluencerProfileState();
}

class _InfluencerProfileState extends State<InfluencerProfile> {
  bool _workRequestSent = false;

  @override
  void initState() {
    super.initState();
    _workRequestSent = widget.workRequestSent;
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
                      backgroundImage:
                      AssetImage('assets/images/logo.png'),
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
                            _showConfirmationPopup(context, "Are you sure you want to work with ${widget.userModel.firstName ?? ''} ${widget.userModel.middleName ?? ''} ${widget.userModel.lastName ?? ''}?");
                          } else {
                            // Toggle back to "Let's work together" when clicked again
                            setState(() {
                              _showCancellationPopup(context, "Are you sure you want to cancel your work request with ${widget.userModel.firstName ?? ''} ${widget.userModel.middleName ?? ''} ${widget.userModel.lastName ?? ''}?");
                            });
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _workRequestSent ? "Work Request Sent" : "Let's work together",
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

  Widget _buildSocialMediaColumn(String imagePath, String followers) {
    return Column(
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
    );
  }

  Widget _buildCompanyLogo(String imagePath) {
    return Image.asset(imagePath, height: 80, width: 80);
  }

  Widget _buildGalleryImage(String imagePath) {
    return Image.asset(imagePath, height: 80, width: 80);
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

                        setState(() {
                          _workRequestSent = false;
                        });
                        Navigator.of(context).pop();
                        _showToast("Work request cancelled successfully"); // Show toast here

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
                        setState(() {
                          _workRequestSent = true;
                        });
                        Navigator.of(context).pop();
                        _showToast("Work request sent successfully"); // Show toast here

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


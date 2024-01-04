import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendmasterass2/model/user_model.dart';
import 'package:trendmasterass2/pages/creator_profile_self.dart';
import 'package:trendmasterass2/pages/promote_page.dart';
import '../model/work_request_model.dart';
import 'company_notification_page.dart';
import 'creator_profile.dart';
import 'login_page.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text("For You"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                Container(
                  color: Colors.teal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                        AssetImage('assets/images/companyProfile.png'),
                      ),
                      SizedBox(
                        width: 10,
                        height: 200,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back, \n ${widget.userModel.firstName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${widget.userModel.address}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.home, size: 30, color: Colors.grey),
                        title:
                        Text('Home', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading:
                        Icon(Icons.person, size: 30, color: Colors.grey),
                        title: Text('Profile',
                            style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreatorProfileSelf(
                                  userModel: widget.userModel, companyModel: CompanyModel(),)));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications,
                            size: 30, color: Colors.grey),
                        title: Text('Notification',
                            style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NotificationPage()));
                        },
                      ),
                      ListTile(
                        leading:
                        Icon(Icons.logout, size: 30, color: Colors.grey),
                        title: Text('Logout',
                            style: TextStyle(color: Colors.black)),
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
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.teal,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  _onTabTapped(0);
                },
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  _onTabTapped(1);
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  _onTabTapped(2);
                },
              ),
              IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  _onTabTapped(3);
                },
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        return NotificationPage();

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
                        builder: (context) =>
                            CampaignDetailsPage(userModel: widget.userModel,
                              campaignData: campaignData[index],),
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
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              campaignData[index]['location'] as String? ?? '',
                              style: TextStyle(fontSize: 16),
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
                                  builder: (context) =>
                                      CampaignDetailsPage(userModel: widget.userModel,
                                        campaignData: campaignData[index],),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: Text("View Campaign"),
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

//starts here
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
    // _workRequestSent = widget.workRequestSent;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.userModel.email}"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
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
            SizedBox(height: 24.0),
            Text(
              widget.campaignData['title'] as String? ?? '',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.campaignData['location'] as String? ?? '',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              widget.campaignData['niche'] as String? ?? '',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              widget.campaignData['description'] as String? ?? '',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              widget.campaignData['budget'] as String? ?? '',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              widget.campaignData['userId'] as String? ?? '',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),

            ElevatedButton(
              onPressed: () {
                if (!_workRequestSent) {
                  _showConfirmationPopup(context,
                      "Are you sure you want to work together? ");
                } else {
                  // Toggle back to "Let's work together" when clicked again
                  setState(() {
                    _showCancellationPopup(context,
                        "Are you sure you want to cancel your work request with ${widget.userModel.firstName ?? ''} ${widget.userModel.middleName ?? ''} ${widget.userModel.lastName ?? ''}?");
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _workRequestSent
                      ? 'Work Request Sent'
                      : "Let's Work Together",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  postDetailsToFirestore() async {

    WorkRequestModel workRequestModel = WorkRequestModel(
        senderId: widget.userModel.email,
        receiverId:widget.campaignData['userId'] as String? ?? '',
        status: 'Pending'
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
                        postDetailsToFirestore();
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
    Fluttertoast.showToast(msg: 'out function');

    if (_workRequestSent == true) {
      Fluttertoast.showToast(msg: 'inside the function');
      Text('hello');
      try {
        CollectionReference workRequestsCollection = firebaseFirestore.collection('campaign'
            '_requests');

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

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          if (snapshot.data == null) {
            return Center(child: Text('You are not authenticated.'));
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${snapshot.data!.email}!'),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(snapshot.data!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final userData =
                        snapshot.data!.data() as Map<String, dynamic>;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('First Name: ${userData['firstName']}'),
                            Text('Last Name: ${userData['lastName']}'),
                            Text('Phone: ${userData['phone']}'),
                            Text('Address: ${userData['address']}'),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationItem(
                title: 'New Message',
                subtitle: 'You have a new message from John Doe.',
                timestamp: '2 hours ago',
                image: 'assets/message_icon.png', // Replace with your image path
                onAccept: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Accepted: New Message'),
                    ),
                  );
                },
                onDecline: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Declined: New Message'),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              // Add more NotificationItems as needed
            ],
          ),
        ),
      ),

    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timestamp;
  final String image;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.image,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(subtitle),
            SizedBox(height: 8),
            Text(
              timestamp,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('Accept'),
                ),
                SizedBox(width: 8),
                OutlinedButton(
                  onPressed: onDecline,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                  ),
                  child: Text('Decline'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
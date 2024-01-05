import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';
import 'company_homepage.dart';
import 'company_profile.dart';
import 'promote_page.dart';

class NotificationPage extends StatefulWidget {
  final CompanyModel companyModel;
  NotificationPage({required this.companyModel});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int currentIndex = 2;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getNotifications() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('campaign_requests')
        .where('receiverId', isEqualTo: widget.companyModel.uid)
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
              child: Text('You have no any notifications yet.'),
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
                        fname: notification['fname'],
                        mname: notification['mname'],
                        lname: notification['lname'],
                        status: notification['status'],
                        userModel: UserModel(),
                        companyModel: widget.companyModel,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index != currentIndex) {
            Navigator.of(context).pop();
            setState(() {
              currentIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CompanyHomePage(
                      companyModel: widget.companyModel,
                    ),
                  ),
                );
                break;
              case 1:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PromotionPage(
                      companyModel: widget.companyModel,
                    ),
                  ),
                );
                break;
              case 3:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CompanyProfile(
                      companyModel: widget.companyModel,
                    ),
                  ),
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
}

class NotificationItem extends StatelessWidget {
  final String fname;
  final String mname;
  final String lname;
  final String status;
  final UserModel userModel;
  final CompanyModel companyModel;
  final FirebaseFirestore firebaseFirestore;
  final void Function() refreshPage;

  NotificationItem({
    required this.fname,
    required this.mname,
    required this.lname,
    required this.status,
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
        leading: CircleAvatar(
          //profile image halnu parcha
        ),
        title: Text(
          "${fname} ${mname} ${lname}",
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
                      _updateWorkRequestStatus('Accepted', context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Accepted Work Request of: ${fname} ${mname} ${lname}'),
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

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Declined Work Request of: ${fname} ${mname} ${lname}'),
                        ),
                      );
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
            'You won\'t be able to accept the work request after declining. By tapping confirm, you will decline the work request sent by ${fname} ${mname} ${lname}. Are you sure you want to decline?',
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
                _updateWorkRequestStatus('Declined', context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Declined Work Request of: ${fname} ${mname} ${lname}'),
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

  void _updateWorkRequestStatus(String newStatus, BuildContext context) async {
    try {
      CollectionReference workRequestsCollection =
      firebaseFirestore.collection('campaign_requests');

      QuerySnapshot workRequestsQuery = await workRequestsCollection
          .where('receiverId', isEqualTo: companyModel.uid)
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

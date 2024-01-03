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

  // Function to fetch notification data from Firebase
  Future<List<DocumentSnapshot>> getNotifications() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('campaign_requests')
        .where('receiverId', isEqualTo: widget.companyModel.uid)
        .where('status', isEqualTo: 'Pending')
        .get();

    return querySnapshot.docs;
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
          }else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('${widget.companyModel.uid}'),
            );
          } else {
            List<DocumentSnapshot> notifications = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Map Firebase data to NotificationItem widgets
                    for (var notification in notifications)
                      NotificationItem(
                        fname: notification['fname'],
                        mname: notification['mname'],
                        lname: notification['lname'],
                        status: notification['status'],
                        image: notification['senderId'],
                      ),
                    SizedBox(height: 16),
                    // Add more NotificationItems as needed
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
  final String image;


  NotificationItem({
    required this.fname,
    required this.mname,
    required this.lname,
    required this.status,
    required this.image,
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
                // ElevatedButton(
                //   onPressed: () {
                //     FirebaseFirestore.instance
                //         .collection('campaign_requests')
                //         .where('receiverId', isEqualTo: )
                //         .update({'status': 'Accepted'})
                //         .then((_) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text('Accepted Work Request of: ${fname} ${mname} ${lname}'),
                //         ),
                //       );
                //     }).catchError((error) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text('Error updating status: $error'),
                //         ),
                //       );
                //     });
                //   },
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.green,
                //   ),
                //   child: Text('Accept'),
                // ),
                SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Declined Work Request of: ${fname} ${mname} ${lname}'),
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
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationPage(
      companyModel: CompanyModel(),
    ),
  ));
}

import 'package:flutter/material.dart';

import '../model/user_model.dart';
import 'company_detail_page.dart';
import 'company_profile.dart';
import 'notification_page.dart';

class PromotionPage extends StatefulWidget {
  final CompanyModel companyModel;
  PromotionPage({required this.companyModel});

  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  int currentIndex = 0;
  bool isPromotionClaimed = false;
  double rating = 0.0;

  void _showClaimedDialog() {
    setState(() {
      isPromotionClaimed = true;
    });
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
          'Promotion',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200], // Set the desired background color
      body: Column(
        children: [
          SizedBox(height: 110),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/mic1.png',
              width: 200,
              height: 200,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Special Offer Just for You!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Grab this special opportunity now!',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddDetailsPage(companyModel: widget.companyModel)));
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.teal, // Set the background color to teal
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Promote',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.teal, // Color when item is selected
        unselectedItemColor: Colors.grey, // Color when item is not selected
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          // Handle navigation based on the index
          if (index == 0) {
            // Navigate to Home
          } else if (index == 1) {
            // Navigate to Promote
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PromotionPage(companyModel: widget.companyModel)),
            );
          } else if (index == 2) {
            // Navigate to Notification
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
          } else if (index == 3){
            // Navigate to Notification
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CompanyProfile(companyModel: widget.companyModel,)),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Promote',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
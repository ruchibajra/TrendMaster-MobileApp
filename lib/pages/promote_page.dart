import 'package:flutter/material.dart';
import 'package:trendmasterass2/pages/company_homepage.dart';
import '../model/user_model.dart';
import 'company_profile.dart';
import 'notification_page.dart';

class PromotionPage extends StatefulWidget {
  final CompanyModel companyModel;
  PromotionPage({required this.companyModel});

  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  int currentIndex = 1; // Set the initial index to 1 for PromotionPage
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
      backgroundColor: Colors.grey[200],
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
                // Your content here
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index != currentIndex) {
            Navigator.of(context).pop();
            setState(() {
              currentIndex = index; // Update currentIndex when navigating
            });
            switch (index) {
              case 0:
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CompanyHomePage(companyModel: widget.companyModel)),
                );
                break;
              case 2:
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotificationPage(companyModel: widget.companyModel)),
                );
                break;
              case 3:
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CompanyProfile(companyModel: widget.companyModel)),
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

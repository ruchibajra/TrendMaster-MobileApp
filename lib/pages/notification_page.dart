import 'package:flutter/material.dart';
import '../model/user_model.dart';
import 'company_homepage.dart';
import 'company_profile.dart';
import 'package:trendmasterass2/pages/promote_page.dart';

class NotificationPage extends StatefulWidget {
  final CompanyModel companyModel;
  NotificationPage({required this.companyModel});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int currentIndex = 2; // Set the initial index to 2 for NotificationPage

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationItem(
              title: 'New Message',
              subtitle: 'You have a new message from John Doe.',
              timestamp: '2 hours ago',
              image: 'assets/message_icon.png', // Replace with your image path
            ),
            SizedBox(height: 16),
            NotificationItem(
              title: 'Reminder',
              subtitle: 'Don\'t forget to submit your project by tomorrow.',
              timestamp: '1 day ago',
              image: 'assets/reminder_icon.png', // Replace with your image path
            ),
            SizedBox(height: 16),
            // Add more NotificationItems as needed
          ],
        ),
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
              case 1:
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PromotionPage(companyModel: widget.companyModel)),
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

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timestamp;
  final String image;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.timestamp,
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
          ],
        ),
      ),
    );
  }
}

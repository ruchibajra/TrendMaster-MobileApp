import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationItem(
                title: 'New Message',
                subtitle: 'You have a new message from John Doe.',
                timestamp: '2 hours ago',
                image:
                'assets/message_icon.png', // Replace with your image path
              ),
              SizedBox(height: 16),
              NotificationItem(
                title: 'Reminder',
                subtitle: 'Don\'t forget to submit your project by tomorrow.',
                timestamp: '1 day ago',
                image:
                'assets/reminder_icon.png', // Replace with your image path
              ),
              SizedBox(height: 16),
              NotificationItem(
                title: 'Event Invitation',
                subtitle: 'You are invited to the company\'s annual party.',
                timestamp: '3 days ago',
                image: 'assets/event_icon.png', // Replace with your image path
              ),
              SizedBox(height: 16),
              NotificationItem(
                title: 'Discount Offer',
                subtitle:
                'Get 20% off on your next purchase with code: DISCOUNT20',
                timestamp: '4 days ago',
                image:
                'assets/discount_icon.png', // Replace with your image path
              ),
              SizedBox(height: 16),
              NotificationItem(
                title: 'Product Update',
                subtitle: 'Check out the latest features in our app update.',
                timestamp: '5 days ago',
                image: 'assets/update_icon.png', // Replace with your image path
              ),
              // Add more NotificationItems as needed
            ],
          ),
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
                  MaterialPageRoute(
                      builder: (context) =>
                          CompanyHomePage(companyModel: widget.companyModel)),
                );
                break;
              case 1:
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          PromotionPage(companyModel: widget.companyModel)),
                );
                break;
              case 3:
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          CompanyProfile(companyModel: widget.companyModel)),
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
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add your accept functionality here
                    // You can use the context to perform any navigation or other actions
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Accepted: $title'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('Accept'),
                ),
                SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    // Add your decline functionality here
                    // You can use the context to perform any navigation or other actions
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Declined: $title'),
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
      companyModel: CompanyModel(), // Pass your CompanyModel instance here
    ),
  ));
}
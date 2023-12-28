import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: NotificationPage(),
    ),
  );
}

class NotificationPage extends StatelessWidget {
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
              ),
              SizedBox(height: 16),
              NotificationItem(
                title: 'Reminder',
                subtitle: 'Don\'t forget to submit your project by tomorrow.',
                timestamp: '1 day ago',
                image: 'assets/reminder_icon.png', // Replace with your image path
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
                subtitle: 'Get 20% off on your next purchase with code: DISCOUNT20',
                timestamp: '4 days ago',
                image: 'assets/discount_icon.png', // Replace with your image path
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30, color: Colors.grey),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30, color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 30, color: Colors.grey),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30, color: Colors.grey),
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

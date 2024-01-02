import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: CreatorHomePage(),
    );
  }
}

class CreatorHomePage extends StatefulWidget {
  @override
  _CreatorHomePageState createState() => _CreatorHomePageState();
}

class _CreatorHomePageState extends State<CreatorHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("For You"),
        centerTitle: true,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      case 3:
        return MessagePage();
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
                            CampaignDetailsPage(campaignData[index]),
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
                                      CampaignDetailsPage(campaignData[index]),
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

class CampaignDetailsPage extends StatelessWidget {
  final Map<String, dynamic> campaignData;

  CampaignDetailsPage(this.campaignData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaign Details"),
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
                child: CachedNetworkImage(
                  imageUrl: campaignData['image'] as String? ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              campaignData['title'] as String? ?? '',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description: ${campaignData['description'] as String? ?? ''}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              'Location: ${campaignData['location'] as String? ?? ''}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              'Niche: ${campaignData['niche'] as String? ?? ''}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              'Creator Number: ${campaignData['creator_no'] as String? ?? ''}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              'Budget: ${campaignData['budget'] as String? ?? ''}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Implement the logic for accepting the campaign here.
                // You can use the campaignData to perform actions related to the accepted campaign.
                // For example, you may want to update the database or perform other operations.
                // Customize this logic based on your requirements.
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.teal,
                shape:
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Accept Campaign',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
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

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Messages Page - Under Construction'),
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Notifications Page - Under Construction'),
      ),
    );
  }
}
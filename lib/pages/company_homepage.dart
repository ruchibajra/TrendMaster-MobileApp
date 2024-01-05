import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trendmasterass2/pages/company_profile.dart';
import 'package:trendmasterass2/pages/creator_profile.dart';
import 'package:trendmasterass2/pages/login_page.dart';
import 'package:trendmasterass2/pages/promote_page.dart';
import 'package:trendmasterass2/pages/search_page.dart';
import '../model/user_model.dart';
import 'company_notification_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompanyHomePage extends StatefulWidget {
  final CompanyModel companyModel;

  CompanyHomePage({Key? key, required this.companyModel}) : super(key: key);

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;
  final List<String> images = [
    'assets/images/img.png',
    'assets/images/marketing_pic1.png',
  ];

  Future<List<UserModel>> getCreatorData() async {
    var snapshot = await FirebaseFirestore.instance.collection('users').get();

    List<UserModel> creators = [];

    for (var doc in snapshot.docs) {
      creators.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    return creators;
  }

  @override
  Widget build(BuildContext context) {
    key: _scaffoldKey;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text("Home"),
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,  // Set the background color of the circle
                          child: Icon(
                            FontAwesomeIcons.building,  // Organization icon from font_awesome_flutter
                            size: 50,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                        height: 200,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.companyModel.name}',
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
                                '${widget.companyModel.address}',
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
                        leading:
                        Icon(Icons.person, size: 30, color: Colors.grey),
                        title: Text('Profile',
                            style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompanyProfile(
                                  companyModel: widget.companyModel)));
                        },
                      ),
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
                        Icon(Icons.menu_book, size: 30, color: Colors.grey),
                        title: Text('Promote',
                            style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PromotionPage(
                                  companyModel: widget.companyModel)));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications,
                            size: 30, color: Colors.grey),
                        title: Text('Notification',
                            style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NotificationPage(companyModel: widget.companyModel)));
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
      body: FutureBuilder<List<UserModel>>(
        future: getCreatorData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('ERROR: ${snapshot.error}');
          } else {
            List<UserModel> creators = snapshot.data ?? [];

            if (creators.isEmpty) {
              return Text('No any data yet.');
            }
            List<UserModel> creatorList = creators
                .where((creator) => creator.userType == 'Creator')
                .toList();

            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 5),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          Container(
                            width: 190,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchPage(companyModel: widget.companyModel), // Replace SearchPage with your desired page
                                  ),
                                );
                              },
                              child: const Text(
                                "Search",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      color: Colors.red,
                      height: 180,
                      child: PageView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 60,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildCategory('Motivation'),
                          buildCategory('Lifestyle'),
                          buildCategory('Education'),
                          buildCategory('Fashion'),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Creators',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      UserModel creator = creatorList[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfluencerProfile(
                                companyModel: widget.companyModel,
                                userModel: creator,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          subtitle: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFD2EBE7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 110,
                                      width: 100,
                                      child: Image.asset(
                                        'assets/images/foodie_nepal.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 210,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Colors.teal,
                                            ),
                                            child: Text(
                                              "${creator.niche ?? ''}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${creator.firstName ?? ''} ${creator.middleName ?? ''} ${creator.lastName ?? ''}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    buildSocialMediaIcon(
                                                      'assets/images/fb_logo.png',
                                                      creator
                                                          .facebookSubscriber
                                                          .toString(),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    buildSocialMediaIcon(
                                                      'assets/images/insta_logo.png',
                                                      creator
                                                          .instagramSubscriber
                                                          .toString(),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    buildSocialMediaIcon(
                                                      'assets/images/youtube_logo.png',
                                                      creator
                                                          .youtubeSubscriber
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Rs.${creator.rate} per content",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: creatorList.length,
                  ),
                ),
              ],
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
            setState(() {
              currentIndex = index;
            });

            switch (index) {
              case 0:
              // Navigate to Home
                break;
              case 1:
              // Navigate to Promote
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PromotionPage(companyModel: widget.companyModel),
                  ),
                );
                break;
              case 2:
              // Navigate to Notification
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationPage(companyModel: widget.companyModel),
                  ),
                );
                break;
              case 3:
              // Navigate to Profile
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CompanyProfile(companyModel: widget.companyModel),
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
            label: 'Promote',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
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

  Widget buildCategory(String categoryName) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          categoryName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget buildSocialMediaIcon(String imagePath, String subscriberCount) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: 25,
          width: 25,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          subscriberCount,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
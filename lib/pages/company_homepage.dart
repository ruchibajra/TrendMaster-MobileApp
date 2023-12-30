import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trendmasterass2/pages/company_profile.dart';
import 'package:trendmasterass2/pages/creator_profile.dart';
import 'package:trendmasterass2/pages/login_page.dart';
import 'package:trendmasterass2/pages/notification_page.dart';
import 'package:trendmasterass2/pages/promote_page.dart';
import '../model/user_model.dart';

class CompanyHomePage extends StatefulWidget {
  final CompanyModel companyModel;
  CompanyHomePage({Key? key, required this.companyModel}) : super(key: key);

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  int currentIndex = 0;
  final List<String> images = [
    'assets/images/img.png',

    'assets/images/marketing_pic1.png',
  ];

  Future<List<UserModel>> getCreatorData() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();

    List<UserModel> creators = [];

    for (var doc in snapshot.docs) {
      creators.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    return creators;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar Start
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white, // Set the color to white
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text("Home"),
        centerTitle: true, // Center the title
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                // Container for profile name and location
                Container(
                  color: Colors.teal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/companyProfile.png'),
                      ),
                      SizedBox(width: 10, height: 200,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back, \n ${widget.companyModel.name}',
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

                // Container for list icons and names
                Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person, size: 30, color: Colors.grey),
                        title: Text('Profile', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CompanyProfile(companyModel: widget.companyModel)));                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.home, size: 30, color: Colors.grey),
                        title: Text('Home', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).pop();

                        },

                      ),
                      ListTile(
                        leading: Icon(Icons.menu_book, size: 30, color: Colors.grey),
                        title: Text('Promote', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => PromotionPage(companyModel: widget.companyModel)));},
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, size: 30, color: Colors.grey),
                        title: Text('Notification', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => NotificationPage()));                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout, size: 30, color: Colors.grey),
                        title: Text('Logout', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          // Show logout confirmation dialog
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

            if (creators.isEmpty){
              return Text('data is empty');
            }
            List<UserModel> creatorList =creators.where((creator) => creator.userType == 'Creator').toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  //Search Bar Start
                  Container(
                    height: 50, // Increased height
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(10), // Added border radius
                    ),


                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Icon(Icons.search, color: Colors.white), // Search Icon
                        ),
                        Container(
                          width: 190,
                          child: const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration.collapsed(
                              hintText: "Search a Creator",
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                  SizedBox(height: 10),

                  //Search Bar End

                  Container(
                    color: Colors.red,
                    height: 180,

                    child: PageView.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Image.asset(images[index], fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  //Image Slide End

                  //Category Text Section
                  Center(
                    child: Text(
                      'Categories', // Add the location here
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Category Text Section

                  //Category List Slide Section Start
                  Container(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(right: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Motivation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(right: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Lifestyle',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(right: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Education',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(right: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Fashion',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  //Category List Slide Section End

                  //Creator Title Text Section Start
                  Text(
                    'Creators', // Add the location here
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  //Creator Title Text Section End

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: creatorList.length,
                    itemBuilder: (context, index) {

                      //UserModel is Creator's Data
                      UserModel creator = creatorList[index];

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfluencerProfile(userModel:creator, workRequestSent: false ,), // Pass the UserModel to the new page
                            ),
                          );
                        },
                        child:ListTile(
                        subtitle: Container(
                          color: Color(0xFFD2EBE7),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center, // Align vertically to the center
                                children: [
                                  //Profile Image
                                  Container(
                                    // color: Colors.white,
                                    height: 110,
                                    width: 100,
                                    child:
                                    Image.asset('assets/images/foodie_nepal.jpg'),),
                                  SizedBox(width: 10,),

                                  //Details of Creators
                                  Container(
                                    width: 210,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Align the text horizontally to the start
                                      children: [
                                        // Creators Niche
                                        Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.teal),
                                            child: Text(
                                              " ${creator.niche ?? ''}",
                                              style: TextStyle(fontSize: 12, color: Colors.white),
                                            )),
                                        SizedBox(height: 2,),

                                        // Creators Name
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${creator.firstName ?? ''} ${creator.middleName ?? ''} ${creator.lastName ?? ''}"),
                                              SizedBox(height: 5,),

                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/fb_logo.png',
                                                        fit: BoxFit.cover,
                                                        height: 25,
                                                        width: 25,
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Text(creator.facebookSubscriber.toString(), style: TextStyle(fontSize: 12),),
                                                    ],
                                                  ),
                                                  SizedBox(width: 8,),

                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/insta_logo.png',
                                                        fit: BoxFit.cover,
                                                        height: 25,
                                                        width: 25,
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Text(creator.instagramSubscriber.toString(),style: TextStyle(fontSize: 12),),
                                                    ],
                                                  ),
                                                  SizedBox(width: 8,),

                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/youtube_logo.png',
                                                        fit: BoxFit.cover,
                                                        height: 25,
                                                        width: 25,
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Text(creator.youtubeSubscriber.toString(),style: TextStyle(fontSize: 12),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5,),

                                              Container(
                                                child: Text("Rs.30,000 for 50.0K impressions", style: TextStyle(fontSize: 13),),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      );


                    },
                  ),
                ],
              ),
            );
          }
        },
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

// Function to show logout confirmation dialog in the center
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
                        // Add your logout logic here
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text('Yes', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal, // Teal color for the "No" button
                      ),
                      onPressed: () {
                        // Cancel the logout action
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
}
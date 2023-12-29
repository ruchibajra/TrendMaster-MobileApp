import 'package:flutter/material.dart';
import 'package:trendmasterass2/model/user_model.dart';

class InfluencerProfile extends StatefulWidget {
  final UserModel userModel;
  InfluencerProfile({Key? key, required this.userModel}) : super(key: key);

  @override
  State<InfluencerProfile> createState() => _InfluencerProfileState();
}

class _InfluencerProfileState extends State<InfluencerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white, // Set the color to white
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
            'Influencer Profile'
        ),
        centerTitle: true, // Center the title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Profile Description Section
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // Profile Image, Name, Location, and Edit Option
                    Center(
                      child: Column(
                        children: [
                          // Image
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                            AssetImage('assets/images/profile.png'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Influencer name and Location
                          Text(
                            '${widget.userModel.firstName}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                Text(
                                  '${widget.userModel.address}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),

                    // Multiline text centered
                    Center(
                      child: Text(
                        '${widget.userModel.description} ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 2),

                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Area of Expertise',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        '${widget.userModel.niche}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Social Media Details Section
              Container(
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Add space evenly
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Image.asset('assets/images/profile.png', height: 80, width: 80),
                        Container(
                          child: Text(
                            "${widget.userModel.youtube}",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Image.asset('assets/images/profile.png', height: 80, width: 80),
                        Container(
                          child: Text(
                            "${widget.userModel.facebook}",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Image.asset('assets/images/profile.png', height: 80, width: 80),
                        Container(
                          child: Text(
                            "${widget.userModel.instagram}",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              // Worked With Companies
              Container(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    Text(
                      "Worked with Companies",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 26,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.teal,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "ADD MORE",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              // Gallery
              Container(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                        Image.asset('assets/images/profile.png',
                            height: 80, width: 80),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Container(
                      height: 26,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.teal,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "ADD MORE",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, size: 30, color: Colors.grey),
            label: 'Explore',
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



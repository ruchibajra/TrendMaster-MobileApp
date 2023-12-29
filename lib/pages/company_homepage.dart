import 'package:flutter/material.dart';
import 'package:trendmasterass2/pages/promote_page.dart';
import '../model/user_model.dart';
import 'company_profile.dart';

class CompanyHomePage extends StatefulWidget {
  final CompanyModel companyModel;
  CompanyHomePage({Key? key, required this.companyModel}) : super(key: key);

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  final List<String> images = [
    'assets/images/influencers2.png',
    'assets/images/homepage1.png',
    'assets/images/influencers1.jpg',
    // Add more images as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar Start
      appBar: AppBar(
        // Add the hamburger icon to open the drawer
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white, // Set the color to white
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
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
                            'Hello \n ${widget.companyModel.name}',
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

                // Add space between the two containers
                SizedBox(height: 20),

                // Container for list icons and names
                Container(
                  // color: Colors.white, // You can use any color you prefer
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person, size: 30, color: Colors.grey),
                        title: Text('Profile', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CompanyProfile(companyModel: widget.companyModel)));},
                      ),
                      ListTile(
                        leading: Icon(Icons.home, size: 30, color: Colors.grey),
                        title: Text('Home', style: TextStyle(color: Colors.black)),
                        onTap: () {

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
                        title: Text('Notifications', style: TextStyle(color: Colors.black)),
                        onTap: () {
                          // Add your navigation logic here
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout, size: 30, color: Colors.grey),
                        title: Text('logout', style: TextStyle(color: Colors.black)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 10,
                height: 50, // Increased height
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(10), // Added border radius
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Icon(Icons.search, color: Colors.grey), // Search Icon
                    ),
                    Container(
                      width: 190,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration.collapsed(
                          hintText: "Search a Creator",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Text('${widget.companyModel.uid}'),
              // Intro Image Swipe Section
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

              //Category Title Section
              Container(
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

              //Category ListView Section
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

              //Creator Title Section
              Text(
                'Creators', // Add the location here
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Center(
                child: Column(
                  children: [

                    // Particular Creators Container
                    Container(
                      height: 150,
                      width: 350,
                      color: Color(0xFFD2EBE7),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center, // Align vertically to the center
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),

                            //Image of Creator
                            child: Container(
                              color: Colors.white,
                              height: 110,
                              width: 100,

                              child:
                              Image.asset('assets/images/foodie_nepal.jpg'),),
                          ),
                          SizedBox(width: 10,),

                          //Details of Creators
                          Container(
                            // color: Colors.white,
                            height: 130,
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align the text horizontally to the start
                              children: [

                                // Creators Niche
                                Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.teal),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Food", style: TextStyle(fontSize:12, color: Colors.white),),
                                    )),
                                SizedBox(height: 2,),

                                // Creators Name
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Mr. Foodie Nepal"),
                                      SizedBox(height: 5,),

                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("232K", style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("350K",style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("190K",style: TextStyle(fontSize: 12),),
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
                    ),
                    SizedBox(height: 5,),

                    //Dummy Code For Testing

                    Container(
                      height: 150,
                      width: 350,
                      color: Color(0xFFD2EBE7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center, // Align vertically to the center
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),

                            //Image of Creator
                            child: Container(
                              color: Colors.white,
                              height: 110,
                              width: 100,

                              child:
                              Image.asset('assets/images/foodie_nepal.jpg'),),
                          ),
                          SizedBox(width: 10,),

                          //Details of Creators
                          Container(
                            // color: Colors.white,
                            height: 130,
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align the text horizontally to the start
                              children: [

                                // Creators Niche
                                Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.teal),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Food", style: TextStyle(fontSize:12, color: Colors.white),),
                                    )),
                                SizedBox(height: 2,),

                                // Creators Name
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Mr. Foodie Nepal"),
                                      SizedBox(height: 5,),

                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("232K", style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("350K",style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("190K",style: TextStyle(fontSize: 12),),
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
                    ),
                    SizedBox(height: 5,),

                    Container(
                      height: 150,
                      width: 350,
                      color: Color(0xFFD2EBE7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center, // Align vertically to the center
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),

                            //Image of Creator
                            child: Container(
                              color: Colors.white,
                              height: 110,
                              width: 100,

                              child:
                              Image.asset('assets/images/foodie_nepal.jpg'),),
                          ),
                          SizedBox(width: 10,),

                          //Details of Creators
                          Container(
                            // color: Colors.white,
                            height: 130,
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align the text horizontally to the start
                              children: [

                                // Creators Niche
                                Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.teal),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Food", style: TextStyle(fontSize:12, color: Colors.white),),
                                    )),
                                SizedBox(height: 2,),

                                // Creators Name
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Mr. Foodie Nepal"),
                                      SizedBox(height: 5,),

                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("232K", style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("350K",style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("190K",style: TextStyle(fontSize: 12),),
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
                    ),
                    SizedBox(height: 5,),

                    Container(
                      height: 150,
                      width: 350,
                      color: Color(0xFFD2EBE7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center, // Align vertically to the center
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),

                            //Image of Creator
                            child: Container(
                              color: Colors.white,
                              height: 110,
                              width: 100,

                              child:
                              Image.asset('assets/images/foodie_nepal.jpg'),),
                          ),
                          SizedBox(width: 10,),

                          //Details of Creators
                          Container(
                            // color: Colors.white,
                            height: 130,
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align the text horizontally to the start
                              children: [

                                // Creators Niche
                                Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.teal),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Food", style: TextStyle(fontSize:12, color: Colors.white),),
                                    )),
                                SizedBox(height: 2,),

                                // Creators Name
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Mr. Foodie Nepal"),
                                      SizedBox(height: 5,),

                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("232K", style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("350K",style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("190K",style: TextStyle(fontSize: 12),),
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
                    ),
                    SizedBox(height: 5,),

                    Container(
                      height: 150,
                      width: 350,
                      color: Color(0xFFD2EBE7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center, // Align vertically to the center
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),

                            //Image of Creator
                            child: Container(
                              color: Colors.white,
                              height: 110,
                              width: 100,

                              child:
                              Image.asset('assets/images/foodie_nepal.jpg'),),
                          ),
                          SizedBox(width: 10,),

                          //Details of Creators
                          Container(
                            // color: Colors.white,
                            height: 130,
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align the text horizontally to the start
                              children: [

                                // Creators Niche
                                Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.teal),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Food", style: TextStyle(fontSize:12, color: Colors.white),),
                                    )),
                                SizedBox(height: 2,),

                                // Creators Name
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Mr. Foodie Nepal"),
                                      SizedBox(height: 5,),

                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("232K", style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("350K",style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(width: 8,),

                                          Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/foodie_nepal.jpg',
                                                fit: BoxFit.cover,
                                                height: 25,
                                                width: 25,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("190K",style: TextStyle(fontSize: 12),),
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
                    ),
                    SizedBox(height: 5,),


                  ],
                ),
              ),
            ],
          ),
        ),
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
                        primary: Colors.teal, // Teal color for the "Yes" button
                      ),
                      onPressed: () {
                        // Add your logout logic here
                        Navigator.of(context).pop();
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


